// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/supported_locales.dart';
import '../../backup/models/backup_data.dart';
import '../../backup/providers/backup_notifier.dart';
import '../../business_cards/providers/business_cards_list_notifier.dart';
import '../../business_cards/widgets/business_card_tile.dart';
import '../../qr_code/qr_code.dart';
import '../models/app_settings.dart';
import '../providers/debug_theme_provider.dart';
import '../providers/settings_notifier.dart';
import '../widgets/settings_section.dart';
import 'default_appearance_screen.dart';
import 'default_share_fields_screen.dart';
import 'license_screen.dart';
import 'simple_qr_screen.dart';

/// Settings screen: default QR style, theme, auto-open, privacy policy, license.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final asyncSettings = ref.watch(settingsNotifierProvider);
    final asyncCards = ref.watch(businessCardsListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settingsTitle),
      ),
      body: SafeArea(
        top: false,
        child: asyncSettings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(loc.errorGeneric(e.toString()))),
        data: (settings) {
          return ListView(
            children: [
              SettingsSection(
                title: loc.sharing,
                children: [
                  ListTile(
                    title: Text(loc.defaultShareFields),
                    subtitle: Text(loc.defaultShareFieldsSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const DefaultShareFieldsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: loc.appearance,
                children: [
                  ListTile(
                    title: Text(loc.defaultQrCodeStyle),
                    subtitle: Text(loc.defaultQrCodeStyleSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const DefaultAppearanceScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: loc.application,
                children: [
                  ListTile(
                    title: Text(loc.language),
                    subtitle: Text(_localeLabel(context, settings.locale)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _showLanguagePicker(context, ref, settings);
                    },
                  ),
                  ListTile(
                    title: Text(loc.theme),
                    subtitle: Text(_themeModeLabel(context, settings.themeMode)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SegmentedButton<ThemeMode>(
                      segments: [
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text(loc.themeAuto),
                          icon: const Icon(Icons.brightness_auto),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text(loc.themeLight),
                          icon: const Icon(Icons.light_mode),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text(loc.themeDark),
                          icon: const Icon(Icons.dark_mode),
                        ),
                      ],
                      selected: {settings.themeMode},
                      onSelectionChanged: (selected) {
                        final mode = selected.first;
                        ref
                            .read(settingsNotifierProvider.notifier)
                            .updateSettings(settings.copyWith(themeMode: mode));
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(loc.colorTheme),
                    subtitle: Text(
                      _colorThemeSubtitle(context, settings),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ..._colorThemeSwatches(context, settings),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () => _showColorThemePicker(
                      context,
                      ref,
                      settings,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(loc.autoOpenCardOnLaunch),
                    subtitle: asyncCards.when(
                      data: (cards) {
                        final cardId = settings.autoOpenCardId;
                        if (cardId == null) {
                          return Text(loc.none);
                        }
                        final card =
                            cards.where((c) => c.id == cardId).firstOrNull;
                        return Text(
                          card != null
                              ? (card.displayFullName.isNotEmpty
                                  ? card.displayFullName
                                  : card.cardName)
                              : loc.cardNotFound,
                        );
                      },
                      loading: () => Text(loc.loading),
                      error: (err, stack) => Text(loc.errorLoadingCards),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showAutoOpenPicker(context, ref, settings),
                  ),
                ],
              ),
              SettingsSection(
                title: loc.backup,
                children: [
                  ListTile(
                    title: Text(loc.export),
                    subtitle: Text(loc.exportSubtitle),
                    trailing: const Icon(Icons.upload_file),
                    onTap: () => _showExportDialog(context, ref),
                  ),
                  ListTile(
                    title: Text(loc.import),
                    subtitle: Text(loc.importSubtitle),
                    trailing: const Icon(Icons.download),
                    onTap: () => _importBackup(context, ref),
                  ),
                ],
              ),
              SettingsSection(
                title: loc.about,
                children: [
                  ListTile(
                    title: Text(loc.shareAppLink),
                    subtitle: Text(loc.shareAppLinkSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => SimpleQrScreen(
                            payload: SimpleQrPayload(
                              data: AppConstants.appDownloadPageUrl,
                              qrAppearance: settings.defaultQrAppearance,
                              backgroundColor: settings.defaultBackgroundColor,
                              textColor: settings.defaultTextColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(loc.privacyPolicy),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () => _openPrivacyPolicyUrl(context),
                  ),
                  ListTile(
                    title: Text(loc.license),
                    subtitle: Text(loc.licenseSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const LicenseScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
      ),
    );
  }

  Future<void> _openPrivacyPolicyUrl(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;
    final uri = Uri.parse(AppConstants.privacyPolicyUrl);
    try {
      final didLaunch = await launchUrl(uri, mode: LaunchMode.platformDefault);
      if (!didLaunch && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.couldNotOpenLink)),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.couldNotOpenLink)),
        );
      }
    }
  }

  String _colorThemeSubtitle(BuildContext context, AppSettings settings) {
    final loc = AppLocalizations.of(context)!;
    final hasAny =
        settings.themeSeedColor != null ||
        settings.themeSeedColorLight != null ||
        settings.themeSeedColorDark != null;
    if (!hasAny) return loc.colorThemeDefault;
    final useSeparate =
        settings.themeSeedColorLight != null ||
        settings.themeSeedColorDark != null;
    return useSeparate ? loc.colorThemeCustomLightDark : loc.colorThemeCustom;
  }

  List<Widget> _colorThemeSwatches(
    BuildContext context,
    AppSettings settings,
  ) {
    final swatches = <Widget>[];
    final seed = settings.themeSeedColor;
    final light = settings.themeSeedColorLight;
    final dark = settings.themeSeedColorDark;

    if (light != null || dark != null) {
      if (light != null) {
        swatches.add(_colorSwatch(context, Color(light)));
        swatches.add(const SizedBox(width: 4));
      }
      if (dark != null) {
        swatches.add(_colorSwatch(context, Color(dark)));
        swatches.add(const SizedBox(width: 4));
      }
    } else if (seed != null) {
      swatches.add(_colorSwatch(context, Color(seed)));
      swatches.add(const SizedBox(width: 8));
    }
    return swatches;
  }

  Widget _colorSwatch(BuildContext context, Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .outline
              .withValues(alpha: 0.5),
        ),
      ),
    );
  }

  String _themeModeLabel(BuildContext context, ThemeMode mode) {
    final loc = AppLocalizations.of(context)!;
    switch (mode) {
      case ThemeMode.system:
        return loc.themeFollowSystem;
      case ThemeMode.light:
        return loc.themeLightMode;
      case ThemeMode.dark:
        return loc.themeDarkMode;
    }
  }

  String _localeLabel(BuildContext context, Locale? locale) {
    final loc = AppLocalizations.of(context)!;
    if (locale == null) return loc.systemDefault;
    return SupportedLocales.displayName(locale);
  }

  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    final loc = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        final maxHeight = MediaQuery.of(sheetContext).size.height * 0.7;
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.brightness_auto),
                    title: Text(loc.systemDefault),
                    selected: settings.locale == null,
                    onTap: () {
                      ref
                          .read(settingsNotifierProvider.notifier)
                          .updateSettings(settings.copyWith(locale: null));
                      Navigator.of(sheetContext).pop();
                    },
                  ),
                  const Divider(height: 1),
                  ...SupportedLocales.locales.map(
                    (locale) => ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(SupportedLocales.displayName(locale)),
                      selected:
                          settings.locale?.languageCode == locale.languageCode,
                      onTap: () {
                        ref
                            .read(settingsNotifierProvider.notifier)
                            .updateSettings(settings.copyWith(locale: locale));
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showColorThemePicker(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    final loc = AppLocalizations.of(context)!;
    final useSeparate =
        settings.themeSeedColorLight != null ||
        settings.themeSeedColorDark != null;
    final hasCustom =
        settings.themeSeedColor != null || useSeparate;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Consumer(
          builder: (context, ref, _) {
            final asyncSettings = ref.watch(settingsNotifierProvider);
            return asyncSettings.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(loc.errorGeneric(e.toString()))),
              data: (currentSettings) {
                final useSameForBoth =
                    currentSettings.themeSeedColorLight == null &&
                    currentSettings.themeSeedColorDark == null;

                final maxHeight = MediaQuery.of(sheetContext).size.height * 0.7;
                return SafeArea(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxHeight),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      ListTile(
                        title: Text(loc.useDefault),
                        subtitle: Text(loc.useDefaultSubtitle),
                        leading: const Icon(Icons.palette_outlined),
                        onTap: () {
                          ref
                              .read(settingsNotifierProvider.notifier)
                              .updateSettings(
                                currentSettings.copyWith(
                                  themeSeedColor: null,
                                  themeSeedColorLight: null,
                                  themeSeedColorDark: null,
                                ),
                              );
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                      const Divider(height: 1),
                      if (hasCustom) ...[
                        SwitchListTile(
                          title: Text(loc.useSameForBoth),
                          subtitle: Text(loc.useSameForBothSubtitle),
                          value: useSameForBoth,
                          onChanged: (value) async {
                            if (value) {
                              final seed = currentSettings.themeSeedColor ??
                                  currentSettings.themeSeedColorLight ??
                                  currentSettings.themeSeedColorDark;
                              await ref
                                  .read(settingsNotifierProvider.notifier)
                                  .updateSettings(
                                    currentSettings.copyWith(
                                      themeSeedColor: seed,
                                      themeSeedColorLight: null,
                                      themeSeedColorDark: null,
                                    ),
                                  );
                            } else {
                              final seed = currentSettings.themeSeedColor ??
                                  currentSettings.themeSeedColorLight ??
                                  currentSettings.themeSeedColorDark ??
                                  Colors.blue.toARGB32();
                              await ref
                                  .read(settingsNotifierProvider.notifier)
                                  .updateSettings(
                                    currentSettings.copyWith(
                                      themeSeedColor: null,
                                      themeSeedColorLight: seed,
                                      themeSeedColorDark: seed,
                                    ),
                                  );
                            }
                          },
                        ),
                        const Divider(height: 1),
                      ],
                      if (useSameForBoth)
                        ListTile(
                          title: Text(loc.chooseColor),
                          subtitle: Text(loc.chooseColorSubtitle),
                          leading: const Icon(Icons.color_lens),
                          onTap: () => _openColorPicker(
                            sheetContext,
                            ref,
                            currentSettings,
                            forLight: null,
                            forDark: null,
                          ),
                        )
                      else ...[
                        ListTile(
                          title: Text(loc.lightModeColor),
                          leading: currentSettings.themeSeedColorLight != null
                              ? _colorSwatch(
                                  sheetContext,
                                  Color(currentSettings.themeSeedColorLight!),
                                )
                              : const Icon(Icons.light_mode),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _openColorPicker(
                            sheetContext,
                            ref,
                            currentSettings,
                            forLight: true,
                            forDark: null,
                          ),
                        ),
                        ListTile(
                          title: Text(loc.darkModeColor),
                          leading: currentSettings.themeSeedColorDark != null
                              ? _colorSwatch(
                                  sheetContext,
                                  Color(currentSettings.themeSeedColorDark!),
                                )
                              : const Icon(Icons.dark_mode),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _openColorPicker(
                            sheetContext,
                            ref,
                            currentSettings,
                            forLight: null,
                            forDark: true,
                          ),
                        ),
                      ],
                      if (kDebugMode) ...[
                        const Divider(height: 1),
                        SwitchListTile(
                          title: Text('Use default theme (debug)'), // Do not translate, only used in debug mode.
                          subtitle: Text('Preview embedded theme instead of OS colors (debug mode only)'), // Do not translate, only used in debug mode.
                          value: ref
                                  .watch(debugDisableOsThemeProvider)
                                  .valueOrNull ??
                              false,
                          onChanged: (value) {
                            ref
                                .read(debugDisableOsThemeProvider.notifier)
                                .toggle();
                          },
                        ),
                      ],
                    ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _openColorPicker(
    BuildContext sheetContext,
    WidgetRef ref,
    AppSettings settings, {
    required bool? forLight,
    required bool? forDark,
  }) async {
    Color initialColor;
    if (forLight == true && settings.themeSeedColorLight != null) {
      initialColor = Color(settings.themeSeedColorLight!);
    } else if (forDark == true && settings.themeSeedColorDark != null) {
      initialColor = Color(settings.themeSeedColorDark!);
    } else {
      initialColor = settings.themeSeedColor != null
          ? Color(settings.themeSeedColor!)
          : Colors.blue;
    }

    final picked = await showAppColorPickerDialogWithConfirmation(
      sheetContext,
      initialColor,
    );

    if (picked != null) {
      if (forLight == true) {
        await ref.read(settingsNotifierProvider.notifier).updateSettings(
              settings.copyWith(themeSeedColorLight: picked.toARGB32()),
            );
      } else if (forDark == true) {
        await ref.read(settingsNotifierProvider.notifier).updateSettings(
              settings.copyWith(themeSeedColorDark: picked.toARGB32()),
            );
      } else {
        await ref.read(settingsNotifierProvider.notifier).updateSettings(
              settings.copyWith(themeSeedColor: picked.toARGB32()),
            );
      }
    }
  }

  void _showExportDialog(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    bool includeSettings = true;
    bool includeCards = true;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(loc.exportBackup),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text(loc.exportAppSettings),
                value: includeSettings,
                onChanged: (value) => setState(() => includeSettings = value),
              ),
              SwitchListTile(
                title: Text(loc.exportContactCards),
                value: includeCards,
                onChanged: (value) => setState(() => includeCards = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(loc.cancel),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                final result = await ref
                    .read(backupNotifierProvider)
                    .export(
                      includeSettings: includeSettings,
                      includeCards: includeCards,
                    );
                if (!context.mounted) return;
                switch (result) {
                  case BackupSuccess():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.exportReadyToShare)),
                    );
                  case BackupError(:final message):
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                }
              },
              child: Text(loc.export),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importBackup(BuildContext context, WidgetRef ref) async {
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (pickerResult == null ||
        pickerResult.files.isEmpty ||
        pickerResult.files.single.path == null) {
      return;
    }
    final path = pickerResult.files.single.path!;

    BackupData backup;
    try {
      backup = await ref
          .read(backupRepositoryProvider)
          .importFromFile(path);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.invalidBackupFile(e.toString()))),
      );
      return;
    }

    final hasSettings = backup.settings != null;
    final hasCards = backup.cards.isNotEmpty;

    if (!hasSettings && !hasCards) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.backupFileEmpty)),
      );
      return;
    }

    if (!context.mounted) return;

    bool importSettings = hasSettings;
    bool importCards = hasCards;

    final loc = AppLocalizations.of(context)!;
    final result = await showDialog<({bool importSettings, bool importCards})>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(loc.importFromBackup),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text(loc.importSettings),
                value: importSettings,
                onChanged: hasSettings
                    ? (value) => setState(() => importSettings = value)
                    : null,
              ),
              SwitchListTile(
                title: Text(loc.importContactCards),
                value: importCards,
                onChanged: hasCards
                    ? (value) => setState(() => importCards = value)
                    : null,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(null),
              child: Text(loc.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop((
                importSettings: importSettings,
                importCards: importCards,
              )),
              child: Text(loc.import),
            ),
          ],
        ),
      ),
    );

    if (result == null || !context.mounted) return;

    final importResult = await ref.read(backupNotifierProvider).applyImport(
          backup: backup,
          importSettings: result.importSettings,
          importCards: result.importCards,
        );

    if (!context.mounted) return;
    switch (importResult) {
      case BackupSuccess():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.importCompleted)),
        );
      case BackupError(:final message):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
    }
  }

  void _showAutoOpenPicker(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    final cards = ref.read(businessCardsListNotifierProvider).valueOrNull ?? [];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        final maxHeight = MediaQuery.of(sheetContext).size.height * 0.7;
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: SingleChildScrollView(
              child: Consumer(
                builder: (context, ref, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.block_outlined),
                        title: Text(AppLocalizations.of(sheetContext)!.none),
                        selected: settings.autoOpenCardId == null,
                        onTap: () {
                          ref
                              .read(settingsNotifierProvider.notifier)
                              .updateSettings(
                                settings.copyWith(autoOpenCardId: null),
                              );
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                      const Divider(height: 1),
                      ...cards.map(
                        (card) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          child: BusinessCardTile(
                            card: card,
                            selected: settings.autoOpenCardId == card.id,
                            onTap: () {
                              ref
                                  .read(settingsNotifierProvider.notifier)
                                  .updateSettings(
                                    settings.copyWith(autoOpenCardId: card.id),
                                  );
                              Navigator.of(sheetContext).pop();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
