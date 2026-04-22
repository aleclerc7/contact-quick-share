// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../core/widgets/highlighted_text.dart';
import '../models/search_hit.dart';

/// Reusable list tile for a device contact.
/// Shows avatar (photo or placeholder icon) and display name.
/// When [searchHit] is set: if hit is in name, highlight in title; else show subtitle.
class ContactListTile extends StatelessWidget {
  const ContactListTile({
    super.key,
    required this.contact,
    required this.onTap,
    this.searchHit,
  });

  final Contact contact;
  final VoidCallback onTap;
  final SearchHit? searchHit;

  @override
  Widget build(BuildContext context) {
    final highlightColor = Theme.of(context).colorScheme.primaryFixedDim;
    final thumbnail = contact.photo?.thumbnail;
    final displayName = contact.displayName ?? '(No name)';

    final isHitInName = searchHit != null && searchHit!.displayText == displayName;

    Widget titleWidget;
    if (isHitInName) {
      titleWidget = HighlightedText(
        text: displayName,
        matchStart: searchHit!.matchStart,
        matchEnd: searchHit!.matchEnd,
        highlightColor: highlightColor,
      );
    } else {
      titleWidget = Text(displayName);
    }

    Widget? subtitleWidget;
    if (searchHit != null && !isHitInName) {
      subtitleWidget = HighlightedText(
        text: searchHit!.displayText,
        matchStart: searchHit!.matchStart,
        matchEnd: searchHit!.matchEnd,
        highlightColor: highlightColor,
      );
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: thumbnail != null && thumbnail.isNotEmpty
            ? MemoryImage(thumbnail)
            : null,
        child: thumbnail == null || thumbnail.isEmpty
            ? const Icon(Icons.person, color: Colors.white70)
            : null,
      ),
      title: titleWidget,
      subtitle: subtitleWidget,
      onTap: onTap,
    );
  }
}
