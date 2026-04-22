// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../../l10n/app_localizations.dart';

/// Full-screen display of the MPL 2.0 license text (offline, formatted as Markdown).
class MplLicenseScreen extends StatelessWidget {
  const MplLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.readMplLicense),
      ),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('LICENSE.md'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  loc.errorGeneric(snapshot.error.toString()),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final text = snapshot.data ?? '';
          final padding = MediaQuery.paddingOf(context);
          final theme = Theme.of(context);
          final scheme = theme.colorScheme;
          return Markdown(
            data: text,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + padding.bottom),
            selectable: true,
            styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
              blockquoteDecoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(2),
                border: Border(
                  left: BorderSide(color: scheme.primary, width: 3),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
