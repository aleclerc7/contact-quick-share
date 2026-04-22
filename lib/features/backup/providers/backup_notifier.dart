// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/services/share_service.dart';
import '../../settings/models/app_settings.dart';
import '../../business_cards/providers/business_cards_list_notifier.dart';
import '../../business_cards/repositories/business_card_repository.dart';
import '../../settings/providers/settings_notifier.dart';
import '../../settings/repositories/settings_repository.dart';
import '../models/backup_data.dart';
import '../repositories/backup_repository.dart';

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return BackupRepository(
    settingsRepository: ref.watch(settingsRepositoryProvider),
    businessCardRepository: ref.watch(businessCardRepositoryProvider),
  );
});

/// Result of an export or import operation.
sealed class BackupResult {
  const BackupResult();
}

class BackupSuccess extends BackupResult {
  const BackupSuccess();
}

class BackupError extends BackupResult {
  const BackupError(this.message);
  final String message;
}

/// Notifier for backup export and import operations.
class BackupNotifier {
  BackupNotifier(this._ref)
      : _repo = _ref.read(backupRepositoryProvider),
        _settingsRepo = _ref.read(settingsRepositoryProvider),
        _cardsRepo = _ref.read(businessCardRepositoryProvider);

  final Ref _ref;
  final BackupRepository _repo;
  final SettingsRepository _settingsRepo;
  final BusinessCardRepository _cardsRepo;

  /// Exports backup and opens share sheet.
  /// Returns [BackupSuccess] or [BackupError].
  Future<BackupResult> export({
    required bool includeSettings,
    required bool includeCards,
  }) async {
    try {
      final json = await _repo.exportToJson(
        includeSettings: includeSettings,
        includeCards: includeCards,
      );
      final now = DateTime.now();
      final date = now.toIso8601String().split('T').first;
      final time = '${now.hour.toString().padLeft(2, '0')}-'
          '${now.minute.toString().padLeft(2, '0')}-'
          '${now.second.toString().padLeft(2, '0')}';
      final bytes = Uint8List.fromList(utf8.encode(json));
      
      const shareService = ShareService();
      await shareService.share(
        ShareParams(
          files: [
            XFile.fromData(
              bytes,
              mimeType: 'application/json',
            ),
          ],
          fileNameOverrides: ['contact_quick_share_export_${date}_$time.json'],
          text: 'Contact Quick Share backup',
          subject: 'Contact Quick Share backup',
        ),
      );
      return const BackupSuccess();
    } catch (e) {
      return BackupError('Export failed: $e');
    }
  }

  /// Applies imported backup. Merges settings, add/replace cards.
  /// Returns [BackupSuccess] or [BackupError].
  Future<BackupResult> applyImport({
    required BackupData backup,
    required bool importSettings,
    required bool importCards,
  }) async {
    try {
      if (importSettings && backup.settings != null) {
        final current = await _settingsRepo.load();
        final backupJson = backup.settings!.toJson();
        final merged = {...current.toJson(), ...backupJson};
        final mergedSettings = AppSettings.fromJson(merged);
        await _settingsRepo.save(mergedSettings);
        _ref.invalidate(settingsNotifierProvider);
      }

      if (importCards && backup.cards.isNotEmpty) {
        for (final card in backup.cards) {
          final existing = await _cardsRepo.getById(card.id);
          if (existing != null) {
            await _cardsRepo.update(card);
          } else {
            await _cardsRepo.insert(card);
          }
        }
        _ref.invalidate(businessCardsListNotifierProvider);
      }

      return const BackupSuccess();
    } catch (e) {
      return BackupError('Import failed: $e');
    }
  }
}

final backupNotifierProvider = Provider<BackupNotifier>((ref) {
  return BackupNotifier(ref);
});
