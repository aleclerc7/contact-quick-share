// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../qr_code/models/qr_display_payload.dart';
import '../../qr_code/utils/qr_share_actions.dart';
import '../../qr_code/widgets/qr_close_button.dart';
import '../../qr_code/widgets/qr_gesture_wrapper.dart';
import '../../settings/providers/settings_notifier.dart';
import '../../settings/services/default_appearance_resolver.dart';
import '../models/business_card.dart';
import '../providers/business_card_detail_notifier.dart';
import '../providers/business_cards_list_notifier.dart';
import '../widgets/business_card_appearance_tab.dart';
import '../widgets/business_card_data_tab.dart'
    show BusinessCardDataTab, BusinessCardDataTabState;

/// Full-screen business card: QR view (default) or edit mode with Data/Appearance tabs.
/// From QR, tap opens the action menu; swipe right-to-left enters edit.
class BusinessCardDetailScreen extends ConsumerStatefulWidget {
  const BusinessCardDetailScreen({
    super.key,
    this.cardId,
  });

  /// Null = new card. Non-null = edit existing.
  final String? cardId;

  @override
  ConsumerState<BusinessCardDetailScreen> createState() =>
      _BusinessCardDetailScreenState();
}

class _BusinessCardDetailScreenState
    extends ConsumerState<BusinessCardDetailScreen>
    with TickerProviderStateMixin {
  late bool _isEditMode;
  BusinessCard? _initialCardWhenEditMode;
  final _dataTabKey = GlobalKey<BusinessCardDataTabState>();
  TabController? _editTabController;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.cardId == null;
    if (_isEditMode) {
      _editTabController = TabController(length: 2, vsync: this);
      _editTabController!.addListener(_onEditTabChanged);
    }
  }

  @override
  void dispose() {
    _editTabController?.removeListener(_onEditTabChanged);
    _editTabController?.dispose();
    _editTabController = null;
    super.dispose();
  }

  void _onEditTabChanged() {
    if (_editTabController?.index == 1) {
      final draft = _dataTabKey.currentState?.getDraftCard();
      if (draft != null) {
        ref.read(businessCardDetailNotifierProvider(widget.cardId).notifier).updateCard(draft);
      }
    }
  }

  void _toggleMode() {
    setState(() {
      _isEditMode = !_isEditMode;
      if (!_isEditMode) {
        _initialCardWhenEditMode = null;
        _editTabController?.removeListener(_onEditTabChanged);
        _editTabController?.dispose();
        _editTabController = null;
      }
    });
  }

  void _enterEditMode(BusinessCard card) {
    setState(() {
      _initialCardWhenEditMode = card;
      _isEditMode = true;
      _editTabController = TabController(length: 2, vsync: this);
      _editTabController!.addListener(_onEditTabChanged);
    });
  }

  Future<void> _deleteCard(BusinessCard card) async {
    final loc = AppLocalizations.of(context)!;
    final name = card.displayFullName.isNotEmpty ? card.displayFullName : card.cardName;
    final confirmed = await showDialog<bool>(
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
    if (!mounted || confirmed != true) return;
    await ref.read(businessCardDetailNotifierProvider(widget.cardId).notifier).delete(card.id);
    ref.invalidate(businessCardsListNotifierProvider);
    if (mounted) Navigator.of(context).pop(true);
  }

  Future<bool> _trySave(BusinessCard card) async {
    final valid = _dataTabKey.currentState?.validateAndHighlight() ?? true;
    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseSpecifyLabelForCustom)),
      );
      return false;
    }
    final dataDraft = _dataTabKey.currentState?.getDraftCard();
    final toSave = dataDraft ?? card;
    if (!toSave.hasVCardData) {
      _editTabController?.animateTo(0);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.cardNeedsData),
        ),
      );
      // Nested post-frame callbacks: when on Appearance tab, TabBarView disposes the Data tab.
      // One frame is not enough for it to rebuild after animateTo(0). Two frames ensure the
      // Data tab is built and attached before we request focus on the first name field.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _dataTabKey.currentState?.focusFirstDataField();
        });
      });
      return false;
    }
    await _saveAndFlipBack(toSave);
    return true;
  }

  Future<void> _saveAndFlipBack(BusinessCard card) async {
    try {
      await ref.read(businessCardDetailNotifierProvider(widget.cardId).notifier).save(card);
      ref.invalidate(businessCardsListNotifierProvider);
      if (widget.cardId == null) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (context) => BusinessCardDetailScreen(cardId: card.id),
            ),
          );
        }
      } else {
        _toggleMode();
      }
    } catch (e, stack) {
      if (mounted) {
        final loc = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.saveFailed(e.toString())),
            action: SnackBarAction(
              label: loc.details,
              onPressed: () => debugPrintStack(stackTrace: stack),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final asyncCard = ref.watch(businessCardDetailNotifierProvider(widget.cardId));

    return asyncCard.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: Text(loc.error)),
        body: Center(child: Text(loc.errorGeneric(err.toString()))),
      ),
      data: (card) {
        if (card == null) {
          return Scaffold(
            appBar: AppBar(title: Text(loc.cardNotFound)),
            body: Center(child: Text(loc.cardNotFound)),
          );
        }
        if (_isEditMode && _initialCardWhenEditMode == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _initialCardWhenEditMode = card);
            }
          });
        }
        final resolver = _createResolver();
        return _buildContent(card, resolver);
      },
    );
  }

  bool _hasUnsavedChanges(BusinessCard card) {
    final dataDraft = _dataTabKey.currentState?.getDraftCard();
    // When Data tab is unavailable (e.g. user on Appearance tab, TabBarView disposed it),
    // use notifier's card as current state (it has latest appearance from Appearance tab).
    final currentForComparison = dataDraft != null
        ? dataDraft.copyWith(
            backgroundColor: card.backgroundColor,
            textColor: card.textColor,
            qrAppearance: card.qrAppearance,
            cardPhoto: card.cardPhoto,
            qrLogo: card.qrLogo,
          )
        : card;
    final baseline = _initialCardWhenEditMode ?? card;
    return currentForComparison.hasChangesComparedTo(baseline);
  }

  Future<void> _onBackPressed(BusinessCard card) async {
    if (_isEditMode) {
      if (_hasUnsavedChanges(card)) {
        final loc = AppLocalizations.of(context)!;
        final save = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(loc.discardChangesTitle),
            content: Text(loc.discardChangesMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(loc.discard),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(loc.saveChanges),
              ),
            ],
          ),
        );
        if (!mounted) return;
        if (save == true) {
          await _trySave(card);
        } else {
          final notifier =
              ref.read(businessCardDetailNotifierProvider(widget.cardId).notifier);
          if (_initialCardWhenEditMode != null) {
            notifier.updateCard(_initialCardWhenEditMode!);
          } else {
            ref.invalidate(businessCardDetailNotifierProvider(widget.cardId));
          }
          if (widget.cardId == null) {
            Navigator.of(context).pop(false);
          } else {
            _toggleMode();
          }
        }
      } else {
        if (widget.cardId == null) {
          Navigator.of(context).pop(false);
        } else {
          _toggleMode();
        }
      }
    } else {
      Navigator.of(context).pop(false);
    }
  }

  Future<void> _shareAsImage(BusinessCard card) async {
    await QrShareActions.shareAsImageWithFeedback(
      context,
      ref,
      _payloadFromCard(card),
      _createResolver(),
    );
  }

  Future<void> _shareAsVCard(BusinessCard card) async {
    await QrShareActions.shareAsVCardWithFeedback(
      context,
      ref,
      _payloadFromCard(card),
    );
  }

  DefaultAppearanceResolver _createResolver() {
    final settings = ref.watch(settingsNotifierProvider).valueOrNull;
    return DefaultAppearanceResolver(
      settings: settings,
      colorScheme: Theme.of(context).colorScheme,
    );
  }

  QrDisplayPayload _payloadFromCard(BusinessCard card) {
    return QrDisplayPayload(
      vCardContent: card.generateVCard(),
      qrAppearance: card.qrAppearance,
      displayContact: card.contact,
      photoOverride: card.cardPhoto,
      backgroundColor: card.backgroundColor,
      textColor: card.textColor,
      centerLogo: card.qrLogo,
    );
  }

  Widget _buildContent(BusinessCard card, DefaultAppearanceResolver resolver) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _onBackPressed(card);
      },
      child: Scaffold(
        appBar: null,
        backgroundColor: _isEditMode
            ? null
            : resolver.resolveBackgroundColor(card.backgroundColor),
        body: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isEditMode
                  ? _EditModeView(
                      key: const ValueKey('edit'),
                      card: card,
                      cardId: widget.cardId,
                      tabController: _editTabController!,
                      dataTabKey: _dataTabKey,
                      onSavePressed: () => _trySave(card),
                      onDelete: _deleteCard,
                      onClose: () => _onBackPressed(card),
                      notifier: ref.read(businessCardDetailNotifierProvider(widget.cardId).notifier),
                    )
                  : QrGestureWrapper(
                      key: const ValueKey('qr'),
                      payload: _payloadFromCard(card),
                      resolver: resolver,
                      onEnterEdit: () => _enterEditMode(card),
                      onClose: () => _onBackPressed(card),
                      onShareAsImage: () => _shareAsImage(card),
                      onShareAsVCard: () => _shareAsVCard(card),
                      editLabel: AppLocalizations.of(context)!.editCard,
                    ),
            ),
            if (!_isEditMode)
              QrCloseButton(
                backgroundColor: resolver.resolveBackgroundColor(card.backgroundColor),
                iconColor: resolver.resolveTextColor(card.textColor),
                onTap: () => _onBackPressed(card),
              ),
          ],
        ),
      ),
    );
  }
}

