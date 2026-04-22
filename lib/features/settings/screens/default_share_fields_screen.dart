// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../models/app_settings.dart';
import '../providers/settings_notifier.dart';
import '../../contacts/models/contact_field_selection.dart';

/// Settings screen for default share fields (name, phones, emails, etc.).
class DefaultShareFieldsScreen extends ConsumerWidget {
  const DefaultShareFieldsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final asyncSettings = ref.watch(settingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.defaultShareFields),
      ),
      body: asyncSettings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(loc.errorGeneric(e.toString()))),
        data: (settings) {
          final selection =
              settings.defaultShareFields ?? ContactFieldSelection.defaultSelection();
          return SafeArea(
            top: false,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(loc.defaultShareFieldsIntro),
                ),
                SwitchListTile(
                  title: Text(loc.fieldName),
                  value: selection.name,
                  onChanged: (v) => _update(ref, settings, selection.copyWith(name: v)),
                ),
                SwitchListTile(
                  title: Text(loc.fieldPhones),
                  value: selection.phones,
                  onChanged: (v) => _update(ref, settings, selection.copyWith(phones: v)),
                ),
                SwitchListTile(
                  title: const Text('Emails'),
                  value: selection.emails,
                  onChanged: (v) => _update(ref, settings, selection.copyWith(emails: v)),
                ),
                SwitchListTile(
                  title: Text(loc.fieldOrganization),
                  value: selection.organizations,
                  onChanged: (v) =>
                      _update(ref, settings, selection.copyWith(organizations: v)),
                ),
                SwitchListTile(
                  title: const Text('Addresses'),
                  value: selection.addresses,
                  onChanged: (v) =>
                      _update(ref, settings, selection.copyWith(addresses: v)),
                ),
                SwitchListTile(
                  title: Text(loc.fieldWebsites),
                  value: selection.websites,
                  onChanged: (v) =>
                      _update(ref, settings, selection.copyWith(websites: v)),
                ),
                SwitchListTile(
                  title: const Text('Social media'),
                  value: selection.socialMedias,
                  onChanged: (v) =>
                      _update(ref, settings, selection.copyWith(socialMedias: v)),
                ),
                SwitchListTile(
                  title: Text(loc.fieldNotes),
                  value: selection.notes,
                  onChanged: (v) =>
                      _update(ref, settings, selection.copyWith(notes: v)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _update(WidgetRef ref, AppSettings settings, ContactFieldSelection selection) {
    ref.read(settingsNotifierProvider.notifier).updateSettings(
          settings.copyWith(defaultShareFields: selection),
        );
  }
}
