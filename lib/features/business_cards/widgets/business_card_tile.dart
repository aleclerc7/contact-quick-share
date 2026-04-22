// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/highlighted_text.dart';
import '../../contacts/models/search_hit.dart';
import '../../settings/providers/settings_notifier.dart';
import '../../settings/services/default_appearance_resolver.dart';
import '../models/business_card.dart';

/// Wallet-style tile that looks like a business card.
/// Shows card color, optional logo, card name, name, org, title, phone, email.
/// When [searchHit] is set: if hit in card/display name, highlight there; else show subtitle.
/// When [selected] is true, shows a checkmark indicator (e.g. for pickers).
class BusinessCardTile extends ConsumerWidget {
  const BusinessCardTile({
    super.key,
    required this.card,
    required this.onTap,
    this.searchHit,
    this.selected = false,
  });

  final BusinessCard card;
  final VoidCallback onTap;
  final SearchHit? searchHit;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider).valueOrNull;
    final resolver = DefaultAppearanceResolver(
      settings: settings,
      colorScheme: Theme.of(context).colorScheme,
    );
    final bgColor = resolver.resolveBackgroundColor(card.backgroundColor);
    final textColor = resolver.resolveTextColor(card.textColor);
    // Reverse-video highlight: text = bg, background = fg

    final isHitInCardName = searchHit != null && searchHit!.displayText == card.cardName;
    final isHitInDisplayName = searchHit != null && searchHit!.displayText == card.displayFullName;
    final showSubtitle = searchHit != null && !isHitInCardName && !isHitInDisplayName;

    return Material(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: selected
            ? BorderSide(
                color: textColor.withValues(alpha: 0.6),
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildAvatar(textColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (card.cardName.isNotEmpty)
                      isHitInCardName
                          ? HighlightedText(
                              text: card.cardName,
                              matchStart: searchHit!.matchStart,
                              matchEnd: searchHit!.matchEnd,
                              baseStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: textColor,
                              ),
                              highlightColor: bgColor,
                              highlightBackgroundColor: textColor,
                            )
                          : Text(
                              card.cardName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    if (card.displayFullName.isNotEmpty) ...[
                      if (card.cardName.isNotEmpty) const SizedBox(height: 4),
                      isHitInDisplayName
                          ? HighlightedText(
                              text: card.displayFullName,
                              matchStart: searchHit!.matchStart,
                              matchEnd: searchHit!.matchEnd,
                              baseStyle: TextStyle(
                                fontSize: 14,
                                color: textColor.withValues(alpha: 0.95),
                              ),
                              highlightColor: bgColor,
                              highlightBackgroundColor: textColor,
                            )
                          : Text(
                              card.displayFullName,
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor.withValues(alpha: 0.95),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ],
                    if (card.displayOrg.isNotEmpty ||
                        card.displayTitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        [
                          if (card.displayOrg.isNotEmpty) card.displayOrg,
                          if (card.displayTitle.isNotEmpty) card.displayTitle,
                        ].join(' • '),
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor.withValues(alpha: 0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (card.primaryPhone.isNotEmpty ||
                        card.primaryEmail.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        card.primaryPhone.isNotEmpty
                            ? card.primaryPhone
                            : card.primaryEmail,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor.withValues(alpha: 0.75),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (showSubtitle) ...[
                      const SizedBox(height: 2),
                      HighlightedText(
                        text: searchHit!.displayText,
                        matchStart: searchHit!.matchStart,
                        matchEnd: searchHit!.matchEnd,
                        baseStyle: TextStyle(
                          fontSize: 12,
                          color: textColor.withValues(alpha: 0.75),
                        ),
                        highlightColor: bgColor,
                        highlightBackgroundColor: textColor,
                      ),
                    ],
                  ],
                ),
              ),
              if (selected) ...[
                const SizedBox(width: 12),
                Icon(
                  Icons.check_circle,
                  color: textColor.withValues(alpha: 0.9),
                  size: 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(Color textColor) {
    if (card.cardPhoto != null && card.cardPhoto!.isNotEmpty) {
      return CircleAvatar(
        radius: 28,
        backgroundColor: textColor.withValues(alpha: 0.2),
        backgroundImage: MemoryImage(card.cardPhoto!),
      );
    }
    return CircleAvatar(
      radius: 28,
      backgroundColor: textColor.withValues(alpha: 0.2),
      child: Icon(
        Icons.badge_outlined,
        size: 32,
        color: textColor.withValues(alpha: 0.7),
      ),
    );
  }
}
