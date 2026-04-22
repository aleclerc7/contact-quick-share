// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/database_manager.dart';
import '../../features/business_cards/repositories/business_card_repository.dart';
import '../../features/qr_code/services/qr_share_service.dart';

/// Global Riverpod override container and shared providers.
/// Use for dependency injection overrides in tests or environment-specific config.
///
/// Example overrides:
///   ProviderScope(
///     overrides: [
///       databaseManagerProvider.overrideWithValue(mockManager),
///     ],
///     child: MyApp(),
///   )
final List<Override> appOverrides = [];

/// Manager for the app SQLite database.
final databaseManagerProvider = Provider<DatabaseManager>((ref) {
  return DatabaseManager();
});

/// Service for sharing QR codes as image or vCard.
final qrShareServiceProvider = Provider<QrShareService>((ref) {
  return const QrShareService();
});

/// Repository for business card CRUD operations.
final businessCardRepositoryProvider =
    Provider<BusinessCardRepository>((ref) {
  final dbManager = ref.watch(databaseManagerProvider);
  return BusinessCardRepository(dbManager);
});
