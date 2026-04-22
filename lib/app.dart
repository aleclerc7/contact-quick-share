// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/widgets/initial_route_widget.dart';
import 'l10n/app_localizations.dart';
import 'features/settings/providers/debug_theme_provider.dart';
import 'features/settings/settings.dart';

/// Root widget: MaterialApp with theme and routing.
/// go_router integration (commented for now):
///   - routerConfig: routerConfig,
class ContactQuickShareApp extends ConsumerWidget {
  const ContactQuickShareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider).valueOrNull;
    final themeMode = settings?.themeMode ?? ThemeMode.system;
    final themeSeedColor = settings?.themeSeedColor;
    final themeSeedColorLight = settings?.themeSeedColorLight;
    final themeSeedColorDark = settings?.themeSeedColorDark;
    final debugDisableOsTheme =
        ref.watch(debugDisableOsThemeProvider).valueOrNull ?? false;

    final useEmbeddedOnly = kDebugMode && debugDisableOsTheme;

    final seedLight = themeSeedColorLight ?? themeSeedColor;
    final seedDark = themeSeedColorDark ?? themeSeedColor;
    final useUserColorLight = seedLight != null;
    final useUserColorDark = seedDark != null;

    final effectiveSeedLight = seedLight ?? Colors.blue.toARGB32();
    final effectiveSeedDark = seedDark ?? Colors.blue.toARGB32();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final light = useUserColorLight || useEmbeddedOnly
            ? ColorScheme.fromSeed(
                seedColor: Color(effectiveSeedLight),
              )
            : (lightDynamic ?? ColorScheme.fromSeed(seedColor: Colors.blue));
        final dark = useUserColorDark || useEmbeddedOnly
            ? ColorScheme.fromSeed(
                seedColor: Color(effectiveSeedDark),
                brightness: Brightness.dark,
              )
            : (darkDynamic ??
                ColorScheme.fromSeed(
                  seedColor: Colors.blue,
                  brightness: Brightness.dark,
                ));
        return MaterialApp(
          onGenerateTitle: (context) =>
              AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: light, useMaterial3: true),
          darkTheme: ThemeData(colorScheme: dark, useMaterial3: true),
          themeMode: themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: settings?.locale,
          home: const InitialRouteWidget(),
        );
      },
    );
  }
}
