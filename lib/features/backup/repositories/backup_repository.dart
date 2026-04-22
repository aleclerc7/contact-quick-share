// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:convert';
import 'dart:io';

import '../../business_cards/models/business_card.dart';
import '../../business_cards/repositories/business_card_repository.dart';
import '../../settings/models/app_settings.dart';
import '../../settings/repositories/settings_repository.dart';
import '../models/backup_data.dart';

/// Repository for backup export and import.
class BackupRepository {
  BackupRepository({
    required SettingsRepository settingsRepository,
    required BusinessCardRepository businessCardRepository,
  })  : _settingsRepository = settingsRepository,
        _businessCardRepository = businessCardRepository;

  final SettingsRepository _settingsRepository;
  final BusinessCardRepository _businessCardRepository;

  static const _backupVersion = 1;

  /// Exports backup as JSON string.
  /// [includeSettings] and [includeCards] control what is included.
  Future<String> exportToJson({
    required bool includeSettings,
    required bool includeCards,
  }) async {
    AppSettings? settings;
    List<BusinessCard> cards = [];

    if (includeSettings) {
      settings = await _settingsRepository.load();
    }
    if (includeCards) {
      cards = await _businessCardRepository.getAll();
    }

    final backup = BackupData(
      backupVersion: _backupVersion,
      exportedAt: DateTime.now().toUtc().toIso8601String(),
      settings: settings,
      cards: cards,
    );

    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(backup.toJson());
  }

  /// Imports backup from file path.
  /// Throws [FormatException] on invalid or corrupted backup.
  Future<BackupData> importFromFile(String path) async {
    final bytes = await File(path).readAsBytes();
    final jsonStr = utf8.decode(bytes);
    final decoded = jsonDecode(jsonStr);

    if (decoded is! Map<String, dynamic>) {
      throw FormatException('Invalid backup: root must be a JSON object');
    }

    final version = decoded['backupVersion'];
    if (version != null && version is! int) {
      throw FormatException('Invalid backup: backupVersion must be a number');
    }

    return BackupData.fromJson(decoded);
  }
}
