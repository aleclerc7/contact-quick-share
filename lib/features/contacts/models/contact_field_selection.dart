// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/foundation.dart' show listEquals;

import 'package:flutter_contacts/flutter_contacts.dart';

/// Model for which vCard fields to include when sharing a contact.
///
/// [phones], [emails], etc. are category defaults (used in Settings and to
/// seed per-item toggles). [phoneItems], [emailItems], … align 1:1 with the
/// contact's lists after [mergeWithDefaults] or [reconcileAfterRefresh].
class ContactFieldSelection {
  const ContactFieldSelection({
    this.name = true,
    this.phones = true,
    this.emails = true,
    this.organizations = true,
    this.addresses = false,
    this.websites = false,
    this.socialMedias = false,
    this.notes = false,
    this.phoneItems = const [],
    this.emailItems = const [],
    this.organizationItems = const [],
    this.addressItems = const [],
    this.websiteItems = const [],
    this.socialMediaItems = const [],
    this.noteItems = const [],
  });

  final bool name;
  final bool phones;
  final bool emails;
  final bool organizations;
  final bool addresses;
  final bool websites;
  final bool socialMedias;
  final bool notes;

  final List<bool> phoneItems;
  final List<bool> emailItems;
  final List<bool> organizationItems;
  final List<bool> addressItems;
  final List<bool> websiteItems;
  final List<bool> socialMediaItems;
  final List<bool> noteItems;

  /// True if at least one field category is selected for inclusion in the vCard.
  bool get hasAnySelectedField {
    if (name) return true;
    if (_anyTrue(phoneItems, phones)) return true;
    if (_anyTrue(emailItems, emails)) return true;
    if (_anyTrue(organizationItems, organizations)) return true;
    if (_anyTrue(addressItems, addresses)) return true;
    if (_anyTrue(websiteItems, websites)) return true;
    if (_anyTrue(socialMediaItems, socialMedias)) return true;
    if (_anyTrue(noteItems, notes)) return true;
    return false;
  }

  static bool _anyTrue(List<bool> items, bool categoryFallback) {
    if (items.isNotEmpty) return items.any((e) => e);
    return categoryFallback;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phones': phones,
        'emails': emails,
        'organizations': organizations,
        'addresses': addresses,
        'websites': websites,
        'socialMedias': socialMedias,
        'notes': notes,
      };

  factory ContactFieldSelection.fromJson(Map<String, dynamic> json) {
    return ContactFieldSelection(
      name: json['name'] as bool? ?? true,
      phones: json['phones'] as bool? ?? true,
      emails: json['emails'] as bool? ?? true,
      organizations: json['organizations'] as bool? ?? true,
      addresses: json['addresses'] as bool? ?? false,
      websites: json['websites'] as bool? ?? false,
      socialMedias: json['socialMedias'] as bool? ?? false,
      notes: json['notes'] as bool? ?? false,
    );
  }

  /// Sensible defaults: name, phones, emails, org (first-time use).
  factory ContactFieldSelection.defaultSelection() => const ContactFieldSelection(
        name: true,
        phones: true,
        emails: true,
        organizations: true,
        addresses: false,
        websites: false,
        socialMedias: false,
        notes: false,
      );

  /// Derives selection from contact: enable toggles for fields that exist.
  factory ContactFieldSelection.fromContact(Contact contact) {
    return mergeWithDefaults(
      contact,
      ContactFieldSelection(
        name: contact.name != null,
        phones: contact.phones.isNotEmpty,
        emails: contact.emails.isNotEmpty,
        organizations: contact.organizations.isNotEmpty,
        addresses: contact.addresses.isNotEmpty,
        websites: contact.websites.isNotEmpty,
        socialMedias: contact.socialMedias.isNotEmpty,
        notes: contact.notes.isNotEmpty,
      ),
    );
  }

  /// Merges with defaults: per-item toggles seeded from category flags in [defaults].
  static ContactFieldSelection mergeWithDefaults(
    Contact contact,
    ContactFieldSelection defaults,
  ) {
    return ContactFieldSelection(
      name: contact.name != null && defaults.name,
      phones: defaults.phones,
      emails: defaults.emails,
      organizations: defaults.organizations,
      addresses: defaults.addresses,
      websites: defaults.websites,
      socialMedias: defaults.socialMedias,
      notes: defaults.notes,
      phoneItems: _expandOrAlign(
        defaults.phoneItems,
        contact.phones.length,
        defaults.phones,
      ),
      emailItems: _expandOrAlign(
        defaults.emailItems,
        contact.emails.length,
        defaults.emails,
      ),
      organizationItems: _expandOrAlign(
        defaults.organizationItems,
        contact.organizations.length,
        defaults.organizations,
      ),
      addressItems: _expandOrAlign(
        defaults.addressItems,
        contact.addresses.length,
        defaults.addresses,
      ),
      websiteItems: _expandOrAlign(
        defaults.websiteItems,
        contact.websites.length,
        defaults.websites,
      ),
      socialMediaItems: _expandOrAlign(
        defaults.socialMediaItems,
        contact.socialMedias.length,
        defaults.socialMedias,
      ),
      noteItems: _expandOrAlign(
        defaults.noteItems,
        contact.notes.length,
        defaults.notes,
      ),
    );
  }

