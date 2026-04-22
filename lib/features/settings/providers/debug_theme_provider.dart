// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _key = 'debug_disable_os_theme';

/// When true (debug mode only), use embedded default theme instead of OS dynamic colors.
/// Lets developers preview the theme that ships with the app on Android 12+.
/// In release builds, this provider always resolves to false.
final debugDisableOsThemeProvider =
    AsyncNotifierProvider<DebugDisableOsThemeNotifier, bool>(
  DebugDisableOsThemeNotifier.new,
);

class DebugDisableOsThemeNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    if (!kDebugMode) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<void> toggle() async {
    if (!kDebugMode) return;
    final current = state.valueOrNull ?? false;
    final next = !current;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, next);
    state = AsyncData(next);
  }
}
