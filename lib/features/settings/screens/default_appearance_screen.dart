// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../qr_code/qr_code.dart';
import '../models/app_settings.dart';
import '../providers/settings_notifier.dart';
import '../services/default_appearance_resolver.dart';

/// Full-screen editor for default QR code style (card colors, font, QR appearance).
/// Reuses [AppearanceEditorWidget] with [showPhotoSection: false].
class DefaultAppearanceScreen extends ConsumerWidget {
  const DefaultAppearanceScreen({super.key});

  static AppearanceConfig _settingsToConfig(AppSettings settings) {
    return AppearanceConfig(
      backgroundColor: settings.defaultBackgroundColor,
      textColor: settings.defaultTextColor,
      qrAppearance: settings.defaultQrAppearance,
      cardPhoto: null,
      qrLogo: null,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final asyncSettings = ref.watch(settingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.defaultQrCodeStyle),
      ),
      body: SafeArea(
        top: false,
        child: asyncSettings.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(loc.errorGeneric(e.toString()))),
          data: (settings) {
            return AppearanceEditorWidget(
              config: _settingsToConfig(settings),
              onChanged: (config) async {
                await ref.read(settingsNotifierProvider.notifier).updateSettings(
                      settings.copyWith(
                        defaultBackgroundColor: config.backgroundColor,
                        defaultTextColor: config.textColor,
                        defaultQrAppearance: config.qrAppearance,
                      ),
                    );
              },
              resolver: DefaultAppearanceResolver(
                settings: settings,
                colorScheme: Theme.of(context).colorScheme,
              ),
              showPhotoSection: false,
              previewDisplayName: loc.previewYourName,
              previewSubtitle: loc.previewYourInfo,
            );
          },
        ),
      ),
    );
  }
}
