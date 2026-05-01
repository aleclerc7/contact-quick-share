// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../models/business_card.dart';
import '../providers/business_cards_list_notifier.dart';
import '../utils/filter_business_cards_by_query.dart';
import '../widgets/business_card_tile.dart';

/// Full-screen list to pick a [BusinessCard] to copy into a new draft.
/// Pops with the selected card or `null` if the user cancels.
class BusinessCardPickerForCopyScreen extends ConsumerStatefulWidget {
  const BusinessCardPickerForCopyScreen({super.key});

  @override
  ConsumerState<BusinessCardPickerForCopyScreen> createState() =>
      _BusinessCardPickerForCopyScreenState();
}

class _BusinessCardPickerForCopyScreenState
    extends ConsumerState<BusinessCardPickerForCopyScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final searchQuery = _searchController.text.trim();
    final asyncCards = ref.watch(businessCardsListNotifierProvider);
    final includeNotes = !Platform.isIOS;

    return Scaffold(
      appBar: AppBar(title: Text(loc.businessCardPickerForCopyTitle)),
      body: asyncCards.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              loc.errorGeneric(e.toString()),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (cards) {
          final filtered = filterAndSortBusinessCardsForDisplay(
            cards,
            searchQuery,
            includeNotes,
          );
          if (filtered.isEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: SearchBar(
                    controller: _searchController,
                    hintText: loc.searchHint,
                    leading: const Icon(Icons.search),
                    trailing: _searchController.text.isEmpty
                        ? null
                        : [
                            IconButton(
                              onPressed: () => _searchController.clear(),
                              icon: const Icon(Icons.close),
                              tooltip: loc.clearSearchTooltip,
                            ),
                          ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      searchQuery.isEmpty
                          ? loc.noCardsYet
                          : loc.noMatchingBusinessCards,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: SearchBar(
                  controller: _searchController,
                  hintText: loc.searchHint,
                  leading: const Icon(Icons.search),
                  trailing: _searchController.text.isEmpty
                      ? null
                      : [
                          IconButton(
                            onPressed: () => _searchController.clear(),
                            icon: const Icon(Icons.close),
                            tooltip: loc.clearSearchTooltip,
                          ),
                        ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final entry = filtered[index];
                    return BusinessCardTile(
                      card: entry.$1,
                      searchHit: entry.$2,
                      onTap: () => Navigator.of(context).pop(entry.$1),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
