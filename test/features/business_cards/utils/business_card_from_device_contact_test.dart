// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:contact_quick_share/features/business_cards/utils/business_card_from_device_contact.dart';
import 'package:contact_quick_share/features/qr_code/models/qr_appearance.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'newBusinessCardFromDeviceContact deep-copies and leaves linkedContactId null',
    () {
      final source = Contact(
        id: 'dev-id-1',
        displayName: 'Jane Q. Public',
        name: const Name(
          first: 'Jane',
          last: 'Public',
          middle: 'Q.',
          nickname: 'J',
        ),
      );
      final result = newBusinessCardFromDeviceContact(
        source: source,
        defaultQrAppearance: QrAppearance.defaultAppearance(),
      );
      expect(result.linkedContactId, isNull);
      expect(result.displayFullName, 'Jane Q. Public');
      expect(result.cardName, 'Jane Q. Public');
      expect(result.contact, isNot(same(source)));
      expect(result.contact.id, 'dev-id-1');
      expect(result.contact.name?.first, 'Jane');
      expect(result.contact.name?.nickname, 'J');
    },
  );

  test('cardNameFromDeviceContact uses name parts when no displayName', () {
    final c = Contact(
      name: const Name(first: 'A', last: 'B'),
    );
    final result = newBusinessCardFromDeviceContact(
      source: c,
      defaultQrAppearance: QrAppearance.defaultAppearance(),
    );
    expect(result.cardName, 'A B');
  });

  test(
    'newBusinessCardFromDeviceContact dedupes duplicate phone numbers to one',
    () {
      final source = Contact(
        displayName: 'Pat',
        phones: [
          Phone(
            number: '+1 555-123-4567',
            label: const Label(PhoneLabel.mobile),
          ),
          Phone(number: '+1(555)123-4567', label: const Label(PhoneLabel.work)),
          Phone(number: '+1 555 123 4567', label: const Label(PhoneLabel.home)),
        ],
      );
      final result = newBusinessCardFromDeviceContact(
        source: source,
        defaultQrAppearance: QrAppearance.defaultAppearance(),
      );
      expect(result.contact.phones, hasLength(1));
      // First duplicate wins; [regeneratePreviewFields] uses the stored number as-is.
      expect(result.primaryPhone, '+1 555-123-4567');
    },
  );

  test(
    'newBusinessCardFromDeviceContact aligns displayName with name-part line '
    'when they differ (matches data tab getDraft with no edits)',
    () {
      final source = Contact(
        displayName: 'Doe, Jane',
        name: const Name(first: 'Jane', last: 'Doe'),
      );
      final result = newBusinessCardFromDeviceContact(
        source: source,
        defaultQrAppearance: QrAppearance.defaultAppearance(),
      );
      expect(result.displayFullName, 'Jane Doe');
      expect(result.contact.displayName, 'Jane Doe');
    },
  );

  test('newBusinessCardFromDeviceContact clears vCard displayName when no name '
      'parts (matches data tab getDraft; no spurious unsaved on back)', () {
    final source = Contact(
      displayName: 'Acme Corp',
      organizations: [Organization(name: 'Acme Corp')],
    );
    final result = newBusinessCardFromDeviceContact(
      source: source,
      defaultQrAppearance: QrAppearance.defaultAppearance(),
    );
    expect(result.displayFullName, isEmpty);
    expect(result.contact.displayName, isNull);
    expect(result.cardName, 'Acme Corp');
    expect(result.displayOrg, 'Acme Corp');
  });
}
