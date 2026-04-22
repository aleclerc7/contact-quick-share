// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../core/widgets/form_section_title.dart';
import '../../../l10n/app_localizations.dart';
import '../models/contact_field_selection.dart';

/// Reusable widget: toggles for each shareable value on the contact.
/// Used in ContactFieldSelectionScreen and as edit content in QrDisplayScreen.
class ContactFieldSelectionWidget extends StatefulWidget {
  const ContactFieldSelectionWidget({
    super.key,
    required this.contact,
    required this.initialSelection,
    required this.onSelectionChanged,
    this.primaryButtonLabel = 'Done',
    this.onPrimary,
  });

  final Contact contact;
  final ContactFieldSelection initialSelection;
  final void Function(ContactFieldSelection) onSelectionChanged;
  final String primaryButtonLabel;
  final VoidCallback? onPrimary;

  @override
  State<ContactFieldSelectionWidget> createState() =>
      _ContactFieldSelectionWidgetState();
}

class _ContactFieldSelectionWidgetState
    extends State<ContactFieldSelectionWidget> {
  late ContactFieldSelection _selection;

  @override
  void initState() {
    super.initState();
    _selection = widget.initialSelection;
  }

  @override
  void didUpdateWidget(ContactFieldSelectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelection != oldWidget.initialSelection) {
      _selection = widget.initialSelection;
    }
  }

  void _setName(bool value) {
    setState(() {
      _selection = _selection.copyWith(name: value);
      widget.onSelectionChanged(_selection);
    });
  }

  void _setPhone(int index, bool value) {
    final next = List<bool>.from(_selection.phoneItems);
    if (index < 0 || index >= next.length) return;
    next[index] = value;
    setState(() {
      _selection = _selection.copyWith(phoneItems: next);
      widget.onSelectionChanged(_selection);
    });
  }

  void _setEmail(int index, bool value) {
    final next = List<bool>.from(_selection.emailItems);
    if (index < 0 || index >= next.length) return;
    next[index] = value;
    setState(() {
      _selection = _selection.copyWith(emailItems: next);
      widget.onSelectionChanged(_selection);
    });
  }

  void _setOrganization(int index, bool value) {
    final next = List<bool>.from(_selection.organizationItems);
    if (index < 0 || index >= next.length) return;
    next[index] = value;
    setState(() {
      _selection = _selection.copyWith(organizationItems: next);
      widget.onSelectionChanged(_selection);
    });
  }

  void _setAddress(int index, bool value) {
    final next = List<bool>.from(_selection.addressItems);
    if (index < 0 || index >= next.length) return;
    next[index] = value;
    setState(() {
      _selection = _selection.copyWith(addressItems: next);
      widget.onSelectionChanged(_selection);
    });
  }

  void _setWebsite(int index, bool value) {
    final next = List<bool>.from(_selection.websiteItems);
    if (index < 0 || index >= next.length) return;
    next[index] = value;
    setState(() {
      _selection = _selection.copyWith(websiteItems: next);
      widget.onSelectionChanged(_selection);
    });
  }

  void _setSocialMedia(int index, bool value) {
    final next = List<bool>.from(_selection.socialMediaItems);
    if (index < 0 || index >= next.length) return;
    next[index] = value;
    setState(() {
      _selection = _selection.copyWith(socialMediaItems: next);
      widget.onSelectionChanged(_selection);
    });
  }

  void _setNote(int index, bool value) {
    final next = List<bool>.from(_selection.noteItems);
    if (index < 0 || index >= next.length) return;
    next[index] = value;
    setState(() {
      _selection = _selection.copyWith(noteItems: next);
      widget.onSelectionChanged(_selection);
    });
  }

  String _organizationSubtitle(Organization o) {
    return [o.name ?? '', o.jobTitle ?? '']
        .where((s) => s.trim().isNotEmpty)
        .join(' • ');
  }

  String _addressSubtitle(Address a) {
    final f = (a.formatted ?? '').trim();
    if (f.isNotEmpty) return f;
    return [
      a.street,
      a.city,
      a.state,
      a.postalCode,
      a.country,
    ].where((s) => (s ?? '').trim().isNotEmpty).join(', ');
  }

  String? _phoneLabelSubtitle(Phone p, AppLocalizations loc) {
    final custom = p.label.customLabel?.trim();
    if (custom != null && custom.isNotEmpty) return custom;
    switch (p.label.label) {
      case PhoneLabel.mobile:
        return loc.phoneLabelMobile;
      case PhoneLabel.work:
        return loc.phoneLabelWork;
      case PhoneLabel.home:
        return loc.phoneLabelHome;
      case PhoneLabel.main:
        return loc.phoneLabelMain;
      case PhoneLabel.other:
        return loc.phoneLabelOther;
      case PhoneLabel.custom:
        return loc.phoneLabelCustom;
      default:
        return null;
    }
  }

  String? _emailLabelSubtitle(Email e, AppLocalizations loc) {
    final custom = e.label.customLabel?.trim();
    if (custom != null && custom.isNotEmpty) return custom;
    switch (e.label.label) {
      case EmailLabel.work:
        return loc.emailLabelWork;
      case EmailLabel.home:
        return loc.emailLabelHome;
      case EmailLabel.other:
        return loc.emailLabelOther;
      case EmailLabel.custom:
        return loc.emailLabelCustom;
      default:
        return null;
    }
  }

  String _socialSubtitle(SocialMedia s, AppLocalizations loc) {
    final custom = s.label.customLabel?.trim();
    if (custom != null && custom.isNotEmpty) return custom;
    switch (s.label.label) {
      case SocialMediaLabel.other:
        return loc.socialLabelOther;
      case SocialMediaLabel.custom:
        return loc.socialLabelCustom;
      default:
        return s.label.label.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final contact = widget.contact;
    final children = <Widget>[];

    if (contact.name != null) {
      children.add(
        SwitchListTile(
          title: Text(loc.fieldName),
          subtitle: Text(contact.displayName ?? ''),
          value: _selection.name,
          onChanged: _setName,
        ),
      );
    }

    if (contact.phones.isNotEmpty) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: FormSectionTitle(title: loc.fieldPhones),
      ));
      for (var i = 0; i < contact.phones.length; i++) {
        final p = contact.phones[i];
        final on = i < _selection.phoneItems.length ? _selection.phoneItems[i] : false;
        final phoneSub = _phoneLabelSubtitle(p, loc);
        children.add(
          SwitchListTile(
            title: Text(p.number.trim().isEmpty ? '—' : p.number.trim()),
            subtitle: phoneSub != null ? Text(phoneSub) : null,
            value: on,
            onChanged: (v) => _setPhone(i, v),
          ),
        );
      }
    }

    if (contact.emails.isNotEmpty) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: FormSectionTitle(title: loc.fieldEmails),
      ));
      for (var i = 0; i < contact.emails.length; i++) {
        final e = contact.emails[i];
        final on = i < _selection.emailItems.length ? _selection.emailItems[i] : false;
        final emailSub = _emailLabelSubtitle(e, loc);
        children.add(
          SwitchListTile(
            title: Text(e.address.trim().isEmpty ? '—' : e.address.trim()),
            subtitle: emailSub != null ? Text(emailSub) : null,
            value: on,
            onChanged: (v) => _setEmail(i, v),
          ),
        );
      }
    }

    if (contact.organizations.isNotEmpty) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: FormSectionTitle(title: loc.fieldOrganization),
      ));
      for (var i = 0; i < contact.organizations.length; i++) {
        final o = contact.organizations[i];
        final on = i < _selection.organizationItems.length
            ? _selection.organizationItems[i]
            : false;
        children.add(
          SwitchListTile(
            title: Text(_organizationSubtitle(o).isEmpty ? '—' : _organizationSubtitle(o)),
            value: on,
            onChanged: (v) => _setOrganization(i, v),
          ),
        );
      }
    }

    if (contact.addresses.isNotEmpty) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: FormSectionTitle(title: loc.fieldAddresses),
      ));
      for (var i = 0; i < contact.addresses.length; i++) {
        final a = contact.addresses[i];
        final on =
            i < _selection.addressItems.length ? _selection.addressItems[i] : false;
        final sub = _addressSubtitle(a);
        children.add(
          SwitchListTile(
            title: Text(sub.isEmpty ? '—' : sub),
            value: on,
            onChanged: (v) => _setAddress(i, v),
          ),
        );
      }
    }

    if (contact.websites.isNotEmpty) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: FormSectionTitle(title: loc.fieldWebsites),
      ));
      for (var i = 0; i < contact.websites.length; i++) {
        final w = contact.websites[i];
        final on =
            i < _selection.websiteItems.length ? _selection.websiteItems[i] : false;
        children.add(
          SwitchListTile(
            title: Text(w.url.trim().isEmpty ? '—' : w.url.trim()),
            value: on,
            onChanged: (v) => _setWebsite(i, v),
          ),
        );
      }
    }

    if (contact.socialMedias.isNotEmpty) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: FormSectionTitle(title: loc.fieldSocialMedia),
      ));
      for (var i = 0; i < contact.socialMedias.length; i++) {
        final s = contact.socialMedias[i];
        final on = i < _selection.socialMediaItems.length
            ? _selection.socialMediaItems[i]
            : false;
        children.add(
          SwitchListTile(
            title: Text(
              s.username.trim().isEmpty ? '—' : s.username.trim(),
            ),
            subtitle: Text(_socialSubtitle(s, loc)),
            value: on,
            onChanged: (v) => _setSocialMedia(i, v),
          ),
        );
      }
    }

    if (contact.notes.isNotEmpty) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: FormSectionTitle(title: loc.fieldNotes),
      ));
      for (var i = 0; i < contact.notes.length; i++) {
        final n = contact.notes[i];
        final on = i < _selection.noteItems.length ? _selection.noteItems[i] : false;
        final preview = n.note.trim();
        children.add(
          SwitchListTile(
            title: Text(
              preview.isEmpty
                  ? '—'
                  : (preview.length > 80 ? '${preview.substring(0, 80)}…' : preview),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            value: on,
            onChanged: (v) => _setNote(i, v),
          ),
        );
      }
    }

    if (widget.onPrimary != null) {
      children.add(const SizedBox(height: 24));
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilledButton(
            onPressed: widget.onPrimary,
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text(widget.primaryButtonLabel),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: children,
    );
  }
}
