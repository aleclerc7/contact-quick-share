// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(
      ['contact_quick_share'],
      'Contact Quick Share is licensed under the Mozilla Public License 2.0 '
      '(MPL 2.0).\n\n'
      'See https://www.mozilla.org/en-US/MPL/2.0/ for the full license text.',
    );
  });

  await bootstrap();
  runApp(
    const ProviderScope(
      child: ContactQuickShareApp(),
    ),
  );
}
