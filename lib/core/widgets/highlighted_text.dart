// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

/// Renders text with a substring in bold + optional highlight styling.
/// When [highlightBackgroundColor] is set, uses reverse-video style (text = fg, bg = fg).
class HighlightedText extends StatelessWidget {
  const HighlightedText({
    super.key,
    required this.text,
    required this.matchStart,
    required this.matchEnd,
    this.baseStyle,
    this.highlightColor,
    this.highlightBackgroundColor,
  });

  final String text;
  final int matchStart;
  final int matchEnd;
  final TextStyle? baseStyle;
  final Color? highlightColor;
  /// When set, paints background behind the match (reverse-video style when used with swapped fg/bg).
  final Color? highlightBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final highlight = highlightColor ?? colorScheme.primary;
    final base = baseStyle ?? DefaultTextStyle.of(context).style;

    if (matchStart >= matchEnd || matchStart < 0 || matchEnd > text.length) {
      return Text(text, style: base);
    }

    final before = text.substring(0, matchStart);
    final match = text.substring(matchStart, matchEnd);
    final after = text.substring(matchEnd);

    return Text.rich(
      TextSpan(
        style: base,
        children: [
          TextSpan(text: before),
          TextSpan(
            text: match,
            style: base.copyWith(
              fontWeight: FontWeight.bold,
              color: highlight,
              backgroundColor: highlightBackgroundColor,
            ),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }
}
