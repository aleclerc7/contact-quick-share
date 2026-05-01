// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import '../../../core/utils/collation_sort.dart';
import '../../../core/utils/search_utils.dart';
import '../../contacts/models/search_hit.dart';
import '../models/business_card.dart';

int compareBusinessCardsForList(BusinessCard a, BusinessCard b) {
  final cmp = CollationSort.compareStrings(a.cardName, b.cardName);
  if (cmp != 0) return cmp;
  return CollationSort.compareStrings(a.displayFullName, b.displayFullName);
}

/// Filters and sorts [cards] like the main home list (accent-insensitive search).
List<(BusinessCard, SearchHit?)> filterAndSortBusinessCardsForDisplay(
  List<BusinessCard> cards,
  String query,
  bool includeNotes,
) {
  final trimmed = query.trim();
  if (trimmed.isEmpty) {
    final result = cards.map((c) => (c, null as SearchHit?)).toList();
    result.sort((a, b) => compareBusinessCardsForList(a.$1, b.$1));
    return result;
  }

  final withHits = <(BusinessCard, SearchHit?)>[];
  for (final card in cards) {
    final hit = findFirstHitInBusinessCard(
      card,
      trimmed,
      includeNotes: includeNotes,
    );
    if (hit != null) {
      withHits.add((card, hit));
    }
  }
  withHits.sort((a, b) => compareBusinessCardsForList(a.$1, b.$1));
  return withHits;
}
