// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:convert';
import 'dart:typed_data';

import 'package:contact_quick_share/core/utils/appearance_image_normalizer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

void main() {
  group('AppearanceImageNormalizer', () {
    test('downscales card photo to max 400px long edge', () {
      final big = img.Image(width: 800, height: 400);
      img.fill(big, color: img.ColorRgb8(200, 100, 50));
      final raw = Uint8List.fromList(img.encodePng(big));

      final r = AppearanceImageNormalizer.normalize(
        raw,
        AppearanceImageKind.cardPhoto,
      );
      expect(r.isSuccess, isTrue);
      final out = img.decodeImage(r.bytes!);
      expect(out, isNotNull);
      expect(out!.width, 400);
      expect(out.height, 200);
    });

    test('downscales QR logo to max 192px long edge', () {
      final big = img.Image(width: 400, height: 400);
      img.fill(big, color: img.ColorRgb8(0, 0, 255));
      final raw = Uint8List.fromList(img.encodePng(big));

      final r = AppearanceImageNormalizer.normalize(
        raw,
        AppearanceImageKind.qrLogo,
      );
      expect(r.isSuccess, isTrue);
      final out = img.decodeImage(r.bytes!);
      expect(out, isNotNull);
      expect(out!.width, 192);
      expect(out.height, 192);
    });

    test('returns original bytes for SVG prefix', () {
      final svg = utf8.encode(
        '<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg"></svg>',
      );
      final raw = Uint8List.fromList(svg);

      final r = AppearanceImageNormalizer.normalize(
        raw,
        AppearanceImageKind.cardPhoto,
      );
      expect(r.isSuccess, isTrue);
      expect(r.bytes, raw);
    });

    test('returns original bytes for GIF signature (pass-through)', () {
      final raw = Uint8List.fromList([
        0x47, 0x49, 0x46, 0x38, 0x39, 0x61, 0x00, 0x01,
      ]);

      final r = AppearanceImageNormalizer.normalize(
        raw,
        AppearanceImageKind.qrLogo,
      );
      expect(r.isSuccess, isTrue);
      expect(r.bytes, raw);
    });

    test('inputTooLarge when bytes exceed cap', () {
      final raw = Uint8List(AppearanceImageNormalizer.maxInputBytes + 1);

      final r = AppearanceImageNormalizer.normalize(
        raw,
        AppearanceImageKind.cardPhoto,
      );
      expect(r.isSuccess, isFalse);
      expect(r.error, AppearanceImageNormalizeError.inputTooLarge);
    });

    test('decodeFailed for empty bytes', () {
      final r = AppearanceImageNormalizer.normalize(
        Uint8List(0),
        AppearanceImageKind.cardPhoto,
      );
      expect(r.isSuccess, isFalse);
      expect(r.error, AppearanceImageNormalizeError.decodeFailed);
    });

    test('encode PNG when resized image has alpha', () {
      final src = img.Image(width: 600, height: 600, numChannels: 4);
      img.fill(src, color: img.ColorRgba8(10, 20, 30, 128));
      final raw = Uint8List.fromList(img.encodePng(src));

      final r = AppearanceImageNormalizer.normalize(
        raw,
        AppearanceImageKind.cardPhoto,
      );
      expect(r.isSuccess, isTrue);
      expect(r.bytes!.length, greaterThan(8));
      final out = img.decodeImage(r.bytes!);
      expect(out, isNotNull);
      expect(out!.hasAlpha, isTrue);
    });
  });
}
