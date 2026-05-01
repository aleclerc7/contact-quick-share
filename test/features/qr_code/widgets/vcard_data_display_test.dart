// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:contact_quick_share/features/qr_code/widgets/vcard_data_display.dart';
import 'package:contact_quick_share/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VcardDataDisplay.hasExpandableData', () {
    test(
      'false when only one phone, one email, and nickname matches summary',
      () {
        final c = Contact(
          displayName: 'Johnny',
          name: const Name(nickname: 'Johnny'),
          phones: [Phone(number: '111', label: const Label(PhoneLabel.mobile))],
          emails: [
            Email(address: 'a@b.c', label: const Label(EmailLabel.home)),
          ],
        );
        expect(
          VcardDataDisplay.hasExpandableData(c, summaryDisplayName: 'Johnny'),
          false,
        );
      },
    );

    test('true when a second phone exists', () {
      final c = Contact(
        displayName: 'John',
        phones: [
          Phone(number: '111', label: const Label(PhoneLabel.mobile)),
          Phone(number: '222', label: const Label(PhoneLabel.work)),
        ],
      );
      expect(
        VcardDataDisplay.hasExpandableData(c, summaryDisplayName: 'John'),
        true,
      );
    });

    test('true when nickname differs from summary display name', () {
      final c = Contact(
        displayName: 'John Doe',
        name: const Name(nickname: 'JD'),
        phones: [Phone(number: '111', label: const Label(PhoneLabel.mobile))],
      );
      expect(
        VcardDataDisplay.hasExpandableData(c, summaryDisplayName: 'John Doe'),
        true,
      );
    });
  });

  testWidgets('expanded body skips first phone and first email', (
    tester,
  ) async {
    final c = Contact(
      displayName: 'T',
      phones: [
        Phone(number: 'FIRST', label: const Label(PhoneLabel.mobile)),
        Phone(number: 'SECOND', label: const Label(PhoneLabel.work)),
      ],
      emails: [
        Email(address: 'first@x.com', label: const Label(EmailLabel.home)),
        Email(address: 'second@x.com', label: const Label(EmailLabel.work)),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: VcardDataDisplay(
            contact: c,
            textColor: Colors.black,
            summaryDisplayName: 'T',
          ),
        ),
      ),
    );

    expect(find.textContaining('FIRST'), findsNothing);
    expect(find.textContaining('first@x.com'), findsNothing);
    expect(find.textContaining('SECOND'), findsOneWidget);
    expect(find.textContaining('second@x.com'), findsOneWidget);
  });
}
