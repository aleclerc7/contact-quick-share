// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:sqflite/sqflite.dart';

import '../../../core/db/database_manager.dart';
import '../models/business_card.dart';

/// Repository for business card CRUD operations.
class BusinessCardRepository {
  BusinessCardRepository(this._dbManager) : _dbOverride = null;

  /// For unit tests: inject a [Database] directly, bypassing [DatabaseManager].
  BusinessCardRepository.forTesting(Database db)
      : _dbManager = null,
        _dbOverride = Future.value(db);

  final DatabaseManager? _dbManager;
  final Future<Database>? _dbOverride;

  Future<Database> get _db async =>
      _dbOverride ?? _dbManager!.openDb();

  Future<List<BusinessCard>> getAll() async {
    final db = await _db;
    final rows = await db.query(
      'business_cards',
      orderBy: 'updated_at DESC',
    );
    return rows.map(_rowToBusinessCard).toList();
  }

  Future<BusinessCard?> getById(String id) async {
    final db = await _db;
    final rows = await db.query(
      'business_cards',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (rows.isEmpty) return null;
    return _rowToBusinessCard(rows.first);
  }

  Future<void> insert(BusinessCard card) async {
    final db = await _db;
    await db.insert('business_cards', _businessCardToRow(card));
  }

  Future<void> update(BusinessCard card) async {
    final db = await _db;
    await db.update(
      'business_cards',
      _businessCardToRow(card),
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await _db;
    await db.delete(
      'business_cards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  BusinessCard _rowToBusinessCard(Map<String, dynamic> row) {
    return BusinessCard.fromJson({
      'id': row['id'],
      'card_name': row['card_name'],
      'display_full_name': row['display_full_name'],
      'display_org': row['display_org'],
      'display_title': row['display_title'],
      'display_subtitle': row['display_subtitle'],
      'primary_phone': row['primary_phone'],
      'primary_email': row['primary_email'],
      'background_color': row['background_color'],
      'text_color': row['text_color'],
      'card_photo': row['card_photo'],
      'qr_logo': row['qr_logo'],
      'contact_json': row['contact_json'],
      'qr_appearance_json': row['qr_appearance_json'],
      'linked_contact_id': row['linked_contact_id'],
      'created_at': row['created_at'],
      'updated_at': row['updated_at'],
    });
  }

  Map<String, dynamic> _businessCardToRow(BusinessCard card) {
    return {
      'id': card.id,
      'card_name': card.cardName,
      'display_full_name': card.displayFullName,
      'display_org': card.displayOrg,
      'display_title': card.displayTitle,
      'display_subtitle': card.displaySubtitle,
      'primary_phone': card.primaryPhone,
      'primary_email': card.primaryEmail,
      'background_color': card.backgroundColor,
      'text_color': card.textColor,
      'card_photo': card.cardPhoto,
      'qr_logo': card.qrLogo,
      'contact_json': card.toJson()['contact_json'],
      'qr_appearance_json': card.toJson()['qr_appearance_json'],
      'linked_contact_id': card.linkedContactId,
      'created_at': card.createdAt,
      'updated_at': card.updatedAt,
    };
  }
}
