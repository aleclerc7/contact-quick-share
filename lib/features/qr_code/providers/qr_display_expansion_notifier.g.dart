// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_display_expansion_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$qrDisplayExpansionHash() =>
    r'f12d875766c280c353c1dd52f7710266bc6ac392';

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

abstract class _$QrDisplayExpansion extends BuildlessAutoDisposeNotifier<bool> {
  late final String scopeId;

  bool build(String scopeId);
}

/// Expanded/collapsed state for the QR details "more" section.
///
/// [scopeId] must be unique per concurrent [QrDisplayView] (e.g. business card id,
/// contact share scope) so instances do not share expansion state.
///
/// Copied from [QrDisplayExpansion].
@ProviderFor(QrDisplayExpansion)
const qrDisplayExpansionProvider = QrDisplayExpansionFamily();

/// Expanded/collapsed state for the QR details "more" section.
///
/// [scopeId] must be unique per concurrent [QrDisplayView] (e.g. business card id,
/// contact share scope) so instances do not share expansion state.
///
/// Copied from [QrDisplayExpansion].
class QrDisplayExpansionFamily extends Family<bool> {
  /// Expanded/collapsed state for the QR details "more" section.
  ///
  /// [scopeId] must be unique per concurrent [QrDisplayView] (e.g. business card id,
  /// contact share scope) so instances do not share expansion state.
  ///
  /// Copied from [QrDisplayExpansion].
  const QrDisplayExpansionFamily();

  /// Expanded/collapsed state for the QR details "more" section.
  ///
  /// [scopeId] must be unique per concurrent [QrDisplayView] (e.g. business card id,
  /// contact share scope) so instances do not share expansion state.
  ///
  /// Copied from [QrDisplayExpansion].
  QrDisplayExpansionProvider call(String scopeId) {
    return QrDisplayExpansionProvider(scopeId);
  }

  @override
  QrDisplayExpansionProvider getProviderOverride(
    covariant QrDisplayExpansionProvider provider,
  ) {
    return call(provider.scopeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'qrDisplayExpansionProvider';
}

/// Expanded/collapsed state for the QR details "more" section.
///
/// [scopeId] must be unique per concurrent [QrDisplayView] (e.g. business card id,
/// contact share scope) so instances do not share expansion state.
///
/// Copied from [QrDisplayExpansion].
class QrDisplayExpansionProvider
    extends AutoDisposeNotifierProviderImpl<QrDisplayExpansion, bool> {
  /// Expanded/collapsed state for the QR details "more" section.
  ///
  /// [scopeId] must be unique per concurrent [QrDisplayView] (e.g. business card id,
  /// contact share scope) so instances do not share expansion state.
  ///
  /// Copied from [QrDisplayExpansion].
  QrDisplayExpansionProvider(String scopeId)
    : this._internal(
        () => QrDisplayExpansion()..scopeId = scopeId,
        from: qrDisplayExpansionProvider,
        name: r'qrDisplayExpansionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$qrDisplayExpansionHash,
        dependencies: QrDisplayExpansionFamily._dependencies,
        allTransitiveDependencies:
            QrDisplayExpansionFamily._allTransitiveDependencies,
        scopeId: scopeId,
      );

  QrDisplayExpansionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.scopeId,
  }) : super.internal();

  final String scopeId;

  @override
  bool runNotifierBuild(covariant QrDisplayExpansion notifier) {
    return notifier.build(scopeId);
  }

  @override
  Override overrideWith(QrDisplayExpansion Function() create) {
    return ProviderOverride(
      origin: this,
      override: QrDisplayExpansionProvider._internal(
        () => create()..scopeId = scopeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        scopeId: scopeId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<QrDisplayExpansion, bool> createElement() {
    return _QrDisplayExpansionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QrDisplayExpansionProvider && other.scopeId == scopeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scopeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QrDisplayExpansionRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `scopeId` of this provider.
  String get scopeId;
}

class _QrDisplayExpansionProviderElement
    extends AutoDisposeNotifierProviderElement<QrDisplayExpansion, bool>
    with QrDisplayExpansionRef {
  _QrDisplayExpansionProviderElement(super.provider);

  @override
  String get scopeId => (origin as QrDisplayExpansionProvider).scopeId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
