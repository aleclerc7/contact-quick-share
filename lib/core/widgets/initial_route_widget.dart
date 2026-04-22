// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../features/business_cards/providers/business_cards_list_notifier.dart';
import '../../features/business_cards/screens/business_card_detail_screen.dart';
import '../../features/contacts/screens/contacts_screen.dart';
import '../di/app_providers.dart';
import '../../features/settings/settings.dart';

/// Result of determining the initial route.
class _InitialRouteResult {
  const _InitialRouteResult({this.showCard = false, this.cardId});

  final bool showCard;
  final String? cardId;
}

/// Loads only settings and the single auto-open card (if configured).
/// Does NOT load contacts or full business cards list.
final _initialRouteProvider = FutureProvider<_InitialRouteResult>((ref) async {
  final settings = await ref.read(settingsNotifierProvider.future);
  final cardId = settings.autoOpenCardId;
  if (cardId == null) {
    return const _InitialRouteResult(showCard: false, cardId: null);
  }
  final repo = ref.read(businessCardRepositoryProvider);
  final card = await repo.getById(cardId);
  if (card == null) {
    return const _InitialRouteResult(showCard: false, cardId: null);
  }
  return _InitialRouteResult(showCard: true, cardId: cardId);
});

/// Decides the first screen: card (if auto-open) or contacts list.
/// Loads only settings + single card; defers contacts/list to background.
class InitialRouteWidget extends ConsumerStatefulWidget {
  const InitialRouteWidget({super.key});

  @override
  ConsumerState<InitialRouteWidget> createState() => _InitialRouteWidgetState();
}

class _InitialRouteWidgetState extends ConsumerState<InitialRouteWidget> {
  /// When user pops the card, we show only the list.
  bool _cardPushed = true;

  @override
  Widget build(BuildContext context) {
    final asyncResult = ref.watch(_initialRouteProvider);

    return asyncResult.when(
      loading: () {
        ref.read(businessCardsListNotifierProvider);
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
      error: (err, _) => Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.errorGeneric(err.toString()))),
      ),
      data: (result) {
        if (result.showCard && result.cardId != null && _cardPushed) {
          return Navigator(
            pages: [
              const MaterialPage<void>(
                child: ContactsScreen(),
                key: ValueKey('contacts'),
              ),
              MaterialPage<void>(
                child: BusinessCardDetailScreen(cardId: result.cardId),
                key: const ValueKey('card'),
              ),
            ],
            onDidRemovePage: (page) {
              setState(() => _cardPushed = false);
            },
          );
        }
        return const ContactsScreen();
      },
    );
  }
}