  /// After reloading a contact, preserve per-item choices where indices still align;
  /// new trailing items use [categoryDefaults] category flags.
  static ContactFieldSelection reconcileAfterRefresh(
    Contact fresh,
    ContactFieldSelection previous,
    ContactFieldSelection categoryDefaults,
  ) {
    return ContactFieldSelection(
      name: fresh.name != null && previous.name,
      phones: categoryDefaults.phones,
      emails: categoryDefaults.emails,
      organizations: categoryDefaults.organizations,
      addresses: categoryDefaults.addresses,
      websites: categoryDefaults.websites,
      socialMedias: categoryDefaults.socialMedias,
      notes: categoryDefaults.notes,
      phoneItems: _expandOrAlign(
        previous.phoneItems,
        fresh.phones.length,
        categoryDefaults.phones,
      ),
      emailItems: _expandOrAlign(
        previous.emailItems,
        fresh.emails.length,
        categoryDefaults.emails,
      ),
      organizationItems: _expandOrAlign(
        previous.organizationItems,
        fresh.organizations.length,
        categoryDefaults.organizations,
      ),
      addressItems: _expandOrAlign(
        previous.addressItems,
        fresh.addresses.length,
        categoryDefaults.addresses,
      ),
      websiteItems: _expandOrAlign(
        previous.websiteItems,
        fresh.websites.length,
        categoryDefaults.websites,
      ),
      socialMediaItems: _expandOrAlign(
        previous.socialMediaItems,
        fresh.socialMedias.length,
        categoryDefaults.socialMedias,
      ),
      noteItems: _expandOrAlign(
        previous.noteItems,
        fresh.notes.length,
        categoryDefaults.notes,
      ),
    );
  }

  static List<bool> _expandOrAlign(
    List<bool> items,
    int length,
    bool categoryDefault,
  ) {
    if (length == 0) return [];
    if (items.length == length) return List<bool>.from(items);
    if (items.isEmpty) {
      return List<bool>.filled(length, categoryDefault);
    }
    return List<bool>.generate(
      length,
      (i) => i < items.length ? items[i] : categoryDefault,
    );
  }

  ContactFieldSelection copyWith({
    bool? name,
    bool? phones,
    bool? emails,
    bool? organizations,
    bool? addresses,
    bool? websites,
    bool? socialMedias,
    bool? notes,
    List<bool>? phoneItems,
    List<bool>? emailItems,
    List<bool>? organizationItems,
    List<bool>? addressItems,
    List<bool>? websiteItems,
    List<bool>? socialMediaItems,
    List<bool>? noteItems,
  }) {
    return ContactFieldSelection(
      name: name ?? this.name,
      phones: phones ?? this.phones,
      emails: emails ?? this.emails,
      organizations: organizations ?? this.organizations,
      addresses: addresses ?? this.addresses,
      websites: websites ?? this.websites,
      socialMedias: socialMedias ?? this.socialMedias,
      notes: notes ?? this.notes,
      phoneItems: phoneItems ?? this.phoneItems,
      emailItems: emailItems ?? this.emailItems,
      organizationItems: organizationItems ?? this.organizationItems,
      addressItems: addressItems ?? this.addressItems,
      websiteItems: websiteItems ?? this.websiteItems,
      socialMediaItems: socialMediaItems ?? this.socialMediaItems,
      noteItems: noteItems ?? this.noteItems,
    );
  }

  /// Returns a new Contact with only the selected fields.
  /// Unselected fields are cleared (empty lists / null).
  Contact applyToContact(Contact contact) {
    return contact.copyWith(
      name: name ? contact.name : null,
      phones: _filterList(contact.phones, phoneItems, phones),
      emails: _filterList(contact.emails, emailItems, emails),
      organizations:
          _filterList(contact.organizations, organizationItems, organizations),
      addresses: _filterList(contact.addresses, addressItems, addresses),
      websites: _filterList(contact.websites, websiteItems, websites),
      socialMedias:
          _filterList(contact.socialMedias, socialMediaItems, socialMedias),
      notes: _filterList(contact.notes, noteItems, notes),
    );
  }

  static List<T> _filterList<T>(
    List<T> source,
    List<bool> toggles,
    bool categoryFallback,
  ) {
    if (source.isEmpty) return [];
    if (toggles.length == source.length) {
      final out = <T>[];
      for (var i = 0; i < source.length; i++) {
        if (toggles[i]) out.add(source[i]);
      }
      return out;
    }
    return categoryFallback ? List<T>.from(source) : [];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContactFieldSelection &&
        name == other.name &&
        phones == other.phones &&
        emails == other.emails &&
        organizations == other.organizations &&
        addresses == other.addresses &&
        websites == other.websites &&
        socialMedias == other.socialMedias &&
        notes == other.notes &&
        listEquals(phoneItems, other.phoneItems) &&
        listEquals(emailItems, other.emailItems) &&
        listEquals(organizationItems, other.organizationItems) &&
        listEquals(addressItems, other.addressItems) &&
        listEquals(websiteItems, other.websiteItems) &&
        listEquals(socialMediaItems, other.socialMediaItems) &&
        listEquals(noteItems, other.noteItems);
  }

  @override
  int get hashCode => Object.hash(
        name,
        phones,
        emails,
        organizations,
        addresses,
        websites,
        socialMedias,
        notes,
        Object.hashAll(phoneItems),
        Object.hashAll(emailItems),
        Object.hashAll(organizationItems),
        Object.hashAll(addressItems),
        Object.hashAll(websiteItems),
        Object.hashAll(socialMediaItems),
        Object.hashAll(noteItems),
      );
}
