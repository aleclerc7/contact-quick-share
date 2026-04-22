// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:contact_quick_share/features/contacts/utils/contact_share_deduplicator.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toShareDedupedContact', () {
    test('deduplicates phones by normalized number and keeps first', () {
      final source = Contact(
        displayName: 'Test',
        phones: [
          Phone(number: '+1 555-1234', label: const Label(PhoneLabel.mobile)),
          Phone(number: '+1(555)1234', label: const Label(PhoneLabel.work)),
          Phone(number: '999-000', label: const Label(PhoneLabel.home)),
        ],
      );

      final deduped = toShareDedupedContact(source);

      expect(deduped.phones.length, 2);
      expect(deduped.phones.first.number, '+1 555-1234');
      expect(deduped.phones.last.number, '999-000');
    });

    test('deduplicates emails ignoring case and whitespace', () {
      final source = Contact(
        displayName: 'Test',
        emails: [
          Email(address: '  John@Example.com  ', label: const Label(EmailLabel.home)),
          Email(address: 'john@example.com', label: const Label(EmailLabel.work)),
          Email(address: 'jane@example.com', label: const Label(EmailLabel.other)),
        ],
      );

      final deduped = toShareDedupedContact(source);

      expect(deduped.emails.length, 2);
      expect(deduped.emails.first.address, '  John@Example.com  ');
      expect(deduped.emails.last.address, 'jane@example.com');
    });

    test('does not alter distinct values and preserves order', () {
      final source = Contact(
        displayName: 'Test',
        websites: [
          Website(url: 'https://example.com', label: const Label(WebsiteLabel.homepage)),
          Website(url: 'https://example.org', label: const Label(WebsiteLabel.homepage)),
          Website(url: 'https://example.com', label: const Label(WebsiteLabel.homepage)),
        ],
        notes: [
          Note(note: 'Hello world'),
          Note(note: 'Hello   world'),
          Note(note: 'Another note'),
        ],
      );

      final deduped = toShareDedupedContact(source);

      expect(deduped.websites.length, 2);
      expect(deduped.websites[0].url, 'https://example.com');
      expect(deduped.websites[1].url, 'https://example.org');

      expect(deduped.notes.length, 2);
      expect(deduped.notes[0].note, 'Hello world');
      expect(deduped.notes[1].note, 'Another note');
    });
  });
}
