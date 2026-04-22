// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../qr_code/models/qr_appearance.dart';
import '../models/app_settings.dart';

/// Persists [AppSettings] to SharedPreferences.
class SettingsRepository {
  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(AppSettings.storageKey);
    if (jsonStr == null || jsonStr.isEmpty) {
      return AppSettings(
        defaultQrAppearance: QrAppearance.defaultAppearance(),
      );
    }
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    return AppSettings.fromJson(json);
  }

  Future<void> save(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppSettings.storageKey,
      jsonEncode(settings.toJson()),
    );
  }
}
