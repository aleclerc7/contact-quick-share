// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../business_cards/models/business_card.dart';
import '../../business_cards/providers/business_cards_list_notifier.dart';
import '../../../core/utils/collation_sort.dart';
import '../../../core/utils/search_utils.dart';
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
    data: (cards) => AsyncValue.data(_filterAndSortCards(cards, searchQuery, includeNotes)),
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
}

int _compareBusinessCards(
  (BusinessCard, SearchHit?) a,
  (BusinessCard, SearchHit?) b,
) {
  final cmp = CollationSort.compareStrings(a.$1.cardName, b.$1.cardName);
  if (cmp != 0) return cmp;
  return CollationSort.compareStrings(a.$1.displayFullName, b.$1.displayFullName);
}

List<(BusinessCard, SearchHit?)> _filterAndSortCards(
  List<BusinessCard> cards,
  String query,
  bool includeNotes,
) {
  if (query.isEmpty) {
    final result = cards.map((c) => (c, null as SearchHit?)).toList();
    result.sort(_compareBusinessCards);
    return result;
  }

  final withHits = <(BusinessCard, SearchHit?)>[];
  for (final card in cards) {
    final hit = findFirstHitInBusinessCard(card, query, includeNotes: includeNotes);
    if (hit != null) {
      withHits.add((card, hit));
    }
  }
  withHits.sort(_compareBusinessCards);
  return withHits;
}
