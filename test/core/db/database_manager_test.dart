// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';

import 'package:contact_quick_share/core/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('openDb opens database and reuses same instance', () async {
    final tmp = await Directory.systemTemp.createTemp('cqs_db_test');
    final dbFile = p.join(tmp.path, 'cards.db');
    final manager = DatabaseManager(databasePath: dbFile);

    final db1 = await manager.openDb();
    final db2 = await manager.openDb();

    expect(db1, same(db2));

    await db1.close();
    await tmp.delete(recursive: true);
  });
}
