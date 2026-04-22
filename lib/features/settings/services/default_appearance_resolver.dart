// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import '../models/app_settings.dart';

/// Single source of truth for resolving card/contact colors.
/// Cascade: explicit value -> settings default -> theme.
/// Encapsulates theme fallback logic (surfaceContainerLow for card bg, onSurface for text).
class DefaultAppearanceResolver {
  const DefaultAppearanceResolver({
    required this.settings,
    required this.colorScheme,
  });

  final AppSettings? settings;
  final ColorScheme colorScheme;

  Color get defaultBackgroundColor =>
      settings?.defaultBackgroundColor != null
          ? Color(settings!.defaultBackgroundColor!)
          : colorScheme.surfaceContainerLow;

  Color get defaultTextColor =>
      settings?.defaultTextColor != null
          ? Color(settings!.defaultTextColor!)
          : colorScheme.onSurface;

  /// Default QR module color (settings default or theme onSurface).
  Color get defaultQrPrimaryColor =>
      settings?.defaultQrAppearance.primaryColor != null
          ? Color(settings!.defaultQrAppearance.primaryColor!)
          : colorScheme.onSurface;

  Color resolveBackgroundColor(int? value) =>
      value != null ? Color(value) : defaultBackgroundColor;

  Color resolveTextColor(int? value) =>
      value != null ? Color(value) : defaultTextColor;

  Color resolveQrPrimaryColor(int? value) =>
      value != null ? Color(value) : defaultQrPrimaryColor;
}
