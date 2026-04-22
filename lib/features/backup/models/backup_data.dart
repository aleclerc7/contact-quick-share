// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import '../../business_cards/models/business_card.dart';
import '../../settings/models/app_settings.dart';

/// Backup data model for export/import.
/// settings and cards may be null when selectively exported.
class BackupData {
  const BackupData({
    required this.backupVersion,
    required this.exportedAt,
    this.settings,
    this.cards = const [],
  });

  final int backupVersion;
  final String exportedAt;
  final AppSettings? settings;
  final List<BusinessCard> cards;

  Map<String, dynamic> toJson() => {
        'backupVersion': backupVersion,
        'exportedAt': exportedAt,
        'appName': 'Contact Quick Share',
        if (settings != null) 'settings': settings!.toJson(),
        if (cards.isNotEmpty) 'cards': cards.map((c) => c.toBackupJson()).toList(),
      };

  factory BackupData.fromJson(Map<String, dynamic> json) {
    AppSettings? settings;
    final settingsJson = json['settings'];
    if (settingsJson != null && settingsJson is Map<String, dynamic>) {
      try {
        settings = AppSettings.fromJson(settingsJson);
      } catch (e) {
        throw FormatException('Invalid backup: invalid settings format');
      }
    }

    final cardsJson = json['cards'];
    final List<BusinessCard> cards = [];
    if (cardsJson != null && cardsJson is List) {
      for (final item in cardsJson) {
        if (item is Map<String, dynamic>) {
          cards.add(BusinessCard.fromBackupJson(item));
        }
      }
    }

    return BackupData(
      backupVersion: json['backupVersion'] as int? ?? 1,
      exportedAt: json['exportedAt'] as String? ?? '',
      settings: settings,
      cards: cards,
    );
  }
}
