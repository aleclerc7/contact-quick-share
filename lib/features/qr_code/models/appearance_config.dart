// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'qr_appearance.dart';

/// Editable appearance configuration for cards and default settings.
/// Single source of truth for card bg, text color, QR style, and optional photos.
class AppearanceConfig {
  const AppearanceConfig({
    this.backgroundColor,
    this.textColor,
    required this.qrAppearance,
    this.cardPhoto,
    this.qrLogo,
  });

  final int? backgroundColor;
  final int? textColor;
  final QrAppearance qrAppearance;
  final Uint8List? cardPhoto;
  final Uint8List? qrLogo;

  static const _undefined = Object();

  AppearanceConfig copyWith({
    Object? backgroundColor = _undefined,
    Object? textColor = _undefined,
    QrAppearance? qrAppearance,
    Object? cardPhoto = _undefined,
    Object? qrLogo = _undefined,
  }) {
    return AppearanceConfig(
      backgroundColor: identical(backgroundColor, _undefined)
          ? this.backgroundColor
          : backgroundColor as int?,
      textColor: identical(textColor, _undefined)
          ? this.textColor
          : textColor as int?,
      qrAppearance: qrAppearance ?? this.qrAppearance,
      cardPhoto: identical(cardPhoto, _undefined)
          ? this.cardPhoto
          : cardPhoto as Uint8List?,
      qrLogo:
          identical(qrLogo, _undefined) ? this.qrLogo : qrLogo as Uint8List?,
    );
  }
}
