// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/services/share_service.dart';
import '../../settings/services/default_appearance_resolver.dart';
import '../models/qr_display_payload.dart';
import '../models/simple_qr_payload.dart';
import '../utils/qr_decoration_factory.dart';

/// Service for sharing QR codes as image or vCard.
/// Used by both business cards and contact sharing flows.
class QrShareService {
  const QrShareService({ShareService? shareService})
      : _shareService = shareService ?? const ShareService();

  final ShareService _shareService;

  /// Shares the QR code as a PNG image.
  /// Returns null on success, or an error message on failure.
  Future<String?> shareAsImage(
    QrDisplayPayload payload,
    DefaultAppearanceResolver resolver,
  ) async {
    try {
      final qrCode = QrCode.fromData(
        data: payload.vCardContent,
        errorCorrectLevel: QrErrorCorrectLevel.H,
      );
      final qrImage = QrImage(qrCode);

      final decoration =
          QrDecorationFactory.forPayload(payload, resolver);

      const size = 512;
      final bytes = await qrImage.toImageAsBytes(
        size: size,
        format: ui.ImageByteFormat.png,
        decoration: decoration,
      );
      if (bytes == null) return 'Failed to generate QR image.';

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/qr_contact_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes.buffer.asUint8List());

      await _shareService.share(
        ShareParams(
          files: [XFile(file.path)],
          text: payload.displayName.isNotEmpty ? payload.displayName : 'Contact',
        ),
      );
      return null;
    } catch (e) {
      return 'Share failed: $e';
    }
  }

  /// Shares a simple QR (e.g. URL) as a PNG image.
  /// Returns null on success, or an error message on failure.
  Future<String?> shareSimpleQrAsImage(
    SimpleQrPayload payload,
    DefaultAppearanceResolver resolver, {
    required String shareCaption,
  }) async {
    try {
      final qrCode = QrCode.fromData(
        data: payload.data,
        errorCorrectLevel: QrErrorCorrectLevel.H,
      );
      final qrImage = QrImage(qrCode);

      final decoration =
          QrDecorationFactory.forSimplePayload(payload, resolver);

      const size = 512;
      final bytes = await qrImage.toImageAsBytes(
        size: size,
        format: ui.ImageByteFormat.png,
        decoration: decoration,
      );
      if (bytes == null) return 'Failed to generate QR image.';

      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/qr_simple_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(bytes.buffer.asUint8List());

      final caption =
          shareCaption.trim().isNotEmpty ? shareCaption.trim() : 'Link';
      await _shareService.share(
        ShareParams(
          files: [XFile(file.path)],
          text: caption,
        ),
      );
      return null;
    } catch (e) {
      return 'Share failed: $e';
    }
  }

  /// Shares the vCard content as a .vcf file.
  /// Returns null on success, or an error message on failure.
  Future<String?> shareAsVCard(QrDisplayPayload payload) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = _sanitizeFileName(payload.displayName);
      final file = File(
        '${tempDir.path}/${fileName}_${DateTime.now().millisecondsSinceEpoch}.vcf',
      );
      await file.writeAsString(payload.vCardContent, flush: true);

      await _shareService.share(
        ShareParams(
          files: [XFile(file.path)],
          text: payload.displayName.isNotEmpty ? payload.displayName : 'Contact',
        ),
      );
      return null;
    } catch (e) {
      return 'Share failed: $e';
    }
  }

  String _sanitizeFileName(String name) {
    if (name.isEmpty) return 'contact';
    final sanitized = name
        .replaceAll(RegExp(r'[^\w\s\-]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .toLowerCase();
    return sanitized.length > 30 ? sanitized.substring(0, 30) : sanitized;
  }
}
