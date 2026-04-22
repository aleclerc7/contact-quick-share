// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../l10n/app_localizations.dart';
import 'mpl_license_screen.dart';

/// License screen: app copyright, link to source, MPL 2.0, open-source licenses.
class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.license),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomPadding),
          children: [
            Text(
              loc.appTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                final version = snapshot.data?.version ?? '-';
                return Text(
                  loc.versionFormat(version),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              loc.copyrightFormat('2026', 'Alexandre Leclerc'),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              loc.licenseMplNotice,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const MplLicenseScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.article_outlined),
              label: Text(loc.readMplLicense),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.code),
              title: Text(loc.sourceCode),
              subtitle: const Text(AppConstants.sourceCodeUrl),
              onTap: () => _launchUrl(context, AppConstants.sourceCodeUrl),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => showLicensePage(context: context),
              icon: const Icon(Icons.description),
              label: Text(loc.viewOpenSourceLicenses),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    final loc = AppLocalizations.of(context)!;
    final uri = Uri.parse(url);
    try {
      final didLaunch = await launchUrl(uri, mode: LaunchMode.platformDefault);
      if (!didLaunch && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.couldNotOpenLink)),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.couldNotOpenLink)),
        );
      }
    }
  }
}
