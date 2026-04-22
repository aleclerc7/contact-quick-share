// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'package:flutter_contacts/flutter_contacts.dart';

import 'qr_appearance.dart';

/// Data abstraction for QR display: vCard content, appearance, and display contact.
/// All display fields are derived from [displayContact].
/// Used by both business cards and contact sharing flows.
class QrDisplayPayload {
  const QrDisplayPayload({
    required this.vCardContent,
    required this.qrAppearance,
    required this.displayContact,
    this.photoOverride,
    this.backgroundColor,
    this.textColor,
    this.centerLogo,
  });

  final String vCardContent;
  final QrAppearance qrAppearance;
  /// Contact representing exactly what is encoded in the vCard.
  final Contact displayContact;
  /// Optional photo override (e.g. business card display photo). When null, uses contact.photo.
  final Uint8List? photoOverride;
  final int? backgroundColor;
  final int? textColor;
  final Uint8List? centerLogo;

  /// Display name derived from contact.
  /// Uses [displayName] when set (e.g. from device or vCard import).
  /// Falls back to building from [name] components when [displayName] is null
  /// (e.g. business cards created in-app, where displayName was never set).
  String get displayName {
    if (displayContact.displayName?.trim().isNotEmpty == true) {
      return displayContact.displayName!;
    }
    final n = displayContact.name;
    if (n != null) {
      final parts = [n.prefix, n.first, n.middle, n.last, n.suffix]
          .where((s) => (s ?? '').trim().isNotEmpty)
          .toList();
      if (parts.isNotEmpty) return parts.join(' ');
      if ((n.nickname ?? '').trim().isNotEmpty) return n.nickname!;
    }
    return 'Contact';
  }

  /// Company and role derived from contact organizations.
  String get displaySubtitle {
    final org = displayContact.organizations.isNotEmpty
        ? displayContact.organizations.first
        : null;
    return [
      org?.name ?? '',
      org?.jobTitle ?? '',
    ].where((s) => s.trim().isNotEmpty).join(' • ');
  }

  /// Primary email from contact.
  String get primaryEmail =>
      displayContact.emails.isNotEmpty
          ? displayContact.emails.first.address
          : '';

  /// Primary phone from contact.
  String get primaryPhone =>
      displayContact.phones.isNotEmpty
          ? displayContact.phones.first.number
          : '';

  /// Photo: override if provided, otherwise from contact.
  Uint8List? get photo =>
      photoOverride ?? displayContact.photo?.thumbnail;
}
