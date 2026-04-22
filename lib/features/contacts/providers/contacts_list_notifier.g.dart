// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rawContactsHash() => r'514ed0fa1316756da4975b8cbf2a04ad32bf6c40';

/// Single source of truth for all contacts in the app (list + search).
/// Fetched once; invalidated only on pull-to-refresh.
///
/// Copied from [rawContacts].
@ProviderFor(rawContacts)
final rawContactsProvider = FutureProvider<List<Contact>>.internal(
  rawContacts,
  name: r'rawContactsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$rawContactsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RawContactsRef = FutureProviderRef<List<Contact>>;
String _$contactsListStateHash() => r'6537474223e7b105404d3d9902e361aedfd883a1';

/// Sync provider: combines raw contacts + search query into filtered list state.
/// No loading flash when search changes—filtering is synchronous.
///
/// Copied from [contactsListState].
@ProviderFor(contactsListState)
final contactsListStateProvider =
    Provider<AsyncValue<ContactsListState>>.internal(
      contactsListState,
      name: r'contactsListStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contactsListStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContactsListStateRef = ProviderRef<AsyncValue<ContactsListState>>;
String _$contactsSearchQueryHash() =>
    r'fa578d68a21fad11a124f70cca0f87b3264ecb9c';

/// Search query for filtering contacts. Watched by contactsListStateProvider.
///
/// Copied from [ContactsSearchQuery].
@ProviderFor(ContactsSearchQuery)
final contactsSearchQueryProvider =
    NotifierProvider<ContactsSearchQuery, String>.internal(
      ContactsSearchQuery.new,
      name: r'contactsSearchQueryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contactsSearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ContactsSearchQuery = Notifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
