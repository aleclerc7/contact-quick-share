// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:uuid/uuid.dart';

import '../../contacts/utils/contact_share_deduplicator.dart';
import '../../qr_code/models/qr_appearance.dart';
import '../models/business_card.dart';

/// Suggested [BusinessCard.cardName] from a device [Contact] (copy path; no linking).
String cardNameFromDeviceContact(Contact source) {
  final display = (source.displayName ?? '').trim();
  if (display.isNotEmpty) {
    return display;
  }
  final n = source.name;
  if (n == null) {
    return '';
  }
  final parts = <String>[
    (n.first ?? '').trim(),
    (n.middle ?? '').trim(),
    (n.last ?? '').trim(),
  ].where((s) => s.isNotEmpty);
  if (parts.isNotEmpty) {
    return parts.join(' ');
  }
  return '';
}

/// Display line from [Contact.name] in the same order as [BusinessCardDataTab] `getDraftCard`
/// (prefix, first, middle, last, suffix) — not [Name.nickname], to match the editor’s baseline.
String displayFullNameFromNameParts(Contact c) {
  final n = c.name;
  if (n == null) {
    return '';
  }
  return [
    (n.prefix ?? '').trim(),
    (n.first ?? '').trim(),
    (n.middle ?? '').trim(),
    (n.last ?? '').trim(),
    (n.suffix ?? '').trim(),
  ].where((s) => s.isNotEmpty).join(' ');
}

/// Creates a new [BusinessCard] with a one-time **snapshot** of [source].
/// [linkedContactId] is always `null` (boring copy; not linked for sync).
BusinessCard newBusinessCardFromDeviceContact({
  required Contact source,
  required QrAppearance defaultQrAppearance,
  int? defaultBackgroundColor,
  int? defaultTextColor,
}) {
  final now = DateTime.now().millisecondsSinceEpoch;
  // Same list cleanup as the contact share flow (dedupe phones, emails, etc. by value).
  final deduped = toShareDedupedContact(source);
  final copy = Contact.fromJson(deduped.toJson());
  final fromParts = displayFullNameFromNameParts(copy);
  // [Contact.copyWith] cannot clear [displayName] (it uses `d ?? this.displayName`).
  // When the editor has no name-part line, [BusinessCardDataTab] `getDraftCard`
  // uses `displayFullName: ''` and sets `displayName: null` on a new [Contact] built
  // from the form. A device-only display string (e.g. company, no structured name
  // parts) must be dropped on the snapshot so the baseline matches a no-edit draft.
  final vCardDisplayName = fromParts.isNotEmpty ? fromParts : null;
  final contactForCard = Contact(
    id: copy.id,
    displayName: vCardDisplayName,
    photo: copy.photo,
    name: copy.name,
    phones: copy.phones,
    emails: copy.emails,
    addresses: copy.addresses,
    organizations: copy.organizations,
    websites: copy.websites,
    socialMedias: copy.socialMedias,
    events: copy.events,
    relations: copy.relations,
    notes: copy.notes,
    android: copy.android,
    metadata: copy.metadata,
  );

  final photo = deduped.photo;
  final cardPhoto = photo == null
      ? null
      : (() {
          final b = photo.fullSize ?? photo.thumbnail;
          if (b == null) return null;
          return Uint8List.fromList(b);
        })();

  final name = cardNameFromDeviceContact(deduped);
  final card = BusinessCard(
    id: const Uuid().v4(),
    cardName: name,
    displayFullName: '',
    displayOrg: '',
    displayTitle: '',
    displaySubtitle: '',
    primaryPhone: '',
    primaryEmail: '',
    backgroundColor: defaultBackgroundColor,
    textColor: defaultTextColor,
    cardPhoto: cardPhoto,
    qrLogo: null,
    contact: contactForCard,
    qrAppearance: defaultQrAppearance,
    linkedContactId: null,
    createdAt: now,
    updatedAt: now,
  );
  return card.regeneratePreviewFields();
}
