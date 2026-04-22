// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Which appearance slot the bytes belong to (determines max raster edge).
enum AppearanceImageKind {
  cardPhoto,
  qrLogo,
}

/// Why normalization did not return processed raster bytes.
enum AppearanceImageNormalizeError {
  /// Input exceeded [AppearanceImageNormalizer.maxInputBytes].
  inputTooLarge,

  /// Bytes were not SVG/GIF pass-through but could not be decoded as a raster image.
  decodeFailed,
}

/// Result of [AppearanceImageNormalizer.normalize].
final class AppearanceImageNormalizeResult {
  const AppearanceImageNormalizeResult.ok(Uint8List this.bytes) : error = null;

  const AppearanceImageNormalizeResult.failure(AppearanceImageNormalizeError this.error)
      : bytes = null;

  final Uint8List? bytes;
  final AppearanceImageNormalizeError? error;

  bool get isSuccess => bytes != null;
}

/// Downscales picked raster images for storage; passes through SVG and GIF unchanged.
class AppearanceImageNormalizer {
  AppearanceImageNormalizer._();

  /// Guardrail before decoding in Dart (16 MiB).
  static const int maxInputBytes = 16 * 1024 * 1024;

  static const int _maxEdgeCard = 400;
  static const int _maxEdgeQrLogo = 192;

  static const int _jpegQuality = 85;

  static int maxEdgeFor(AppearanceImageKind kind) => switch (kind) {
        AppearanceImageKind.cardPhoto => _maxEdgeCard,
        AppearanceImageKind.qrLogo => _maxEdgeQrLogo,
      };

  /// Normalizes [bytes] for the given [kind].
  ///
  /// SVG (XML prefix) and GIF are returned unchanged. Other rasters are decoded,
  /// resized if the longer side exceeds the kind's max edge, then re-encoded as
  /// JPEG (no alpha) or PNG (alpha).
  static AppearanceImageNormalizeResult normalize(
    Uint8List bytes,
    AppearanceImageKind kind,
  ) {
    if (bytes.isEmpty) {
      return const AppearanceImageNormalizeResult.failure(
        AppearanceImageNormalizeError.decodeFailed,
      );
    }
    if (bytes.length > maxInputBytes) {
      return const AppearanceImageNormalizeResult.failure(
        AppearanceImageNormalizeError.inputTooLarge,
      );
    }
    if (_looksLikeSvg(bytes) || _looksLikeGif(bytes)) {
      return AppearanceImageNormalizeResult.ok(bytes);
    }

    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      return const AppearanceImageNormalizeResult.failure(
        AppearanceImageNormalizeError.decodeFailed,
      );
    }

    final maxEdge = maxEdgeFor(kind);
    final w = decoded.width;
    final h = decoded.height;

    final longSide = w >= h ? w : h;
    if (longSide <= maxEdge) {
      return AppearanceImageNormalizeResult.ok(bytes);
    }

    final int nw;
    final int nh;
    if (w >= h) {
      nw = maxEdge;
      nh = (h * maxEdge / w).round();
    } else {
      nh = maxEdge;
      nw = (w * maxEdge / h).round();
    }
    final processed = img.copyResize(
      decoded,
      width: nw,
      height: nh,
      interpolation: img.Interpolation.linear,
    );

    final Uint8List out;
    if (processed.hasAlpha) {
      out = Uint8List.fromList(img.encodePng(processed));
    } else {
      out = Uint8List.fromList(
        img.encodeJpg(processed, quality: _jpegQuality),
      );
    }
    return AppearanceImageNormalizeResult.ok(out);
  }

  static bool _looksLikeGif(Uint8List bytes) {
    return bytes.length >= 6 &&
        bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x38 &&
        (bytes[4] == 0x39 || bytes[4] == 0x37) &&
        bytes[5] == 0x61;
  }

  /// Cheap prefix check for SVG/XML text (pass-through for vector storage).
  static bool _looksLikeSvg(Uint8List bytes) {
    var i = 0;
    if (bytes.length >= 3 &&
        bytes[0] == 0xEF &&
        bytes[1] == 0xBB &&
        bytes[2] == 0xBF) {
      i = 3;
    }
    const maxScan = 512;
    while (i < bytes.length && i < maxScan && bytes[i] <= 0x20) {
      i++;
    }
    if (i >= bytes.length) return false;
    final end = (i + 256) > bytes.length ? bytes.length : i + 256;
    final head = String.fromCharCodes(bytes.sublist(i, end)).toLowerCase();
    return head.startsWith('<svg') ||
        (head.startsWith('<?xml') && head.contains('svg'));
  }
}
