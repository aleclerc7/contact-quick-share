// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

/// Locales the app supports. Add ARB file (app_XX.arb) when adding a language.
class SupportedLocales {
  SupportedLocales._();

  static const List<Locale> locales = [
    Locale('en'),
    Locale('fr'),
    Locale('es'),
    Locale('pt'),
    Locale('de'),
    Locale('it'),
    Locale('nl'),
    Locale('pl'),
  ];

  /// Display name for a locale. Used in the language picker.
  static String displayName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      case 'pt':
        return 'Português (Brasil)';
      case 'es':
        return 'Español';
      case 'de':
        return 'Deutsch';
      case 'it':
        return 'Italiano';
      case 'nl':
        return 'Nederlands';
      case 'pl':
        return 'Polski';
      default:
        return locale.languageCode;
    }
  }
}
