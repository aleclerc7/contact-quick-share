// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/di/app_providers.dart';
import '../../qr_code/models/qr_appearance.dart';
import '../../settings/providers/settings_notifier.dart';
import '../models/business_card.dart';

part 'business_card_detail_notifier.g.dart';

/// ViewModel for a single business card (create or edit).
/// When [cardId] is null, creates a new card with default QrAppearance.
@riverpod
class BusinessCardDetailNotifier extends _$BusinessCardDetailNotifier {
  @override
  Future<BusinessCard?> build(String? cardId) async {
    final repo = ref.read(businessCardRepositoryProvider);

    if (cardId == null) {
      final settings = ref.read(settingsNotifierProvider).valueOrNull;
      final defaultQrAppearance =
          settings?.defaultQrAppearance ?? QrAppearance.defaultAppearance();
      final defaultBackgroundColor = settings?.defaultBackgroundColor;
      final defaultTextColor = settings?.defaultTextColor;

      final now = DateTime.now().millisecondsSinceEpoch;
      return BusinessCard(
        id: const Uuid().v4(),
        cardName: '',
        displayFullName: '',
        displayOrg: '',
        displayTitle: '',
        displaySubtitle: '',
        primaryPhone: '',
        primaryEmail: '',
        backgroundColor: defaultBackgroundColor,
        textColor: defaultTextColor,
        cardPhoto: null,
        qrLogo: null,
        contact: Contact(),
        qrAppearance: defaultQrAppearance,
        linkedContactId: null,
        createdAt: now,
        updatedAt: now,
      );
    }

    return repo.getById(cardId);
  }

  /// Updates the in-memory card without persisting.
  void updateCard(BusinessCard card) {
    state = AsyncData(card);
  }

  /// Saves the card to the database. Returns true on success, false on failure.
  /// Throws on error so the caller can show a message.
  Future<bool> save(BusinessCard card) async {
    final repo = ref.read(businessCardRepositoryProvider);
    final existing = await repo.getById(card.id);

    if (existing == null) {
      await repo.insert(card);
    } else {
      await repo.update(card);
    }
    state = AsyncData(card);
    return true;
  }

  Future<void> delete(String id) async {
    final repo = ref.read(businessCardRepositoryProvider);
    await repo.delete(id);
    state = const AsyncData(null);
  }
}
