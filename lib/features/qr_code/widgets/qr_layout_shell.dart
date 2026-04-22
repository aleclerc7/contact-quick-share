// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

/// Shared layout for QR code + content in portrait and landscape.
/// Portrait: QR on top, content below. Landscape: QR left, content right.
class QrLayoutShell extends StatelessWidget {
  /// Landscape row: QR column gets 60%, content 40%.
  static const _landscapeQrFlex = 55;
  static const _landscapeContentFlex = 45;

  const QrLayoutShell({
    super.key,
    required this.qrBuilder,
    required this.contentBuilder,
    this.border = 15.0,
  });

  /// Builds the QR code area. Receives [qrSize] for consistent sizing.
  final Widget Function(BuildContext context, double qrSize) qrBuilder;

  /// Builds the content section (right in landscape, bottom in portrait).
  /// [isLandscape] is provided for content that adapts layout (e.g. alignment).
  final Widget Function(BuildContext context, {required bool isLandscape})
      contentBuilder;

  /// Padding around QR and content. Default 15.0.
  final double border;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.size.width > mediaQuery.size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - 2 * border;
        final totalLandscapeFlex =
            _landscapeQrFlex + _landscapeContentFlex;
        final qrSize = isLandscape
            ? (constraints.maxWidth * _landscapeQrFlex / totalLandscapeFlex -
                    2 * border)
                .clamp(0.0, constraints.maxHeight - 2 * border)
            : availableWidth.clamp(0.0, double.infinity);

        final qrWidget = qrBuilder(context, qrSize);
        final contentWidget = contentBuilder(context, isLandscape: isLandscape);

        if (isLandscape) {
          return Row(
            children: [
              Expanded(
                flex: _landscapeQrFlex,
                child: Padding(
                  padding: EdgeInsets.all(border),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: qrWidget,
                  ),
                ),
              ),
              Expanded(
                flex: _landscapeContentFlex,
                child: Padding(
                  padding: EdgeInsets.all(border),
                  child: contentWidget,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            const Spacer(flex: 3),
            Padding(
              padding: EdgeInsets.all(border),
              child: qrWidget,
            ),
            const SizedBox(height: 24),
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(
                  left: border,
                  right: border,
                  bottom: border,
                ),
                child: contentWidget,
              ),
            ),
          ],
        );
      },
    );
  }
}
