// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../qr_code/qr_code.dart';
import '../../settings/providers/settings_notifier.dart';
import '../../settings/services/default_appearance_resolver.dart';
import '../models/business_card.dart';
import '../providers/business_card_detail_notifier.dart';
import '../../../l10n/app_localizations.dart';

/// Appearance tab: card colors, photos, QR style.
/// Delegates to [AppearanceEditorWidget] for single source of truth.
class BusinessCardAppearanceTab extends ConsumerWidget {
  const BusinessCardAppearanceTab({
    super.key,
    required this.card,
    required this.cardId,
    required this.onCardChanged,
  });

  final BusinessCard card;
  final String? cardId;
  final void Function(BusinessCard) onCardChanged;

  static AppearanceConfig _cardToConfig(BusinessCard card) {
    return AppearanceConfig(
      backgroundColor: card.backgroundColor,
      textColor: card.textColor,
      qrAppearance: card.qrAppearance,
      cardPhoto: card.cardPhoto,
      qrLogo: card.qrLogo,
    );
  }

  void _onConfigChanged(WidgetRef ref, BusinessCard card, AppearanceConfig config) {
    final baseCard = ref.read(businessCardDetailNotifierProvider(cardId)).valueOrNull ?? card;
    onCardChanged(baseCard.copyWith(
      backgroundColor: config.backgroundColor,
      textColor: config.textColor,
      qrAppearance: config.qrAppearance,
      cardPhoto: config.cardPhoto,
      qrLogo: config.qrLogo,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider).valueOrNull;
    final resolver = DefaultAppearanceResolver(
      settings: settings,
      colorScheme: Theme.of(context).colorScheme,
    );
    final loc = AppLocalizations.of(context)!;
    final displayName = card.displayFullName.isNotEmpty
        ? card.displayFullName
        : 'Your Name';
    final subtitle = [card.displayOrg, card.displayTitle]
        .where((s) => s.isNotEmpty)
        .join(' • ');
    final displaySubtitle =
        subtitle.isNotEmpty ? subtitle : loc.previewYourInfo;

    return AppearanceEditorWidget(
      config: _cardToConfig(card),
      onChanged: (config) => _onConfigChanged(ref, card, config),
      resolver: resolver,
      showPhotoSection: true,
      previewDisplayName: displayName,
      previewSubtitle: displaySubtitle,
      sampleVCardData: AppearanceEditorWidget.minimalPreviewVCard(
        card.displayFullName.isNotEmpty ? card.displayFullName : 'Your Name',
      ),
    );
  }
}
