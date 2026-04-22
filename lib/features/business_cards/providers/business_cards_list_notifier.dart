// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/di/app_providers.dart';
import '../models/business_card.dart';

part 'business_cards_list_notifier.g.dart';

/// ViewModel for the business cards list.
@Riverpod(keepAlive: true)
class BusinessCardsListNotifier extends _$BusinessCardsListNotifier {
  @override
  Future<List<BusinessCard>> build() async {
    final repo = ref.read(businessCardRepositoryProvider);
    return repo.getAll();
  }
}
