// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../contacts/utils/contact_to_vcard_mapper.dart';
import '../../qr_code/models/qr_appearance.dart';

/// Business card model with full vCard contact data and QR appearance.
class BusinessCard {
  const BusinessCard({
    required this.id,
    required this.cardName,
    required this.displayFullName,
    required this.displayOrg,
    required this.displayTitle,
    required this.displaySubtitle,
    required this.primaryPhone,
    required this.primaryEmail,
    this.backgroundColor,
    this.textColor,
    this.cardPhoto,
    this.qrLogo,
    required this.contact,
    required this.qrAppearance,
    this.linkedContactId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String cardName;
  final String displayFullName;
  final String displayOrg;
  final String displayTitle;
  final String displaySubtitle;
  final String primaryPhone;
  final String primaryEmail;
  final int? backgroundColor;
  final int? textColor;
  final Uint8List? cardPhoto;
  final Uint8List? qrLogo;
  final Contact contact;
  final QrAppearance qrAppearance;
  final String? linkedContactId;
  final int createdAt;
  final int updatedAt;

  /// Generates vCard 3.0 string from the contact.
  /// Uses vcard_dart; never includes photo (keeps QR within capacity).
  String generateVCard() {
    return buildVCardFromContact(contact);
  }

  /// True if the contact has at least one field with data that will appear in the vCard.
  /// cardName is excluded as it is not part of the vCard.
  bool get hasVCardData {
    final c = contact;
    final n = c.name;
    if (n != null) {
      if ((n.first ?? '').trim().isNotEmpty) return true;
      if ((n.last ?? '').trim().isNotEmpty) return true;
      if ((n.prefix ?? '').trim().isNotEmpty) return true;
      if ((n.middle ?? '').trim().isNotEmpty) return true;
      if ((n.suffix ?? '').trim().isNotEmpty) return true;
      if ((n.nickname ?? '').trim().isNotEmpty) return true;
    }
    if (c.phones.isNotEmpty) return true;
    if (c.emails.isNotEmpty) return true;
    if (c.organizations.isNotEmpty) return true;
    if (c.addresses.isNotEmpty) return true;
    if (c.websites.isNotEmpty) return true;
    if (c.socialMedias.isNotEmpty) return true;
    if (c.notes.isNotEmpty) return true;
    if (c.events.any((e) => e.label.label == EventLabel.birthday)) return true;
    return false;
  }

  /// True if this card differs from [other] in any user-visible way.
  /// Ignores updatedAt. Used for unsaved-changes detection.
  bool hasChangesComparedTo(BusinessCard other) {
    if (_str(cardName) != _str(other.cardName)) return true;
    if (_str(displayFullName) != _str(other.displayFullName)) return true;
    if (_str(displayOrg) != _str(other.displayOrg)) return true;
    if (_str(displayTitle) != _str(other.displayTitle)) return true;
    if (_str(displaySubtitle) != _str(other.displaySubtitle)) return true;
    if (backgroundColor != other.backgroundColor) return true;
    if (textColor != other.textColor) return true;
    if (qrAppearance != other.qrAppearance) return true;
    if (!_bytesEq(cardPhoto, other.cardPhoto)) return true;
    if (!_bytesEq(qrLogo, other.qrLogo)) return true;
    return _contactDiffers(contact, other.contact);
  }

  static String _str(String? s) => (s ?? '').trim();
  static bool _bytesEq(Uint8List? a, Uint8List? b) =>
      (a == null && b == null) ||
      (a != null && b != null && listEquals(a, b));

  static bool _contactDiffers(Contact a, Contact b) {
    final an = a.name;
    final bn = b.name;
    if (_str(an?.first) != _str(bn?.first)) return true;
    if (_str(an?.last) != _str(bn?.last)) return true;
    if (_str(an?.prefix) != _str(bn?.prefix)) return true;
    if (_str(an?.middle) != _str(bn?.middle)) return true;
    if (_str(an?.suffix) != _str(bn?.suffix)) return true;
    if (_str(an?.nickname) != _str(bn?.nickname)) return true;
    if (a.phones.length != b.phones.length) return true;
    for (var i = 0; i < a.phones.length; i++) {
      if (_str(a.phones[i].number) != _str(b.phones[i].number)) return true;
    }
    if (a.emails.length != b.emails.length) return true;
    for (var i = 0; i < a.emails.length; i++) {
      if (_str(a.emails[i].address) != _str(b.emails[i].address)) return true;
    }
    if (a.websites.length != b.websites.length) return true;
    for (var i = 0; i < a.websites.length; i++) {
      if (_str(a.websites[i].url) != _str(b.websites[i].url)) return true;
    }
    if (a.addresses.length != b.addresses.length) return true;
    for (var i = 0; i < a.addresses.length; i++) {
      if (_str(a.addresses[i].formatted) != _str(b.addresses[i].formatted)) {
        return true;
      }
    }
    if (a.socialMedias.length != b.socialMedias.length) return true;
    for (var i = 0; i < a.socialMedias.length; i++) {
      if (_str(a.socialMedias[i].username) != _str(b.socialMedias[i].username)) {
        return true;
      }
    }
    final ao = a.organizations;
    final bo = b.organizations;
    if (ao.length != bo.length) return true;
    for (var i = 0; i < ao.length; i++) {
      if (_str(ao[i].name) != _str(bo[i].name)) return true;
      if (_str(ao[i].jobTitle) != _str(bo[i].jobTitle)) return true;
      if (_str(ao[i].departmentName) != _str(bo[i].departmentName)) return true;
    }
    final aBday = a.events
        .where((e) => e.label.label == EventLabel.birthday)
        .firstOrNull;
    final bBday = b.events
        .where((e) => e.label.label == EventLabel.birthday)
        .firstOrNull;
    if ((aBday == null) != (bBday == null)) return true;
    if (aBday != null && bBday != null) {
      if (aBday.year != bBday.year ||
          aBday.month != bBday.month ||
          aBday.day != bBday.day) {
        return true;
      }
    }
    final aNote = a.notes.isNotEmpty ? a.notes.first.note : '';
    final bNote = b.notes.isNotEmpty ? b.notes.first.note : '';
    return _str(aNote) != _str(bNote);
  }

  /// Syncs display preview fields from the contact.
  BusinessCard regeneratePreviewFields() {
    final displayName = contact.displayName ?? '';
    final org = contact.organizations.isNotEmpty
        ? contact.organizations.first
        : null;
    final orgName = org?.name ?? '';
    final title = org?.jobTitle ?? '';
    final subtitle = org?.departmentName ?? '';
    final phone = contact.phones.isNotEmpty
        ? contact.phones.first.number
        : '';
    final email = contact.emails.isNotEmpty
        ? contact.emails.first.address
        : '';

    return copyWith(
      displayFullName: displayName,
      displayOrg: orgName,
      displayTitle: title,
      displaySubtitle: subtitle,
      primaryPhone: phone,
      primaryEmail: email,
    );
  }

  factory BusinessCard.fromJson(Map<String, dynamic> json) {
    final contactJson = json['contact_json'] as String;
    final contactJsonMap = jsonDecode(contactJson) as Map<String, dynamic>;
    final contact = Contact.fromJson(contactJsonMap);

    final qrAppearanceJson = json['qr_appearance_json'] as String?;
    final qrAppearance = qrAppearanceJson != null
        ? QrAppearance.fromJson(
            jsonDecode(qrAppearanceJson) as Map<String, dynamic>,
          )
        : QrAppearance.defaultAppearance();

    Uint8List? cardPhoto;
    final cardPhotoBytes = json['card_photo'];
    if (cardPhotoBytes != null && cardPhotoBytes is Uint8List) {
      cardPhoto = cardPhotoBytes;
    }

    Uint8List? qrLogo;
    final qrLogoBytes = json['qr_logo'];
    if (qrLogoBytes != null && qrLogoBytes is Uint8List) {
      qrLogo = qrLogoBytes;
    }

    return BusinessCard(
      id: json['id'] as String,
      cardName: json['card_name'] as String? ?? '',
      displayFullName: json['display_full_name'] as String? ?? '',
      displayOrg: json['display_org'] as String? ?? '',
      displayTitle: json['display_title'] as String? ?? '',
      displaySubtitle: json['display_subtitle'] as String? ?? '',
      primaryPhone: json['primary_phone'] as String? ?? '',
      primaryEmail: json['primary_email'] as String? ?? '',
      backgroundColor: json['background_color'] as int?,
      textColor: json['text_color'] as int?,
      cardPhoto: cardPhoto,
      qrLogo: qrLogo,
      contact: contact,
      qrAppearance: qrAppearance,
      linkedContactId: json['linked_contact_id'] as String?,
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'card_name': cardName,
        'display_full_name': displayFullName,
        'display_org': displayOrg,
        'display_title': displayTitle,
        'display_subtitle': displaySubtitle,
        'primary_phone': primaryPhone,
        'primary_email': primaryEmail,
        'background_color': backgroundColor,
        'text_color': textColor,
        'card_photo': cardPhoto,
        'qr_logo': qrLogo,
        'contact_json': jsonEncode(contact.toJson()),
        'qr_appearance_json': jsonEncode(qrAppearance.toJson()),
        'linked_contact_id': linkedContactId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  /// JSON for backup/export. Encodes card_photo and qr_logo as base64.
  Map<String, dynamic> toBackupJson() => {
        'id': id,
        'card_name': cardName,
        'display_full_name': displayFullName,
        'display_org': displayOrg,
        'display_title': displayTitle,
        'display_subtitle': displaySubtitle,
        'primary_phone': primaryPhone,
        'primary_email': primaryEmail,
        'background_color': backgroundColor,
        'text_color': textColor,
        if (cardPhoto != null) 'card_photo': base64Encode(cardPhoto!),
        if (qrLogo != null) 'qr_logo': base64Encode(qrLogo!),
        'contact_json': jsonEncode(contact.toJson()),
        'qr_appearance_json': jsonEncode(qrAppearance.toJson()),
        'linked_contact_id': linkedContactId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  /// Parse from backup JSON. Handles base64 for card_photo and qr_logo.
  /// Tolerates missing/extra fields; validates types to avoid crashes on invalid data.
  factory BusinessCard.fromBackupJson(Map<String, dynamic> json) {
    final contactJson = json['contact_json'];
    if (contactJson == null || contactJson is! String) {
      throw FormatException('Invalid backup: missing or invalid contact_json');
    }
    final contactMap = jsonDecode(contactJson);
    if (contactMap is! Map<String, dynamic>) {
      throw FormatException('Invalid backup: contact_json is not an object');
    }
    final contact = Contact.fromJson(contactMap);

    final qrAppearanceJson = json['qr_appearance_json'];
    final qrAppearance = qrAppearanceJson != null && qrAppearanceJson is String
        ? (() {
            final decoded = jsonDecode(qrAppearanceJson);
            if (decoded is! Map<String, dynamic>) {
              return QrAppearance.defaultAppearance();
            }
            return QrAppearance.fromJson(decoded);
          })()
        : QrAppearance.defaultAppearance();

    Uint8List? cardPhoto;
    final cardPhotoB64 = json['card_photo'];
    if (cardPhotoB64 != null && cardPhotoB64 is String) {
      try {
        cardPhoto = base64Decode(cardPhotoB64);
      } catch (_) {
        // Invalid base64; leave null
      }
    }

    Uint8List? qrLogo;
    final qrLogoB64 = json['qr_logo'];
    if (qrLogoB64 != null && qrLogoB64 is String) {
      try {
        qrLogo = base64Decode(qrLogoB64);
      } catch (_) {
        // Invalid base64; leave null
      }
    }

    final id = json['id'];
    if (id == null || id is! String || id.isEmpty) {
      throw FormatException('Invalid backup: missing or invalid card id');
    }

    final createdAt = json['created_at'];
    final updatedAt = json['updated_at'];
    final createdAtInt = createdAt is int
        ? createdAt
        : (createdAt is num ? createdAt.toInt() : DateTime.now().millisecondsSinceEpoch);
    final updatedAtInt = updatedAt is int
        ? updatedAt
        : (updatedAt is num ? updatedAt.toInt() : DateTime.now().millisecondsSinceEpoch);

    return BusinessCard(
      id: id,
      cardName: json['card_name'] is String ? json['card_name'] as String : '',
      displayFullName: json['display_full_name'] is String ? json['display_full_name'] as String : '',
      displayOrg: json['display_org'] is String ? json['display_org'] as String : '',
      displayTitle: json['display_title'] is String ? json['display_title'] as String : '',
      displaySubtitle: json['display_subtitle'] is String ? json['display_subtitle'] as String : '',
      primaryPhone: json['primary_phone'] is String ? json['primary_phone'] as String : '',
      primaryEmail: json['primary_email'] is String ? json['primary_email'] as String : '',
      backgroundColor: json['background_color'] is int ? json['background_color'] as int? : null,
      textColor: json['text_color'] is int ? json['text_color'] as int? : null,
      cardPhoto: cardPhoto,
      qrLogo: qrLogo,
      contact: contact,
      qrAppearance: qrAppearance,
      linkedContactId: json['linked_contact_id'] is String ? json['linked_contact_id'] as String? : null,
      createdAt: createdAtInt,
      updatedAt: updatedAtInt,
    );
  }

  static const _undefined = Object();

  BusinessCard copyWith({
    String? id,
    String? cardName,
    String? displayFullName,
    String? displayOrg,
    String? displayTitle,
    String? displaySubtitle,
    String? primaryPhone,
    String? primaryEmail,
    Object? backgroundColor = _undefined,
    Object? textColor = _undefined,
    Object? cardPhoto = _undefined,
    Object? qrLogo = _undefined,
    Contact? contact,
    QrAppearance? qrAppearance,
    String? linkedContactId,
    int? createdAt,
    int? updatedAt,
  }) {
    return BusinessCard(
      id: id ?? this.id,
      cardName: cardName ?? this.cardName,
      displayFullName: displayFullName ?? this.displayFullName,
      displayOrg: displayOrg ?? this.displayOrg,
      displayTitle: displayTitle ?? this.displayTitle,
      displaySubtitle: displaySubtitle ?? this.displaySubtitle,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      primaryEmail: primaryEmail ?? this.primaryEmail,
      backgroundColor: identical(backgroundColor, _undefined)
          ? this.backgroundColor
          : backgroundColor as int?,
      textColor: identical(textColor, _undefined)
          ? this.textColor
          : textColor as int?,
      cardPhoto: identical(cardPhoto, _undefined)
          ? this.cardPhoto
          : cardPhoto as Uint8List?,
      qrLogo: identical(qrLogo, _undefined)
          ? this.qrLogo
          : qrLogo as Uint8List?,
      contact: contact ?? this.contact,
      qrAppearance: qrAppearance ?? this.qrAppearance,
      linkedContactId: linkedContactId ?? this.linkedContactId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
