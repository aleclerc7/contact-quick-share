// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../models/qr_appearance.dart';
import '../utils/qr_decoration_factory.dart';

/// Reusable widget that displays a live preview of [QrAppearance].
/// Used in Design tab, Settings > Default QR Style, and business card detail view.
///
/// When [size] is null, fills available space: max width limited by max height,
/// with [border] padding. When [backgroundColor] is set, the whole space uses
/// that color (e.g. card background for WYSIWYG preview).
class QrAppearancePreviewWidget extends StatelessWidget {
  const QrAppearancePreviewWidget({
    super.key,
    required this.appearance,
    this.sampleData,
    this.centerImage,
    this.size,
    this.backgroundColor,
    this.border = 30,
    this.primaryColorOverride,
  });

  final QrAppearance appearance;
  final String? sampleData;
  final Uint8List? centerImage;
  final double? size;
  final Color? backgroundColor;
  final double border;
  final Color? primaryColorOverride;

  @override
  Widget build(BuildContext context) {
    final data = sampleData ?? 'Sample';
    final bgForContrast =
        backgroundColor ?? Theme.of(context).colorScheme.surface;
    final decoration = QrDecorationFactory.forAppearance(
      appearance,
      backgroundForContrast: bgForContrast,
      primaryColorOverride: primaryColorOverride,
      centerImage: centerImage,
    );

    Widget qrContent = size != null
        ? Center(
            child: Padding(
              padding: EdgeInsets.all(border),
              child: SizedBox(
                width: size!,
                height: size!,
                child: PrettyQrView.data(
                  data: data,
                  decoration: decoration,
                  errorCorrectLevel: QrErrorCorrectLevel.H,
                ),
              ),
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
              final qrSize = (w.isFinite && h.isFinite)
                  ? (w < h ? w : h) - 2 * border
                  : 200.0;
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(border),
                  child: SizedBox(
                    width: qrSize.clamp(0.0, double.infinity),
                    height: qrSize.clamp(0.0, double.infinity),
                    child: PrettyQrView.data(
                      data: data,
                      decoration: decoration,
                      errorCorrectLevel: QrErrorCorrectLevel.H,
                    ),
                  ),
                ),
              );
            },
          );

    if (backgroundColor != null) {
      qrContent = ColoredBox(color: backgroundColor!, child: qrContent);
    }

    return size != null
        ? SizedBox(
            width: size! + 2 * border,
            height: size! + 2 * border,
            child: qrContent,
          )
        : qrContent;
  }
}
