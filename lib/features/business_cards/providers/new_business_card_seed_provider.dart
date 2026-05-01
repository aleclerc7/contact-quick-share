// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/business_card.dart';

/// One draft [BusinessCard] for [cardId] == null navigation, consumed in
/// [BusinessCardDetailNotifier] so the first frame is the seeded card.
final newBusinessCardSeedProvider = StateProvider<BusinessCard?>((ref) => null);
