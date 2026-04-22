// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_contacts/flutter_contacts.dart' as fc;
import 'package:vcard_dart/vcard_dart.dart';

import '../../../core/constants/social_platform_resolver.dart';
import '../models/contact_field_selection.dart';

bool _includeItem(List<bool> items, int index, bool categoryFallback) {
  if (index < items.length) return items[index];
  return categoryFallback;
}

/// Builds vCard 3.0 string from [fc.Contact] with only selected fields.
/// Never includes photo (keeps QR within capacity).
String buildVCardFromContact(fc.Contact contact, [ContactFieldSelection? selection]) {
  final sel = selection ?? _fullSelectionForContact(contact);
  final vcard = VCard(version: VCardVersion.v30);

  // FN is required
  vcard.formattedName = contact.displayName?.trim().isNotEmpty == true
      ? contact.displayName!
      : 'Contact';

  // Name
  if (sel.name) {
    final n = contact.name;
    if (n != null) {
      final family = (n.last ?? '').trim();
      final given = (n.first ?? '').trim();
      final hasStructured = family.isNotEmpty || given.isNotEmpty ||
          (n.prefix ?? '').trim().isNotEmpty ||
          (n.middle ?? '').trim().isNotEmpty ||
          (n.suffix ?? '').trim().isNotEmpty;
      if (hasStructured) {
        vcard.name = StructuredName(
          family: family,
          given: given,
          prefixes: (n.prefix ?? '').trim().isNotEmpty ? [n.prefix!] : const [],
          suffixes: (n.suffix ?? '').trim().isNotEmpty ? [n.suffix!] : const [],
          additional: (n.middle ?? '').trim().isNotEmpty ? [n.middle!] : const [],
        );
      } else if ((contact.displayName ?? '').trim().isNotEmpty) {
        vcard.name = StructuredName.raw(contact.displayName!);
      }
    }
  }

  // Phones
  for (var i = 0; i < contact.phones.length; i++) {
    if (!_includeItem(sel.phoneItems, i, sel.phones)) continue;
    final p = contact.phones[i];
    final num = p.number.trim();
    if (num.isEmpty) continue;
    final tel = _phoneToTelephone(p);
    vcard.telephones.add(tel);
  }

  // Emails
  for (var i = 0; i < contact.emails.length; i++) {
    if (!_includeItem(sel.emailItems, i, sel.emails)) continue;
    final e = contact.emails[i];
    final addr = e.address.trim();
    if (addr.isEmpty) continue;
    final email = _emailToEmail(e);
    vcard.emails.add(email);
  }

  // Organizations (first selected → primary ORG/TITLE; rest → extra ORG/TITLE lines)
  final selectedOrgIndices = <int>[];
  for (var i = 0; i < contact.organizations.length; i++) {
    if (_includeItem(sel.organizationItems, i, sel.organizations)) {
      selectedOrgIndices.add(i);
    }
  }
  var primaryOrgSet = false;
  for (final idx in selectedOrgIndices) {
    final o = contact.organizations[idx];
    final name = (o.name ?? '').trim();
    if (name.isEmpty) continue;
    final units = <String>[];
    if ((o.departmentName ?? '').trim().isNotEmpty) {
      units.add(o.departmentName!);
    }
    final org = Organization(name: name, units: units);
    final title = (o.jobTitle ?? '').trim();
    if (!primaryOrgSet) {
      vcard.organization = org;
      if (title.isNotEmpty) {
        vcard.title = title;
      }
      primaryOrgSet = true;
    } else {
      vcard.extendedProperties.add(VCardProperty(
        name: PropertyName.org,
        value: org.toValue(),
      ));
      if (title.isNotEmpty) {
        vcard.extendedProperties.add(VCardProperty(
          name: PropertyName.title,
          value: title,
        ));
      }
    }
  }

  // Addresses
  for (var i = 0; i < contact.addresses.length; i++) {
    if (!_includeItem(sel.addressItems, i, sel.addresses)) continue;
    final a = contact.addresses[i];
    final formatted = (a.formatted ?? '').trim();
    if (formatted.isNotEmpty) {
      final addr = _addressToAddress(a);
      vcard.addresses.add(addr);
    }
  }

  // Websites
  for (var i = 0; i < contact.websites.length; i++) {
    if (!_includeItem(sel.websiteItems, i, sel.websites)) continue;
    final w = contact.websites[i];
    final url = w.url.trim();
    if (url.isNotEmpty) {
      vcard.urls.add(WebUrl(url: url));
    }
  }

  // Social media (as URLs or X-SOCIALPROFILE)
  for (var i = 0; i < contact.socialMedias.length; i++) {
    if (!_includeItem(sel.socialMediaItems, i, sel.socialMedias)) continue;
    final s = contact.socialMedias[i];
    final (url, type) = SocialPlatformResolver.socialMediaToUrlAndType(s);
    if (url != null) {
      vcard.urls.add(WebUrl(
        url: url,
        types: type != null ? [type] : [],
      ));
    } else {
      final typeAndValue =
          SocialPlatformResolver.socialMediaToCustomPropertyTypeAndValue(s);
      if (typeAndValue != null) {
        final (propType, value) = typeAndValue;
        vcard.extendedProperties.add(VCardProperty.withType(
          name: 'X-SOCIALPROFILE',
          value: value,
          type: propType,
        ));
      }
    }
  }

  // Notes (single NOTE property; multiple entries joined)
  final noteParts = <String>[];
  for (var i = 0; i < contact.notes.length; i++) {
    if (!_includeItem(sel.noteItems, i, sel.notes)) continue;
    final note = contact.notes[i].note.trim();
    if (note.isNotEmpty) {
      noteParts.add(note);
    }
  }
  if (noteParts.isNotEmpty) {
    vcard.note = noteParts.join('\n\n');
  }

  final generator = VCardGenerator();
  return generator.generate(vcard, version: VCardVersion.v30);
}

