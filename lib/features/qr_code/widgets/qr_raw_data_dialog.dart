// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/app_localizations.dart';

/// Dialog that displays raw QR code data with copy support.
/// Works for any string content (vCard, URL, WiFi, etc.).
class QrRawDataDialog extends StatelessWidget {
  const QrRawDataDialog({
    super.key,
    required this.content,
  });

  final String content;

  static Future<void> show(BuildContext context, String content) {
    return showDialog<void>(
      context: context,
      builder: (context) => QrRawDataDialog(content: content),
    );
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: content));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.copiedToClipboard)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(loc.qrCodeData),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: SelectableText(
            content,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(loc.close),
        ),
        FilledButton.icon(
          onPressed: () => _copyToClipboard(context),
          icon: const Icon(Icons.copy, size: 18),
          label: Text(loc.copy),
        ),
      ],
    );
  }
}
