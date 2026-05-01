// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:contact_quick_share/features/contacts/models/contact_field_selection.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContactFieldSelection.applyToContact', () {
    test('clears nickname when nickname flag is false', () {
      const contactId = 'test-id';
      final contact = Contact(
        id: contactId,
        displayName: 'John Public',
        name: const Name(first: 'John', last: 'Public', nickname: 'Johnny'),
      );
      const sel = ContactFieldSelection(
        name: true,
        nickname: false,
        phones: false,
        emails: false,
        organizations: false,
      );
      final out = sel.applyToContact(contact);
      expect(out.name, isNotNull);
      expect(out.name!.first, 'John');
      expect(out.name!.last, 'Public');
      expect(out.name!.nickname, isNull);
    });

    test('keeps nickname when nickname flag is true', () {
      final contact = Contact(
        id: 'x',
        name: const Name(first: 'A', nickname: 'Ace'),
      );
      const sel = ContactFieldSelection(
        name: true,
        nickname: true,
        phones: false,
        emails: false,
        organizations: false,
      );
      final out = sel.applyToContact(contact);
      expect(out.name!.nickname, 'Ace');
    });
  });
}
