// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:contact_quick_share/features/business_cards/models/business_card.dart';
import 'package:contact_quick_share/features/business_cards/utils/business_card_duplicate.dart';
import 'package:contact_quick_share/features/qr_code/models/qr_appearance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('newBusinessCardAsCopyOf uses new id, clears link, clones bytes', () {
    final bytes = Uint8List.fromList([1, 2, 3]);
    final source = BusinessCard(
      id: 'old-id',
      cardName: 'Work',
      displayFullName: 'X',
      displayOrg: 'O',
      displayTitle: 'T',
      displaySubtitle: 'S',
      primaryPhone: '1',
      primaryEmail: 'e@e.com',
      backgroundColor: 0xff123456,
      textColor: 0xff654321,
      cardPhoto: bytes,
      qrLogo: Uint8List.fromList([9]),
      contact: Contact(displayName: 'X'),
      qrAppearance: QrAppearance.defaultAppearance(),
      linkedContactId: 'link-1',
      createdAt: 1,
      updatedAt: 2,
    );
    final copy = newBusinessCardAsCopyOf(source, cardNameCopySuffix: ' (copy)');
    expect(copy.id, isNot('old-id'));
    expect(copy.linkedContactId, isNull);
    expect(copy.cardName, 'Work (copy)');
    expect(copy.cardPhoto, isNot(same(source.cardPhoto)));
    expect(listEquals(copy.cardPhoto, source.cardPhoto), isTrue);
    expect(copy.qrLogo, isNot(same(source.qrLogo)));
    expect(listEquals(copy.qrLogo, source.qrLogo), isTrue);
    expect(copy.contact, isNot(same(source.contact)));
    expect(copy.backgroundColor, 0xff123456);
    expect(copy.textColor, 0xff654321);
  });

  test('newBusinessCardAsCopyOf trims cardName before suffix', () {
    final source = BusinessCard(
      id: 'a',
      cardName: '  Name  ',
      displayFullName: '',
      displayOrg: '',
      displayTitle: '',
      displaySubtitle: '',
      primaryPhone: '',
      primaryEmail: '',
      contact: Contact(),
      qrAppearance: QrAppearance.defaultAppearance(),
      linkedContactId: null,
      createdAt: 1,
      updatedAt: 1,
    );
    final copy = newBusinessCardAsCopyOf(source, cardNameCopySuffix: ' (copy)');
    expect(copy.cardName, 'Name (copy)');
  });

  test('newBusinessCardAsCopyOf empty cardName skips suffix', () {
    final source = BusinessCard(
      id: 'a',
      cardName: '',
      displayFullName: '',
      displayOrg: '',
      displayTitle: '',
      displaySubtitle: '',
      primaryPhone: '',
      primaryEmail: '',
      contact: Contact(),
      qrAppearance: QrAppearance.defaultAppearance(),
      linkedContactId: null,
      createdAt: 1,
      updatedAt: 1,
    );
    final copy = newBusinessCardAsCopyOf(source, cardNameCopySuffix: ' (copy)');
    expect(copy.cardName, '');
  });
}
