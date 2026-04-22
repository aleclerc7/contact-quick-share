// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_business_cards_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredBusinessCardsHash() =>
    r'f717b36875571f8ee20baf24c926cf77e270c9a4';

/// Filters business cards by search query (case- and accent-insensitive).
/// Matches all fields including contact.addresses, contact.notes, contact.websites, contact.socialMedias.
/// Returns (card, searchHit) pairs for display.
///
/// Copied from [filteredBusinessCards].
@ProviderFor(filteredBusinessCards)
final filteredBusinessCardsProvider =
    Provider<AsyncValue<List<(BusinessCard, SearchHit?)>>>.internal(
      filteredBusinessCards,
      name: r'filteredBusinessCardsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredBusinessCardsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredBusinessCardsRef =
    ProviderRef<AsyncValue<List<(BusinessCard, SearchHit?)>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