ContactFieldSelection _fullSelectionForContact(fc.Contact contact) {
  return ContactFieldSelection.mergeWithDefaults(
    contact,
    const ContactFieldSelection(
      name: true,
      phones: true,
      emails: true,
      organizations: true,
      addresses: true,
      websites: true,
      socialMedias: true,
      notes: true,
    ),
  );
}

Telephone _phoneToTelephone(fc.Phone p) {
  final num = p.number.trim();
  final label = p.label.label;
  final customLabel = p.label.customLabel?.trim();

  switch (label) {
    case fc.PhoneLabel.mobile:
      return Telephone.cell(num);
    case fc.PhoneLabel.work:
      return Telephone.work(num);
    case fc.PhoneLabel.home:
      return Telephone.home(num);
    case fc.PhoneLabel.main:
      return Telephone(number: num, types: ['voice', 'pref']);
    case fc.PhoneLabel.other:
      return Telephone(number: num, types: ['other']);
    case fc.PhoneLabel.custom:
      return Telephone(
        number: num,
        types: customLabel != null && customLabel.isNotEmpty
            ? ['x-custom']
            : ['other'],
      );
    default:
      return Telephone(number: num, types: ['other']);
  }
}

Email _emailToEmail(fc.Email e) {
  final addr = e.address.trim();
  final label = e.label.label;

  switch (label) {
    case fc.EmailLabel.work:
      return Email.work(addr);
    case fc.EmailLabel.home:
      return Email.home(addr);
    case fc.EmailLabel.other:
      return Email(address: addr, types: ['other']);
    case fc.EmailLabel.custom:
      return Email(address: addr, types: ['x-custom']);
    default:
      return Email(address: addr, types: ['other']);
  }
}

Address _addressToAddress(fc.Address a) {
  final formatted = (a.formatted ?? '').trim();
  final label = a.label.label;
  final customLabel = a.label.customLabel?.trim();

  List<String> types;
  String? labelParam;
  switch (label) {
    case fc.AddressLabel.work:
      types = ['work'];
      break;
    case fc.AddressLabel.home:
      types = ['home'];
      break;
    case fc.AddressLabel.other:
      types = ['other'];
      break;
    case fc.AddressLabel.custom:
      types = customLabel != null && customLabel.isNotEmpty
          ? ['x-custom']
          : ['other'];
      labelParam = customLabel;
      break;
    default:
      types = ['other'];
  }

  return Address.raw(
    formatted,
    types: types,
    label: labelParam,
  );
}
