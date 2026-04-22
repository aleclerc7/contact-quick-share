// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Reusable close button for QR full-screen views.
/// Positioned top-left; use inside a [Stack].
class QrCloseButton extends StatelessWidget {
  const QrCloseButton({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      left: 8,
      child: Tooltip(
        message: loc.close,
        child: Material(
          color: backgroundColor,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.close, color: iconColor, size: 24),
            ),
          ),
        ),
      ),
    );
  }
}
