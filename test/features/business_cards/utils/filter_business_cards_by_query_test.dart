// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:contact_quick_share/features/business_cards/models/business_card.dart';
import 'package:contact_quick_share/features/business_cards/utils/filter_business_cards_by_query.dart';
import 'package:contact_quick_share/features/qr_code/models/qr_appearance.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';

BusinessCard _card({
  required String id,
  required String cardName,
  String displayFullName = '',
}) {
  return BusinessCard(
    id: id,
    cardName: cardName,
    displayFullName: displayFullName,
    displayOrg: '',
    displayTitle: '',
    displaySubtitle: '',
    primaryPhone: '',
    primaryEmail: '',
    contact: Contact(),
    qrAppearance: QrAppearance.defaultAppearance(),
    linkedContactId: null,
    createdAt: 0,
    updatedAt: 0,
  );
}

void main() {
  test(
    'filterAndSortBusinessCardsForDisplay empty query sorts by cardName',
    () {
      final a = _card(id: '1', cardName: 'Zebra');
      final b = _card(id: '2', cardName: 'Alpha');
      final out = filterAndSortBusinessCardsForDisplay([a, b], '', true);
      expect(out.map((e) => e.$1.cardName).toList(), ['Alpha', 'Zebra']);
      expect(out.every((e) => e.$2 == null), isTrue);
    },
  );

  test('filterAndSortBusinessCardsForDisplay filters by cardName', () {
    final keep = _card(id: '1', cardName: 'Networking');
    final drop = _card(id: '2', cardName: 'Other');
    final out = filterAndSortBusinessCardsForDisplay([keep, drop], 'net', true);
    expect(out, hasLength(1));
    expect(out.single.$1.cardName, 'Networking');
  });
}
