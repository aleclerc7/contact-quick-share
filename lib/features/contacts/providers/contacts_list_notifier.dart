// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/collation_sort.dart';
import '../models/search_hit.dart';
import 'contacts_permission_provider.dart';
import 'device_contact_repository_provider.dart';

part 'contacts_list_notifier.g.dart';

/// Single source of truth for all contacts in the app (list + search).
/// Fetched once; invalidated only on pull-to-refresh.
@Riverpod(keepAlive: true)
Future<List<Contact>> rawContacts(Ref ref) async {
  final hasPermission = await ref.watch(contactsPermissionProvider.future);
  if (!hasPermission) return [];
  final repo = ref.read(deviceContactRepositoryProvider);
  return repo.getAll();
}

/// State for the contacts list: sections (letter -> contacts) for display.
class ContactsListState {
  const ContactsListState({
    required this.sections,
    this.permissionDenied = false,
    this.searchHits = const {},
  });

  final Map<String, List<Contact>> sections;
  final bool permissionDenied;
  final Map<String, SearchHit?> searchHits;

  bool get isEmpty => sections.isEmpty && !permissionDenied;
}

/// Sync provider: combines raw contacts + search query into filtered list state.
/// No loading flash when search changes—filtering is synchronous.
@Riverpod(keepAlive: true)
AsyncValue<ContactsListState> contactsListState(Ref ref) {
  final permission = ref.watch(contactsPermissionProvider);
  final rawContacts = ref.watch(rawContactsProvider);
  final searchQuery = ref.watch(contactsSearchQueryProvider).trim();
  final repo = ref.read(deviceContactRepositoryProvider);

  if (permission.valueOrNull == false) {
    return const AsyncData(
      ContactsListState(sections: {}, permissionDenied: true),
    );
  }

  return rawContacts.when(
    loading: () => const AsyncLoading<ContactsListState>(),
    error: (err, stack) => AsyncError<ContactsListState>(err, stack),
    data: (contacts) {
      if (searchQuery.isEmpty) {
        final sections =
            repo.partitionByLetter(contacts, CollationSort.getGroupKey);
        return AsyncData(
          ContactsListState(sections: sections, permissionDenied: false),
        );
      }
      final filtered =
          repo.filterByQuery(contacts, searchQuery, includeNotes: true);
      final searchHits = repo.getSearchHitsForContacts(
        filtered,
        searchQuery,
        includeNotes: true,
      );
      final sections =
          repo.partitionByLetter(filtered, CollationSort.getGroupKey);
      return AsyncData(
        ContactsListState(
          sections: sections,
          permissionDenied: false,
          searchHits: searchHits,
        ),
      );
    },
  );
}

/// Search query for filtering contacts. Watched by contactsListStateProvider.
@Riverpod(keepAlive: true)
class ContactsSearchQuery extends _$ContactsSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}
