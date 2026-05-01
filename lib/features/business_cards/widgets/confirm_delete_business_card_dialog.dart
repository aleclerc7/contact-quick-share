// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Returns `true` if the user confirmed delete, `false` if cancelled, `null` if dismissed.
Future<bool?> showConfirmDeleteBusinessCardDialog(
  BuildContext context,
  AppLocalizations loc,
  String name,
) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(loc.deleteCardTitle),
      content: Text(loc.deleteCardMessage(name)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(loc.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          child: Text(loc.delete),
        ),
      ],
    ),
  );
}
