// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:contact_quick_share/core/utils/vcard_parameter_token.dart';
import 'package:contact_quick_share/features/contacts/utils/contact_to_vcard_mapper.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('vCardSafeTypeToken', () {
    test('empty and whitespace return x-custom', () {
      expect(vCardSafeTypeToken(null), 'x-custom');
      expect(vCardSafeTypeToken(''), 'x-custom');
      expect(vCardSafeTypeToken('   '), 'x-custom');
    });

    test('collapses spaces and lowercases', () {
      expect(vCardSafeTypeToken('Linkedin Showcase'), 'linkedin-showcase');
      expect(vCardSafeTypeToken('My Blog!'), 'my-blog');
    });

    test('preserves single-token labels', () {
      expect(vCardSafeTypeToken('github'), 'github');
      expect(vCardSafeTypeToken('GitHub'), 'github');
    });

    test('hyphenated input stays hyphenated', () {
      expect(vCardSafeTypeToken('linkedin-showcase'), 'linkedin-showcase');
    });

    test('only punctuation yields x-custom', () {
      expect(vCardSafeTypeToken('!!!'), 'x-custom');
      expect(vCardSafeTypeToken('---'), 'x-custom');
    });

    test('multiple internal spaces collapse to one hyphen', () {
      expect(vCardSafeTypeToken('a   b'), 'a-b');
    });
  });

  group('buildVCardFromContact custom social TYPE', () {
    test('uses slugified TYPE without spaces in parameter', () {
      final contact = Contact(
        displayName: 'Test User',
        socialMedias: [
          SocialMedia(
            username: 'janedoe',
            label: const Label(SocialMediaLabel.custom, 'Linkedin Showcase'),
          ),
        ],
      );

      final vcard = buildVCardFromContact(contact);

      expect(vcard, isNot(contains('X-CQS-SOCIAL-LABEL')));
      expect(vcard, contains('TYPE=linkedin-showcase'));
      expect(vcard, isNot(contains('TYPE=Linkedin Showcase')));
    });

    test('plain token custom social uses slug as TYPE', () {
      final contact = Contact(
        displayName: 'Test User',
        socialMedias: [
          SocialMedia(
            username: 'x',
            label: const Label(SocialMediaLabel.custom, 'myteam'),
          ),
        ],
      );

      final vcard = buildVCardFromContact(contact);

      expect(vcard, isNot(contains('X-CQS-SOCIAL-LABEL')));
      expect(vcard, contains('TYPE=myteam'));
    });
  });
}
