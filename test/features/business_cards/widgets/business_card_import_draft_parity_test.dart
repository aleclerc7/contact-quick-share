// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:contact_quick_share/features/business_cards/utils/business_card_from_device_contact.dart'
    as import_util;
import 'package:contact_quick_share/features/business_cards/widgets/business_card_data_tab.dart'
    show BusinessCardDataTab, BusinessCardDataTabState;
import 'package:contact_quick_share/features/qr_code/models/qr_appearance.dart';
import 'package:contact_quick_share/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'getDraft after import from device contact matches seed (no false dirty) '
    '— rich contact including job title only (no org name), two addresses, '
    'two sites',
    (WidgetTester tester) async {
      const addr1 = '123 Some Road\nSomePlace, QR\nQRCode Country';
      const addr2 = '321 Drive Home\nTentcity\nSomewhere';

      final source = Contact(
        displayName: 'Mr. Al Most Dente Jr',
        name: const Name(
          prefix: 'Mr.',
          first: 'Al',
          middle: 'Most',
          last: 'Dente',
          suffix: 'Jr',
          nickname: 'Ceilstick',
        ),
        organizations: [const Organization(jobTitle: 'Quality Control')],
        phones: [
          Phone(
            number: '+39 333 555 4567',
            label: const Label(PhoneLabel.mobile),
          ),
        ],
        emails: [
          Email(
            address: 'al.dente@gmail.com',
            label: const Label(EmailLabel.work),
          ),
        ],
        addresses: [
          Address(formatted: addr1, label: const Label(AddressLabel.work)),
          Address(formatted: addr2, label: const Label(AddressLabel.home)),
        ],
        websites: [
          Website(
            url: 'https://someplace.tld',
            label: const Label(WebsiteLabel.work),
          ),
          Website(
            url: 'https://otherplace.tld',
            label: const Label(WebsiteLabel.profile),
          ),
        ],
        notes: [const Note(note: 'All about Dente.')],
      );

      final seed = import_util.newBusinessCardFromDeviceContact(
        source: source,
        defaultQrAppearance: QrAppearance.defaultAppearance(),
      );

      final dataTabKey = GlobalKey<BusinessCardDataTabState>();

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(
            body: BusinessCardDataTab(key: dataTabKey, card: seed),
          ),
        ),
      );
      await tester.pump();

      final dataDraft = dataTabKey.currentState!.getDraftCard();
      final forComparison = dataDraft.copyWith(
        backgroundColor: seed.backgroundColor,
        textColor: seed.textColor,
        qrAppearance: seed.qrAppearance,
        cardPhoto: seed.cardPhoto,
        qrLogo: seed.qrLogo,
      );
      expect(
        forComparison.hasChangesComparedTo(seed),
        isFalse,
        reason:
            'Draft with no user edits should match [hasChangesComparedTo] baseline; '
            'e.g. job title without org name must round-trip the same as import.',
      );
    },
  );
}
