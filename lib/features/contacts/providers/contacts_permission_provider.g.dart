// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_permission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contactsPermissionHash() =>
    r'791b3c53fddbeca813f2901a49c3c713929ed5da';

/// Single source of truth for contacts permission.
/// Requested at most once per app session; all contact access waits for this.
///
/// Copied from [contactsPermission].
@ProviderFor(contactsPermission)
final contactsPermissionProvider = FutureProvider<bool>.internal(
  contactsPermission,
  name: r'contactsPermissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contactsPermissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContactsPermissionRef = FutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
