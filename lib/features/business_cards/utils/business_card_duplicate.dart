// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:uuid/uuid.dart';

import '../../qr_code/models/qr_appearance.dart';
import '../models/business_card.dart';

/// Full snapshot of [source] as a **new** in-memory card (new id, timestamps).
/// [linkedContactId] is always `null` — copies do not inherit device sync.
/// [cardNameCopySuffix] is appended when [source.cardName] is non-empty (localized).
BusinessCard newBusinessCardAsCopyOf(
  BusinessCard source, {
  required String cardNameCopySuffix,
}) {
  final now = DateTime.now().millisecondsSinceEpoch;
  final contactCopy = Contact.fromJson(source.contact.toJson());
  final qrAppearance = QrAppearance.fromJson(source.qrAppearance.toJson());
  final cardPhoto = source.cardPhoto != null
      ? Uint8List.fromList(source.cardPhoto!)
      : null;
  final qrLogo = source.qrLogo != null
      ? Uint8List.fromList(source.qrLogo!)
      : null;
  final rawName = source.cardName.trim();
  final cardName = rawName.isEmpty ? '' : '$rawName$cardNameCopySuffix';

  return BusinessCard(
    id: const Uuid().v4(),
    cardName: cardName,
    displayFullName: source.displayFullName,
    displayOrg: source.displayOrg,
    displayTitle: source.displayTitle,
    displaySubtitle: source.displaySubtitle,
    primaryPhone: source.primaryPhone,
    primaryEmail: source.primaryEmail,
    backgroundColor: source.backgroundColor,
    textColor: source.textColor,
    cardPhoto: cardPhoto,
    qrLogo: qrLogo,
    contact: contactCopy,
    qrAppearance: qrAppearance,
    linkedContactId: null,
    createdAt: now,
    updatedAt: now,
  );
}
