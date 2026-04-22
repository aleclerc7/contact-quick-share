// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/device_contact_repository.dart';

part 'device_contact_repository_provider.g.dart';

/// Repository instance for device contacts.
/// Extracted to avoid circular imports with contacts_permission_provider.
@Riverpod(keepAlive: true)
DeviceContactRepository deviceContactRepository(Ref ref) =>
    DeviceContactRepository();
