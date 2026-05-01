// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../business_cards/models/business_card.dart';
import '../../business_cards/providers/business_cards_list_notifier.dart';
import '../../business_cards/utils/filter_business_cards_by_query.dart';
import '../models/search_hit.dart';
import 'contacts_list_notifier.dart';

part 'filtered_business_cards_provider.g.dart';

/// Filters business cards by search query (case- and accent-insensitive).
/// Matches all fields including contact.addresses, contact.notes, contact.websites, contact.socialMedias.
/// Returns (card, searchHit) pairs for display.
@Riverpod(keepAlive: true)
AsyncValue<List<(BusinessCard, SearchHit?)>> filteredBusinessCards(Ref ref) {
  final asyncCards = ref.watch(businessCardsListNotifierProvider);
  final searchQuery = ref.watch(contactsSearchQueryProvider).trim();
  final includeNotes = !Platform.isIOS;

  return asyncCards.when(
    data: (cards) => AsyncValue.data(
      filterAndSortBusinessCardsForDisplay(cards, searchQuery, includeNotes),
    ),
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
}
