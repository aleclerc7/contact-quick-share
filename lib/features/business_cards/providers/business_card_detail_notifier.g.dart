// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_card_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$businessCardDetailNotifierHash() =>
    r'de7e27245ee4ce470baa62bb78298ac84c2b60e4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BusinessCardDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<BusinessCard?> {
  late final String? cardId;

  FutureOr<BusinessCard?> build(String? cardId);
}

/// ViewModel for a single business card (create or edit).
/// When [cardId] is null, creates a new card with default QrAppearance.
///
/// Copied from [BusinessCardDetailNotifier].
@ProviderFor(BusinessCardDetailNotifier)
const businessCardDetailNotifierProvider = BusinessCardDetailNotifierFamily();

/// ViewModel for a single business card (create or edit).
/// When [cardId] is null, creates a new card with default QrAppearance.
///
/// Copied from [BusinessCardDetailNotifier].
class BusinessCardDetailNotifierFamily
    extends Family<AsyncValue<BusinessCard?>> {
  /// ViewModel for a single business card (create or edit).
  /// When [cardId] is null, creates a new card with default QrAppearance.
  ///
  /// Copied from [BusinessCardDetailNotifier].
  const BusinessCardDetailNotifierFamily();

  /// ViewModel for a single business card (create or edit).
  /// When [cardId] is null, creates a new card with default QrAppearance.
  ///
  /// Copied from [BusinessCardDetailNotifier].
  BusinessCardDetailNotifierProvider call(String? cardId) {
    return BusinessCardDetailNotifierProvider(cardId);
  }

  @override
  BusinessCardDetailNotifierProvider getProviderOverride(
    covariant BusinessCardDetailNotifierProvider provider,
  ) {
    return call(provider.cardId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'businessCardDetailNotifierProvider';
}

/// ViewModel for a single business card (create or edit).
/// When [cardId] is null, creates a new card with default QrAppearance.
///
/// Copied from [BusinessCardDetailNotifier].
class BusinessCardDetailNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          BusinessCardDetailNotifier,
          BusinessCard?
        > {
  /// ViewModel for a single business card (create or edit).
  /// When [cardId] is null, creates a new card with default QrAppearance.
  ///
  /// Copied from [BusinessCardDetailNotifier].
  BusinessCardDetailNotifierProvider(String? cardId)
    : this._internal(
        () => BusinessCardDetailNotifier()..cardId = cardId,
        from: businessCardDetailNotifierProvider,
        name: r'businessCardDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$businessCardDetailNotifierHash,
        dependencies: BusinessCardDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            BusinessCardDetailNotifierFamily._allTransitiveDependencies,
        cardId: cardId,
      );

  BusinessCardDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cardId,
  }) : super.internal();

  final String? cardId;

  @override
  FutureOr<BusinessCard?> runNotifierBuild(
    covariant BusinessCardDetailNotifier notifier,
  ) {
    return notifier.build(cardId);
  }

  @override
  Override overrideWith(BusinessCardDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: BusinessCardDetailNotifierProvider._internal(
        () => create()..cardId = cardId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cardId: cardId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    BusinessCardDetailNotifier,
    BusinessCard?
  >
  createElement() {
    return _BusinessCardDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BusinessCardDetailNotifierProvider &&
        other.cardId == cardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BusinessCardDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<BusinessCard?> {
  /// The parameter `cardId` of this provider.
  String? get cardId;
}

class _BusinessCardDetailNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          BusinessCardDetailNotifier,
          BusinessCard?
        >
    with BusinessCardDetailNotifierRef {
  _BusinessCardDetailNotifierProviderElement(super.provider);

  @override
  String? get cardId => (origin as BusinessCardDetailNotifierProvider).cardId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
