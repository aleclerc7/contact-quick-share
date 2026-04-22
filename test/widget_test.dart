// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// Basic Flutter widget test for Contact Quick Share.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:contact_quick_share/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: ContactQuickShareApp(),
      ),
    );
    // One frame is enough: avoid pumpAndSettle (async init / progress indicators never finish).
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