class _EditModeView extends StatelessWidget {
  const _EditModeView({
    super.key,
    required this.card,
    required this.cardId,
    required this.tabController,
    required this.dataTabKey,
    required this.onSavePressed,
    required this.onDelete,
    required this.onClose,
    required this.notifier,
  });

  final BusinessCard card;
  final String? cardId;
  final TabController tabController;
  final GlobalKey<BusinessCardDataTabState> dataTabKey;
  final Future<void> Function() onSavePressed;
  final void Function(BusinessCard) onDelete;
  final VoidCallback onClose;
  final BusinessCardDetailNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4, right: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onClose,
                  tooltip: loc.backTooltip,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async => await onSavePressed(),
                  child: Text(loc.save),
                ),
              ],
            ),
          ),
          TabBar(
            controller: tabController,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 20, color: Theme.of(context).colorScheme.onSurface),
                    const SizedBox(width: 8),
                    Text(loc.data),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.palette, size: 20, color: Theme.of(context).colorScheme.onSurface),
                    const SizedBox(width: 8),
                    Text(loc.appearance),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                BusinessCardDataTab(
                  key: dataTabKey,
                  card: card,
                  onDelete: cardId != null ? (c) => onDelete(c) : null,
                ),
                BusinessCardAppearanceTab(
                  card: card,
                  cardId: cardId,
                  onCardChanged: notifier.updateCard,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
