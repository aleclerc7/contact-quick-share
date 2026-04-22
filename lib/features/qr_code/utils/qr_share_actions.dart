// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_providers.dart';
import '../../settings/services/default_appearance_resolver.dart';
import '../models/qr_display_payload.dart';
import '../models/simple_qr_payload.dart';

/// Helper for share actions with unified error feedback (SnackBar).
/// Used by business cards and contact sharing flows.
class QrShareActions {
  QrShareActions._();

  /// Shares the QR code as image. Shows SnackBar on error if still mounted.
  static Future<void> shareAsImageWithFeedback(
    BuildContext context,
    WidgetRef ref,
    QrDisplayPayload payload,
    DefaultAppearanceResolver resolver,
  ) async {
    final err = await ref.read(qrShareServiceProvider).shareAsImage(
          payload,
          resolver,
        );
    if (context.mounted && err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    }
  }

  /// Shares the vCard content. Shows SnackBar on error if still mounted.
  static Future<void> shareAsVCardWithFeedback(
    BuildContext context,
    WidgetRef ref,
    QrDisplayPayload payload,
  ) async {
    final err = await ref.read(qrShareServiceProvider).shareAsVCard(payload);
    if (context.mounted && err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    }
  }

  /// Shares a simple QR as image. Shows SnackBar on error if still mounted.
  static Future<void> shareSimpleAsImageWithFeedback(
    BuildContext context,
    WidgetRef ref,
    SimpleQrPayload payload,
    DefaultAppearanceResolver resolver, {
    required String shareCaption,
  }) async {
    final err = await ref.read(qrShareServiceProvider).shareSimpleQrAsImage(
          payload,
          resolver,
          shareCaption: shareCaption,
        );
    if (context.mounted && err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    }
  }
}
