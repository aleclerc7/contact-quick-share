// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../settings/services/default_appearance_resolver.dart';
import '../models/qr_appearance.dart';
import '../models/qr_display_payload.dart';
import '../models/simple_qr_payload.dart';

/// Factory for building [PrettyQrDecoration] from payloads and appearance config.
/// Single source of truth for QR decoration assembly across display, share, and preview.
class QrDecorationFactory {
  QrDecorationFactory._();

  /// Builds decoration for [QrDisplayPayload] (business cards, contact sharing).
  static PrettyQrDecoration forPayload(
    QrDisplayPayload payload,
    DefaultAppearanceResolver resolver,
  ) {
    final bgForContrast =
        resolver.resolveBackgroundColor(payload.backgroundColor);
    return payload.qrAppearance.toPrettyQrDecoration(
      centerImage: payload.centerLogo != null
          ? MemoryImage(payload.centerLogo!)
          : null,
      backgroundForContrast: bgForContrast,
      primaryColorOverride:
          resolver.resolveQrPrimaryColor(payload.qrAppearance.primaryColor),
    );
  }

  /// Builds decoration for [SimpleQrPayload] (URL, WiFi, etc.).
  /// Uses [forAppearance] so rendering matches [QrAppearancePreviewWidget]
  /// (same pipeline as Settings > Default QR code style preview).
  static PrettyQrDecoration forSimplePayload(
    SimpleQrPayload payload,
    DefaultAppearanceResolver resolver,
  ) {
    final bgForContrast =
        resolver.resolveBackgroundColor(payload.backgroundColor);
    return forAppearance(
      payload.qrAppearance,
      backgroundForContrast: bgForContrast,
      primaryColorOverride:
          resolver.resolveQrPrimaryColor(payload.qrAppearance.primaryColor),
      centerImage: payload.centerLogo,
    );
  }

  /// Builds decoration for [QrAppearance] with explicit colors.
  /// Used by [QrAppearancePreviewWidget] and other preview contexts.
  static PrettyQrDecoration forAppearance(
    QrAppearance appearance, {
    required Color backgroundForContrast,
    Color? primaryColorOverride,
    Uint8List? centerImage,
  }) {
    return appearance.toPrettyQrDecoration(
      centerImage: centerImage != null ? MemoryImage(centerImage) : null,
      backgroundForContrast: backgroundForContrast,
      primaryColorOverride: primaryColorOverride,
    );
  }
}
