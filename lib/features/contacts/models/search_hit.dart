// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

/// Represents a search match for display under a contact/card name.
/// If [displayText] equals the displayed name, highlight in title only (no subtitle).
/// Otherwise, show [displayText] as subtitle with [matchStart]..[matchEnd] highlighted.
class SearchHit {
  const SearchHit({
    required this.displayText,
    required this.matchStart,
    required this.matchEnd,
  });

  /// Full value or snippet (for notes).
  final String displayText;

  /// Start index of match in [displayText].
  final int matchStart;

  /// End index of match in [displayText].
  final int matchEnd;
}
