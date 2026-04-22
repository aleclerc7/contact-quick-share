// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:characters/characters.dart';
import 'package:diacritic/diacritic.dart';

/// Lexical sorting and A–Z grouping for Latin scripts.
///
/// Uses diacritic stripping plus case-insensitive Unicode string order — not
/// full locale collation (no language-specific rules like Turkish i/İ).
class CollationSort {
  CollationSort._();

  static final _letters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
    'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
  ];

  static String _sortKey(String s) => removeDiacritics(s).toLowerCase();

  /// Compares two strings using diacritic-insensitive lexical order.
  static int compareStrings(String a, String b) =>
      _sortKey(a).compareTo(_sortKey(b));

  /// Sorts [list] by the string key returned by [getKey].
  static void sortBy<T>(List<T> list, String Function(T) getKey) {
    list.sort((a, b) => compareStrings(getKey(a), getKey(b)));
  }

  /// Returns the A-Z group key for partitioning. E, É, È map to "E".
  /// Non-Latin first letters and empty names map to "#".
  static String getGroupKey(String name) {
    if (name.isEmpty) return '#';
    final first = name.characters.first;
    if (compareStrings(first, 'A') < 0) return '#';
    if (compareStrings(first, 'Z') > 0) return '#';
    for (var i = 0; i < _letters.length; i++) {
      if (compareStrings(first, _letters[i]) < 0) {
        return i == 0 ? '#' : _letters[i - 1];
      }
    }
    return 'Z';
  }
}
