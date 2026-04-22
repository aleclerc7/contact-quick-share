// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../qr_code/qr_code.dart';
import '../../qr_code/utils/qr_share_actions.dart';
import '../../qr_code/widgets/qr_close_button.dart';
import '../../settings/providers/settings_notifier.dart';
import '../../settings/services/default_appearance_resolver.dart';
import '../models/contact_field_selection.dart';
import '../providers/device_contact_repository_provider.dart';
import '../utils/contact_field_presence.dart';
import '../utils/contact_share_deduplicator.dart';
import '../widgets/contact_field_selection_widget.dart';

/// Unified contact share screen: field selection and QR view are two sides of the same screen.
/// - Field selection (from contact list): back arrow, contact name, toggles, Quick Share button.
/// - QR view: tap opens action menu; swipe right-to-left enters field selection (edit).
/// - Edit-from-QR: back arrow returns to QR (no Quick Share button). X on QR closes to main.
class ContactFieldSelectionScreen extends ConsumerStatefulWidget {
  const ContactFieldSelectionScreen({
    super.key,
    required this.contact,
  });

  /// Contact from list (has neededProperties). No fetch on load.
  final Contact contact;

  @override
  ConsumerState<ContactFieldSelectionScreen> createState() =>
      _ContactFieldSelectionScreenState();
}

class _ContactFieldSelectionScreenState
    extends ConsumerState<ContactFieldSelectionScreen> {
  ContactFieldSelection? _selection;
  bool _isQrView = false;
  bool _cameFromQrEdit = false;
  Contact? _contact;
  bool _isRefreshing = false;

  Contact get _sourceContact => _contact ?? widget.contact;
  Contact get _effectiveShareContact => toShareDedupedContact(_sourceContact);

  QrDisplayPayload _buildPayload(Contact contact, ContactFieldSelection sel) {
    final repo = ref.read(deviceContactRepositoryProvider);
    final settings = ref.read(settingsNotifierProvider).valueOrNull;
    final vCard = repo.exportVCardWithSelection(contact, sel);
    final qrAppearance =
        settings?.defaultQrAppearance ?? QrAppearance.defaultAppearance();
    final displayContact = sel.applyToContact(contact);

    return QrDisplayPayload(
      vCardContent: vCard,
      qrAppearance: qrAppearance,
      displayContact: displayContact,
      photoOverride: contact.photo?.thumbnail,
      backgroundColor: null,
      textColor: null,
    );
  }

  DefaultAppearanceResolver _createResolver() {
    final settings = ref.watch(settingsNotifierProvider).valueOrNull;
    return DefaultAppearanceResolver(
      settings: settings,
      colorScheme: Theme.of(context).colorScheme,
    );
  }

  void _closeToMain() {
    Navigator.of(context).pop();
  }

  void _flipToQr() {
    setState(() {
      _isQrView = true;
      _cameFromQrEdit = false;
    });
  }

  void _flipToFieldSelection({bool fromQrEdit = false}) {
    setState(() {
      _isQrView = false;
      _cameFromQrEdit = fromQrEdit;
    });
  }

  Future<void> _onQuickShare() async {
    if (!(_selection?.hasAnySelectedField ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectAtLeastOneField),
        ),
      );
      return;
    }
    final contact = _sourceContact;
    if (contact.id == null) {
      _flipToQr();
      return;
    }
    setState(() => _isRefreshing = true);
    try {
      final repo = ref.read(deviceContactRepositoryProvider);
      final fresh = await repo.getById(contact.id!);
      if (!mounted) return;
      if (fresh == null) {
        setState(() => _isRefreshing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.contactNotFoundOrDeleted),
          ),
        );
        return;
      }
      final defaults = ref.read(settingsNotifierProvider).valueOrNull
              ?.defaultShareFields ??
          ContactFieldSelection.defaultSelection();
      setState(() {
        _contact = fresh;
        _selection = ContactFieldSelection.reconcileAfterRefresh(
          toShareDedupedContact(fresh),
          _selection!,
          defaults,
        );
        _isRefreshing = false;
        _isQrView = true;
        _cameFromQrEdit = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isRefreshing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorGeneric(e.toString())),
        ),
      );
    }
  }

  void _onBackFromQrEdit() {
    if (!(_selection?.hasAnySelectedField ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectAtLeastOneField),
        ),
      );
      return;
    }
    _flipToQr();
  }

  Future<void> _shareAsImage(Contact contact) async {
    final sel = _selection!;
    await QrShareActions.shareAsImageWithFeedback(
      context,
      ref,
      _buildPayload(contact, sel),
      _createResolver(),
    );
  }

  Future<void> _shareAsVCard(Contact contact) async {
    final sel = _selection!;
    await QrShareActions.shareAsVCardWithFeedback(
      context,
      ref,
      _buildPayload(contact, sel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final contact = _effectiveShareContact;
    _selection ??= ContactFieldSelection.mergeWithDefaults(
      contact,
      ref.read(settingsNotifierProvider).valueOrNull?.defaultShareFields ??
          ContactFieldSelection.defaultSelection(),
    );
    final selection = _selection!;
    final hasAnyField = ContactFieldPresence.hasAnyData(contact);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_isQrView) {
          _flipToFieldSelection();
        } else if (_cameFromQrEdit) {
          _onBackFromQrEdit();
        } else {
          _closeToMain();
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isQrView
            ? _QrView(
                key: const ValueKey('qr'),
                payload: _buildPayload(contact, selection),
                resolver: _createResolver(),
                onClose: _closeToMain,
                onEnterEdit: () => _flipToFieldSelection(fromQrEdit: true),
                onShareAsImage: () => _shareAsImage(contact),
                onShareAsVCard: () => _shareAsVCard(contact),
                editLabel: loc.editContactCard,
              )
            : _FieldSelectionView(
                key: const ValueKey('fields'),
                contact: contact,
                selection: selection,
                onSelectionChanged: (s) => setState(() => _selection = s),
                onBack: _cameFromQrEdit ? _onBackFromQrEdit : _closeToMain,
                onQuickShare: _cameFromQrEdit ? null : (hasAnyField ? _onQuickShare : null),
                isRefreshing: _isRefreshing,
                loc: AppLocalizations.of(context)!,
              ),
      ),
    );
  }
}

