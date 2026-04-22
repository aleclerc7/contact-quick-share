// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:contact_quick_share/features/business_cards/models/business_card.dart';
import 'package:contact_quick_share/features/business_cards/repositories/business_card_repository.dart';
import 'package:contact_quick_share/features/qr_code/models/qr_appearance.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  Future<dynamic> createTestDb() async {
    return openDatabase(
      inMemoryDatabasePath,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE business_cards (
            id TEXT PRIMARY KEY,
            card_name TEXT,
            display_full_name TEXT,
            display_org TEXT,
            display_title TEXT,
            display_subtitle TEXT,
            primary_phone TEXT,
            primary_email TEXT,
            background_color INTEGER,
            text_color INTEGER,
            card_photo BLOB,
            qr_logo BLOB,
            contact_json TEXT NOT NULL,
            qr_appearance_json TEXT,
            linked_contact_id TEXT,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  BusinessCard createTestCard({
    String id = 'test-id-1',
    String cardName = 'Work',
    String displayFullName = 'Jane Doe',
    String displayOrg = 'Acme',
    String displayTitle = 'Engineer',
    String primaryPhone = '+1234567890',
    String primaryEmail = 'jane@acme.com',
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final contact = Contact(
      id: null,
      displayName: displayFullName,
      name: Name(first: 'Jane', last: 'Doe'),
      phones: [Phone(number: primaryPhone)],
      emails: [Email(address: primaryEmail)],
      organizations: [
        Organization(name: displayOrg, jobTitle: displayTitle),
      ],
    );
    return BusinessCard(
      id: id,
      cardName: cardName,
      displayFullName: displayFullName,
      displayOrg: displayOrg,
      displayTitle: displayTitle,
      displaySubtitle: '',
      primaryPhone: primaryPhone,
      primaryEmail: primaryEmail,
      backgroundColor: 0xFFE8E8E8,
      textColor: 0xFF1A1A1A,
      cardPhoto: null,
      qrLogo: null,
      contact: contact,
      qrAppearance: QrAppearance.defaultAppearance(),
      linkedContactId: null,
      createdAt: now,
      updatedAt: now,
    );
  }

  group('BusinessCardRepository', () {
    test('insert and getAll returns the saved card', () async {
      final db = await createTestDb();
      final repo = BusinessCardRepository.forTesting(db);

      final card = createTestCard();
      await repo.insert(card);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, card.id);
      expect(all.first.displayFullName, card.displayFullName);
      expect(all.first.primaryPhone, card.primaryPhone);

      await db.close();
    });

    test('insert and getById returns the saved card', () async {
      final db = await createTestDb();
      final repo = BusinessCardRepository.forTesting(db);

      final card = createTestCard(id: 'my-card-123');
      await repo.insert(card);

      final fetched = await repo.getById('my-card-123');
      expect(fetched, isNotNull);
      expect(fetched!.id, 'my-card-123');
      expect(fetched.displayFullName, 'Jane Doe');

      await db.close();
    });

    test('getById returns null for non-existent id', () async {
      final db = await createTestDb();
      final repo = BusinessCardRepository.forTesting(db);

      final fetched = await repo.getById('non-existent');
      expect(fetched, isNull);

      await db.close();
    });

    test('update modifies existing card', () async {
      final db = await createTestDb();
      final repo = BusinessCardRepository.forTesting(db);

      final card = createTestCard(displayFullName: 'Original');
      await repo.insert(card);

      final updated = card.copyWith(
        displayFullName: 'Updated Name',
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );
      await repo.update(updated);

      final fetched = await repo.getById(card.id);
      expect(fetched!.displayFullName, 'Updated Name');

      await db.close();
    });

    test('delete removes the card', () async {
      final db = await createTestDb();
      final repo = BusinessCardRepository.forTesting(db);

      final card = createTestCard();
      await repo.insert(card);
      expect(await repo.getAll(), hasLength(1));

      await repo.delete(card.id);
      expect(await repo.getAll(), isEmpty);
      expect(await repo.getById(card.id), isNull);

      await db.close();
    });

    test('multiple cards are stored and retrieved correctly', () async {
      final db = await createTestDb();
      final repo = BusinessCardRepository.forTesting(db);

      final card1 = createTestCard(id: 'id-1', displayFullName: 'First');
      final card2 = createTestCard(id: 'id-2', displayFullName: 'Second');
      await repo.insert(card1);
      await repo.insert(card2);

      final all = await repo.getAll();
      expect(all, hasLength(2));
      expect(all.map((c) => c.id).toList(), containsAll(['id-1', 'id-2']));

      await db.close();
    });
  });
}
