// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Optional fourth row for [QrActionMenu] (e.g. edit card, open URL).
class QrActionMenuTrailingItem {
  const QrActionMenuTrailingItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
}

/// Action menu for QR display: share, view text, optional vCard, optional trailing.
/// Shown from the full-screen QR view (e.g. after tap).
class QrActionMenu extends StatelessWidget {
  const QrActionMenu({
    super.key,
    required this.onShareAsImage,
    this.onShareAsVCard,
    required this.onViewQrDataAsText,
    this.trailing,
  });

  final VoidCallback onShareAsImage;
  final VoidCallback? onShareAsVCard;
  final VoidCallback onViewQrDataAsText;
  final QrActionMenuTrailingItem? trailing;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onShareAsImage,
    VoidCallback? onShareAsVCard,
    required VoidCallback onViewQrDataAsText,
    QrActionMenuTrailingItem? trailing,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        void wrap(VoidCallback fn) {
          Navigator.of(sheetContext).pop();
          fn();
        }

        final wrappedTrailing = trailing == null
            ? null
            : QrActionMenuTrailingItem(
                label: trailing.label,
                icon: trailing.icon,
                onTap: () => wrap(trailing.onTap),
              );

        return QrActionMenu(
          onShareAsImage: () => wrap(onShareAsImage),
          onShareAsVCard:
              onShareAsVCard == null ? null : () => wrap(onShareAsVCard),
          onViewQrDataAsText: () => wrap(onViewQrDataAsText),
          trailing: wrappedTrailing,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final vCard = onShareAsVCard;
    final tail = trailing;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MenuItem(
              icon: Icons.image,
              label: loc.shareAsImage,
              onTap: onShareAsImage,
            ),
            if (vCard != null)
              _MenuItem(
                icon: Icons.contact_phone,
                label: loc.shareAsVCard,
                onTap: vCard,
              ),
            _MenuItem(
              icon: Icons.text_snippet,
              label: loc.viewQrDataAsText,
              onTap: onViewQrDataAsText,
            ),
            if (tail != null)
              _MenuItem(
                icon: tail.icon,
                label: tail.label,
                onTap: tail.onTap,
              ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label),
      onTap: onTap,
      enabled: onTap != null,
    );
  }
}
