// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../providers/contacts_list_notifier.dart';
import '../providers/device_contact_repository_provider.dart';
import '../providers/contacts_permission_provider.dart';

/// Full-screen list to pick a device [Contact] for a new business card.
/// Pops with the selected [Contact] or `null` if the user cancels.
class ContactPickerForNewCardScreen extends ConsumerStatefulWidget {
  const ContactPickerForNewCardScreen({super.key});

  @override
  ConsumerState<ContactPickerForNewCardScreen> createState() =>
      _ContactPickerForNewCardScreenState();
}

class _ContactPickerForNewCardScreenState
    extends ConsumerState<ContactPickerForNewCardScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openAppSettings() async {
    await FlutterContacts.permissions.openSettings();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final searchQuery = _searchController.text.trim();
    final permission = ref.watch(contactsPermissionProvider);
    final asyncContacts = ref.watch(rawContactsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.contactPickerForNewCardTitle)),
      body: permission.when(
        data: (has) {
          if (!has) {
            return _PermissionNeededBody(
              loc: loc,
              onOpenSettings: _openAppSettings,
            );
          }
          return asyncContacts.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  loc.errorGeneric(e.toString()),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (contacts) {
              final repo = ref.read(deviceContactRepositoryProvider);
              final filtered = repo.filterByQuery(
                contacts,
                searchQuery.isEmpty ? null : searchQuery,
              );
              if (filtered.isEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: SearchBar(
                        controller: _searchController,
                        hintText: loc.searchHint,
                        leading: const Icon(Icons.search),
                        trailing: _searchController.text.isEmpty
                            ? null
                            : [
                                IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                  },
                                  icon: const Icon(Icons.close),
                                  tooltip: loc.clearSearchTooltip,
                                ),
                              ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          searchQuery.isEmpty
                              ? loc.noContactsOnDevice
                              : loc.noMatchingContacts,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: SearchBar(
                      controller: _searchController,
                      hintText: loc.searchHint,
                      leading: const Icon(Icons.search),
                      trailing: _searchController.text.isEmpty
                          ? null
                          : [
                              IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                },
                                icon: const Icon(Icons.close),
                                tooltip: loc.clearSearchTooltip,
                              ),
                            ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final c = filtered[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                c.photo != null &&
                                    (c.photo?.thumbnail != null) &&
                                    c.photo!.thumbnail!.isNotEmpty
                                ? MemoryImage(c.photo!.thumbnail!)
                                : null,
                            child: c.photo == null || c.photo!.thumbnail == null
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                  )
                                : null,
                          ),
                          title: Text(c.displayName ?? '(No name)'),
                          onTap: () => Navigator.of(context).pop(c),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              loc.errorGeneric(e.toString()),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _PermissionNeededBody extends StatelessWidget {
  const _PermissionNeededBody({
    required this.loc,
    required this.onOpenSettings,
  });

  final AppLocalizations loc;
  final Future<void> Function() onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.contacts_outlined, size: 48),
            const SizedBox(height: 16),
            Text(
              loc.importFromContactsNeedPermissionBody,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => onOpenSettings(),
              icon: const Icon(Icons.settings),
              label: Text(loc.openSettings),
            ),
          ],
        ),
      ),
    );
  }
}
