// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'qr_appearance.dart';

/// Payload for the generic Simple QR screen.
/// Used for URL, and extensible for vCard, WiFi, etc.
class SimpleQrPayload {
  const SimpleQrPayload({
    required this.data,
    required this.qrAppearance,
    this.backgroundColor,
    this.textColor,
    this.centerLogo,
  });

  final String data;
  final QrAppearance qrAppearance;
  final int? backgroundColor;
  final int? textColor;
  /// Optional center image when [QrAppearance.centerLogoEnabled] is true
  /// (mirrors business-card QR; default style in Settings has no logo bytes).
  final Uint8List? centerLogo;
}

/// Detected type of QR data. Used to adapt the content section.
enum QrDataType {
  url,
  other, // Future: vCard, WiFi, etc.
}

/// Detects the type of QR data from its content.
/// For now only URL is detected; other types return [QrDataType.other].
QrDataType detectQrDataType(String data) {
  final t = data.trim();
  if (t.startsWith('http://') || t.startsWith('https://')) {
    return QrDataType.url;
  }
  return QrDataType.other;
}