/// Field selection side: AppBar with back, contact name, toggles, Quick Share.
class _FieldSelectionView extends StatelessWidget {
  const _FieldSelectionView({
    super.key,
    required this.contact,
    required this.selection,
    required this.onSelectionChanged,
    required this.onBack,
    required this.onQuickShare,
    required this.isRefreshing,
    required this.loc,
  });

  final Contact contact;
  final ContactFieldSelection selection;
  final void Function(ContactFieldSelection) onSelectionChanged;
  final VoidCallback onBack;
  final VoidCallback? onQuickShare;
  final bool isRefreshing;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
          tooltip: loc.backTooltip,
        ),
        title: Text(loc.shareContact),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              contact.displayName ?? loc.noName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ContactFieldSelectionWidget(
              contact: contact,
              initialSelection: selection,
              onSelectionChanged: onSelectionChanged,
              primaryButtonLabel: loc.done,
              onPrimary: null,
            ),
          ),
          if (onQuickShare != null)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: isRefreshing ? null : onQuickShare,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: isRefreshing
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : Text(loc.quickShare),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// QR view side: full-screen QR with X to close. Tap opens action menu; swipe enters field selection.
class _QrView extends StatelessWidget {
  const _QrView({
    super.key,
    required this.payload,
    required this.resolver,
    required this.onClose,
    required this.onEnterEdit,
    required this.onShareAsImage,
    required this.onShareAsVCard,
    required this.editLabel,
  });

  final QrDisplayPayload payload;
  final DefaultAppearanceResolver resolver;
  final VoidCallback onClose;
  final VoidCallback onEnterEdit;
  final VoidCallback onShareAsImage;
  final VoidCallback onShareAsVCard;
  final String editLabel;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        resolver.resolveBackgroundColor(payload.backgroundColor);
    final textColor = resolver.resolveTextColor(payload.textColor);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          QrGestureWrapper(
            payload: payload,
            resolver: resolver,
            onEnterEdit: onEnterEdit,
            onClose: onClose,
            onShareAsImage: onShareAsImage,
            onShareAsVCard: onShareAsVCard,
            editLabel: editLabel,
          ),
          QrCloseButton(
            backgroundColor: backgroundColor,
            iconColor: textColor,
            onTap: onClose,
          ),
        ],
      ),
    );
  }
}
