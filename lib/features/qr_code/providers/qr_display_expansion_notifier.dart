// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qr_display_expansion_notifier.g.dart';

/// Expanded/collapsed state for the QR details "more" section.
///
/// [scopeId] must be unique per concurrent [QrDisplayView] (e.g. business card id,
/// contact share scope) so instances do not share expansion state.
@riverpod
class QrDisplayExpansion extends _$QrDisplayExpansion {
  @override
  bool build(String scopeId) => false;

  void toggle() => state = !state;
}
