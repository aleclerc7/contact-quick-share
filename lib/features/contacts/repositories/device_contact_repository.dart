// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';

import '../constants/contact_needed_properties.dart';
import '../utils/contact_to_vcard_mapper.dart';
import '../../../core/utils/collation_sort.dart';
import '../../../core/utils/search_utils.dart';
import '../models/contact_field_selection.dart';
import '../models/search_hit.dart';

/// Repository for device contacts via flutter_contacts.
/// Abstracts data access; returns sorted, optionally filtered contacts.
class DeviceContactRepository {
  DeviceContactRepository();

  static bool get _isIos => Platform.isIOS;

  /// Checks if read permission is granted or limited.
  Future<bool> hasPermission() async {
    final status = await FlutterContacts.permissions.check(PermissionType.read);
    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }

  /// Requests read-only contacts permission.
  /// Returns true if granted or limited.
  Future<bool> requestPermission() async {
    final status =
        await FlutterContacts.permissions.request(PermissionType.read);
    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }

  /// Fetches all device contacts with [neededProperties].
  /// Used for both display and search. Returns contacts sorted by displayName ascending.
  Future<List<Contact>> getAll() async {
    final contacts = await FlutterContacts.getAll(
      properties: neededProperties,
    );
    return _sortByDisplayName(contacts);
  }

  /// Fetches a single contact by ID with [neededProperties].
  /// Returns fresh data from the device contact store. Use when QR/share needs up-to-date info.
  Future<Contact?> getById(String id) async {
    return FlutterContacts.get(id, properties: neededProperties);
  }

  /// Filters contacts by search query (case- and accent-insensitive).
  /// Searches name, phones, emails, addresses, orgs, websites, socialMedias, notes.
  /// Returns sorted list; empty query returns all contacts.
  List<Contact> filterByQuery(
    List<Contact> contacts,
    String? query, {
    bool includeNotes = true,
  }) {
    if (query == null || query.trim().isEmpty) {
      return contacts;
    }
    final q = query.trim();
    final includeNotesEffective = includeNotes && !_isIos;
    return contacts
        .where((c) => _contactMatchesQuery(c, q, includeNotesEffective))
        .toList();
  }

  bool _contactMatchesQuery(Contact c, String query, bool includeNotes) {
    return findFirstHitInContact(c, query, includeNotes: includeNotes) != null;
  }

  /// Returns map of contact ID to first search hit for each contact.
  Map<String, SearchHit?> getSearchHitsForContacts(
    List<Contact> contacts,
    String query, {
    bool includeNotes = true,
  }) {
    if (query.trim().isEmpty) return {};
    final includeNotesEffective = includeNotes && !_isIos;
    final result = <String, SearchHit?>{};
    for (final c in contacts) {
      final id = c.id;
      if (id == null) continue;
      final hit = findFirstHitInContact(c, query.trim(), includeNotes: includeNotesEffective);
      result[id] = hit;
    }
    return result;
  }

  /// Sorts contacts by displayName ascending using locale-aware collation.
  /// Contacts with no name use "(No name)" for ordering.
  List<Contact> _sortByDisplayName(List<Contact> contacts) {
    final sorted = List<Contact>.from(contacts);
    CollationSort.sortBy(sorted, (c) => c.displayName ?? '(No name)');
    return sorted;
  }

  /// Exports vCard 3.0 string with only the selected fields.
  /// Uses vcard_dart; never includes photo (keeps QR within capacity).
  String exportVCardWithSelection(
    Contact contact,
    ContactFieldSelection selection,
  ) {
    return buildVCardFromContact(contact, selection);
  }

  /// Partitions contacts into A-Z sections using lexical grouping.
  /// E, É, È group together; non-Latin goes under "#".
  /// [getGroupKey] maps a name to its section letter (A-Z or "#").
  Map<String, List<Contact>> partitionByLetter(
    List<Contact> contacts,
    String Function(String name) getGroupKey,
  ) {
    final map = <String, List<Contact>>{};
    for (final c in contacts) {
      final name = c.displayName ?? '(No name)';
      final letter = getGroupKey(name);
      map.putIfAbsent(letter, () => []).add(c);
    }
    // Sort keys: A-Z first, then #
    final keys = map.keys.toList()
      ..sort((a, b) {
        if (a == '#') return 1;
        if (b == '#') return -1;
        return CollationSort.compareStrings(a, b);
      });
    return Map.fromEntries(
      keys.map((k) => MapEntry(k, map[k]!)),
    );
  }
}
