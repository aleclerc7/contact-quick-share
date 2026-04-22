// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Opens and caches the app SQLite database (`cards.db` under documents).
///
/// Pass [databasePath] in unit tests (VM has no [path_provider] plugin).
class DatabaseManager {
  DatabaseManager({String? databasePath}) : _databasePath = databasePath;

  final String? _databasePath;

  Database? _db;

  Future<Database> openDb() async {
    if (_db != null) return _db!;

    final dbPath = _databasePath ??
        p.join(
          (await getApplicationDocumentsDirectory()).path,
          'cards.db',
        );

    _db = await openDatabase(
      dbPath,
      version: 2,
      onConfigure: (db) async {
        // Add any PRAGMA you want here later.
      },
      onCreate: (db, version) async {
        await _createMetaTable(db);
        await _createBusinessCardsTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _createBusinessCardsTable(db);
        }
      },
    );

    return _db!;
  }

  static Future<void> _createMetaTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS __meta (id INTEGER PRIMARY KEY, created_at TEXT)',
    );
  }

  static Future<void> _createBusinessCardsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS business_cards (
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
  }
}
