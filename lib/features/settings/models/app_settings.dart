// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import '../../contacts/models/contact_field_selection.dart';
import '../../qr_code/models/qr_appearance.dart';

/// Application settings persisted to SharedPreferences.
class AppSettings {
  const AppSettings({
    this.defaultBackgroundColor,
    this.defaultTextColor,
    required this.defaultQrAppearance,
    this.themeMode = ThemeMode.system,
    this.themeSeedColor,
    this.themeSeedColorLight,
    this.themeSeedColorDark,
    this.autoOpenCardId,
    this.defaultShareFields,
    this.locale,
  });

  final int? defaultBackgroundColor;
  final int? defaultTextColor;
  final QrAppearance defaultQrAppearance;
  final ThemeMode themeMode;
  final int? themeSeedColor;
  final int? themeSeedColorLight;
  final int? themeSeedColorDark;
  final String? autoOpenCardId;
  final ContactFieldSelection? defaultShareFields;
  /// User-selected locale. Null means follow system.
  final Locale? locale;

  static const _key = 'app_settings_v1';

  static AppSettings fromJson(Map<String, dynamic> json) {
    final qrJson = json['defaultQrAppearance'];
    final qrAppearance = qrJson != null
        ? QrAppearance.fromJson(qrJson as Map<String, dynamic>)
        : QrAppearance.defaultAppearance();

    ThemeMode themeMode = ThemeMode.system;
    final themeStr = json['themeMode'] as String?;
    if (themeStr == 'light') {
      themeMode = ThemeMode.light;
    } else if (themeStr == 'dark') {
      themeMode = ThemeMode.dark;
    }

    ContactFieldSelection? defaultShareFields;
    final shareFieldsJson = json['defaultShareFields'];
    if (shareFieldsJson != null && shareFieldsJson is Map<String, dynamic>) {
      defaultShareFields = ContactFieldSelection.fromJson(shareFieldsJson);
    }

    Locale? locale;
    final localeStr = json['locale'] as String?;
    if (localeStr != null && localeStr.isNotEmpty) {
      locale = Locale(localeStr);
    }

    return AppSettings(
      defaultBackgroundColor: json['defaultBackgroundColor'] as int?,
      defaultTextColor: json['defaultTextColor'] as int?,
      defaultQrAppearance: qrAppearance,
      themeMode: themeMode,
      themeSeedColor: json['themeSeedColor'] as int?,
      themeSeedColorLight: json['themeSeedColorLight'] as int?,
      themeSeedColorDark: json['themeSeedColorDark'] as int?,
      autoOpenCardId: json['autoOpenCardId'] as String?,
      defaultShareFields: defaultShareFields,
      locale: locale,
    );
  }

  Map<String, dynamic> toJson() => {
        'defaultBackgroundColor': defaultBackgroundColor,
        'defaultTextColor': defaultTextColor,
        'defaultQrAppearance': defaultQrAppearance.toJson(),
        'themeMode': themeMode == ThemeMode.light
            ? 'light'
            : themeMode == ThemeMode.dark
                ? 'dark'
                : 'system',
        'themeSeedColor': themeSeedColor,
        'themeSeedColorLight': themeSeedColorLight,
        'themeSeedColorDark': themeSeedColorDark,
        'autoOpenCardId': autoOpenCardId,
        if (defaultShareFields != null)
          'defaultShareFields': defaultShareFields!.toJson(),
        if (locale != null) 'locale': locale!.languageCode,
      };

  static String get storageKey => _key;

  static const _undefined = Object();

  AppSettings copyWith({
    Object? defaultBackgroundColor = _undefined,
    Object? defaultTextColor = _undefined,
    QrAppearance? defaultQrAppearance,
    ThemeMode? themeMode,
    Object? themeSeedColor = _undefined,
    Object? themeSeedColorLight = _undefined,
    Object? themeSeedColorDark = _undefined,
    Object? autoOpenCardId = _undefined,
    ContactFieldSelection? defaultShareFields,
    Object? locale = _undefined,
  }) {
    return AppSettings(
      defaultBackgroundColor: identical(defaultBackgroundColor, _undefined)
          ? this.defaultBackgroundColor
          : defaultBackgroundColor as int?,
      defaultTextColor: identical(defaultTextColor, _undefined)
          ? this.defaultTextColor
          : defaultTextColor as int?,
      defaultQrAppearance: defaultQrAppearance ?? this.defaultQrAppearance,
      themeMode: themeMode ?? this.themeMode,
      themeSeedColor: identical(themeSeedColor, _undefined)
          ? this.themeSeedColor
          : themeSeedColor as int?,
      themeSeedColorLight: identical(themeSeedColorLight, _undefined)
          ? this.themeSeedColorLight
          : themeSeedColorLight as int?,
      themeSeedColorDark: identical(themeSeedColorDark, _undefined)
          ? this.themeSeedColorDark
          : themeSeedColorDark as int?,
      autoOpenCardId: identical(autoOpenCardId, _undefined)
          ? this.autoOpenCardId
          : autoOpenCardId as String?,
      defaultShareFields: defaultShareFields ?? this.defaultShareFields,
      locale: identical(locale, _undefined) ? this.locale : locale as Locale?,
    );
  }
}
