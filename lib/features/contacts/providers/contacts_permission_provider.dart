// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'device_contact_repository_provider.dart';

part 'contacts_permission_provider.g.dart';

/// Single source of truth for contacts permission.
/// Requested at most once per app session; all contact access waits for this.
@Riverpod(keepAlive: true)
Future<bool> contactsPermission(Ref ref) async {
  final repo = ref.read(deviceContactRepositoryProvider);
  var hasPermission = await repo.hasPermission();
  if (!hasPermission) {
    hasPermission = await repo.requestPermission();
  }
  return hasPermission;
}
