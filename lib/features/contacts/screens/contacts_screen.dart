// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:async';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../business_cards/models/business_card.dart';
import '../../business_cards/providers/business_cards_list_notifier.dart';
import '../providers/filtered_business_cards_provider.dart';
import '../../business_cards/screens/business_card_detail_screen.dart';
import '../../business_cards/widgets/business_card_tile.dart';
import '../../settings/settings.dart';
import 'contact_field_selection_screen.dart';
import '../providers/contacts_list_notifier.dart';
import '../models/search_hit.dart';
import '../widgets/contact_list_tile.dart';

/// Main screen: search, business cards (★), device contacts (A–Z).
/// Tap opens field selection (placeholder for now).
class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  Timer? _debounceTimer;

  void _onFocusChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchFocusNode.removeListener(_onFocusChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      ref.read(contactsSearchQueryProvider.notifier).setQuery(
            _searchController.text,
          );
    });
  }

  void _onClearSearch() {
    _debounceTimer?.cancel();
    _searchController.clear();
    _searchFocusNode.unfocus();
    ref.read(contactsSearchQueryProvider.notifier).setQuery('');
  }

  Future<void> _openAppSettings() async {
    await FlutterContacts.permissions.openSettings();
  }

  void _onSettingsTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _onContactTap(Contact contact) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ContactFieldSelectionScreen(contact: contact),
      ),
    );
  }

  void _onNewBusinessCard() {
    Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => const BusinessCardDetailScreen(cardId: null),
      ),
    ).then((result) {
      if (result != false) {
        ref.invalidate(businessCardsListNotifierProvider);
      }
    });
  }

  void _onBusinessCardTap(String cardId) {
    Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => BusinessCardDetailScreen(cardId: cardId),
      ),
    ).then((result) {
      if (result != false) {
        ref.invalidate(businessCardsListNotifierProvider);
      }
    });
  }

  Future<void> _onRefresh() async {
    ref.invalidate(rawContactsProvider);
    await ref.read(rawContactsProvider.future);
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool permissionDenied,
    bool noSearch, [
    String? cardsLoadError,
  ]) {
    final loc = AppLocalizations.of(context)!;
    if (!noSearch) {
      return Center(
        child: Text(
          loc.noMatchingContacts,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              permissionDenied ? Icons.contacts_outlined : Icons.badge_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              cardsLoadError != null
                  ? loc.couldNotLoadBusinessCards(cardsLoadError)
                  : permissionDenied
                      ? loc.contactPermissionRequired
                      : loc.noCardsYet,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (permissionDenied) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _openAppSettings,
                icon: const Icon(Icons.settings),
                label: Text(loc.openSettings),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddCardPlaceholder(BuildContext context, [String? loadError]) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Card(
        child: InkWell(
          onTap: loadError != null ? null : _onNewBusinessCard,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  loadError != null ? Icons.error_outline : Icons.add_circle_outline,
                  size: 48,
                  color: loadError != null
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  loadError ?? loc.noCardsYet,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (loadError == null) ...[
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _onNewBusinessCard,
                    icon: const Icon(Icons.add),
                    label: Text(loc.addBusinessCard),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  static AlphabetListViewOptions _alphabetListOptions(BuildContext context) =>
      AlphabetListViewOptions(
      listOptions: ListOptions(
        physics: const AlwaysScrollableScrollPhysics(),
        listHeaderBuilder: (ctx, symbol) => Container(
          height: 50,
          color: Theme.of(ctx).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                symbol,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(ctx).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
      scrollbarOptions: ScrollbarOptions(
        symbols: const [
          '★', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
          'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '#',
        ],
        symbolBuilder: (ctx, symbol, state) {
          final colorScheme = Theme.of(ctx).colorScheme;
          final color = state == AlphabetScrollbarItemState.deactivated
              ? colorScheme.primary.withValues(alpha: 0.4)
              : colorScheme.primary;
          return Text(
            symbol,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          );
        },
      ),
    );

  Widget _buildContactGroup(
    BuildContext context,
    List<Contact> contacts,
    Map<String, SearchHit?> searchHits,
  ) {
    final color = Theme.of(context).colorScheme.surfaceContainerLow;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < contacts.length; i++) ...[
              if (i > 0)
                Divider(
                  height: 2,
                  thickness: 2,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ContactListTile(
                contact: contacts[i],
                onTap: () => _onContactTap(contacts[i]),
                searchHit: contacts[i].id != null ? searchHits[contacts[i].id] : null,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations loc,
    AsyncValue<ContactsListState> contactsValue,
    AsyncValue<List<(BusinessCard, SearchHit?)>> cardsValue,
  ) {
    final searchQuery = ref.watch(contactsSearchQueryProvider).trim();
    final businessCardsWithHits = cardsValue.valueOrNull ?? [];
    final businessCards = businessCardsWithHits.map((e) => e.$1).toList();
    final cardsLoadError = cardsValue.hasError ? cardsValue.error : null;

    // Contacts error: show full-screen error (preserve existing behavior)
    if (contactsValue.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(loc.errorGeneric(contactsValue.error.toString()), textAlign: TextAlign.center),
          ],
        ),
      );
    }

    // Build cards group (independent of contacts loading state)
    final showCardsPlaceholder = businessCards.isEmpty && searchQuery.isEmpty;
    final businessCardsGroup = AlphabetListViewItemGroup(
      tag: '★',
      children: [
        if (showCardsPlaceholder)
          _buildAddCardPlaceholder(context, cardsLoadError?.toString())
        else if (businessCards.isNotEmpty) ...[
          ...businessCardsWithHits.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: BusinessCardTile(
                card: e.$1,
                onTap: () => _onBusinessCardTap(e.$1.id),
                searchHit: e.$2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton.icon(
              onPressed: _onNewBusinessCard,
              icon: const Icon(Icons.add, size: 18),
              label: Text(loc.addBusinessCard),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
              ),
            ),
          ),
        ],
      ],
    );

    // Build contacts groups (empty when loading, data when ready)
    final contactsState = contactsValue.valueOrNull;
    final contactGroups = contactsState != null
        ? contactsState.sections.entries
            .map(
              (e) => AlphabetListViewItemGroup(
                tag: e.key,
                children: [_buildContactGroup(context, e.value, contactsState.searchHits)],
              ),
            )
            .toList()
        : <AlphabetListViewItemGroup>[];

    final allGroups = [
      businessCardsGroup,
      ...contactGroups,
    ];

    // Empty state: both empty and cards error
    if (contactGroups.isEmpty && businessCards.isEmpty && cardsLoadError != null) {
      return _buildEmptyState(
        context,
        contactsState?.permissionDenied ?? false,
        _searchController.text.trim().isEmpty,
        cardsLoadError.toString(),
      );
    }

    return Column(
      children: [
        Expanded(
          child: AlphabetListView(
            items: allGroups,
            options: _alphabetListOptions(context),
          ),
        ),
        if (contactsState?.permissionDenied ?? false) _buildPermissionBanner(context),
        if (contactsValue.isLoading) const LinearProgressIndicator(),
      ],
    );
  }

  Widget _buildPermissionBanner(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.contacts_outlined,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  loc.contactPermissionRequired,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: _openAppSettings,
                child: Text(loc.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final asyncState = ref.watch(contactsListStateProvider);
    final asyncBusinessCards = ref.watch(filteredBusinessCardsProvider);

    return PopScope(
      canPop: !_searchFocusNode.hasFocus,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _searchFocusNode.hasFocus) {
          _onClearSearch();
        }
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _onNewBusinessCard,
            tooltip: loc.newBusinessCardTooltip,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _onSettingsTap,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: ListenableBuilder(
              listenable: _searchController,
              builder: (context, _) {
                return SearchBar(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  hintText: loc.searchHint,
                  leading: const Icon(Icons.search),
                  trailing: _searchController.text.isEmpty
                      ? null
                      : [
                          IconButton(
                            onPressed: _onClearSearch,
                            icon: const Icon(Icons.close),
                            tooltip: loc.clearSearchTooltip,
                          ),
                        ],
                );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator.adaptive(
          onRefresh: _onRefresh,
          child: _buildBody(context, loc, asyncState, asyncBusinessCards),
        ),
      ),
    ),
    );
  }
}
