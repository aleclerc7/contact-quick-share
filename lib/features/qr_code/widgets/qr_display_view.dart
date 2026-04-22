// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../settings/services/default_appearance_resolver.dart';
import '../models/qr_display_payload.dart';
import '../utils/qr_decoration_factory.dart';
import 'qr_layout_shell.dart';
import 'vcard_data_display.dart';

/// Pure presentational widget: QR code + details below.
/// Used by both business cards and contact sharing flows.
/// Supports progressive disclosure: tap chevron to expand/collapse additional data.
class QrDisplayView extends StatefulWidget {
  const QrDisplayView({
    super.key,
    required this.payload,
    required this.resolver,
  });

  final QrDisplayPayload payload;
  final DefaultAppearanceResolver resolver;

  @override
  State<QrDisplayView> createState() => _QrDisplayViewState();
}

class _QrDisplayViewState extends State<QrDisplayView> {
  static const _border = 15.0;
  static const _photoSize = 108.0;
  static const _photoBorderRadius = 18.0;
  bool _expanded = false;

  QrDisplayPayload get payload => widget.payload;

  Widget _buildChevron(BuildContext context) {
    final textColor = widget.resolver.resolveTextColor(payload.textColor);
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Icon(
          _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          size: 24,
          color: textColor.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  /// Builds the full details column: name, subtitle, email, phone, chevron, expanded content.
  /// Aligned under the text; when there's a photo, the photo stays clean on the left.
  Widget _buildDetailsColumn(
    BuildContext context, {
    required bool hasExpandable,
    required Color textColor,
  }) {
    final isExpanded = hasExpandable && _expanded;
    return Column(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          payload.displayName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        if (payload.displaySubtitle.isNotEmpty) ...[
          const SizedBox(height: 0),
          Text(
            payload.displaySubtitle,
            style: TextStyle(
              fontSize: 14,
              color: textColor.withValues(alpha: 0.85),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
        if (payload.primaryEmail.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            payload.primaryEmail,
            style: TextStyle(
              fontSize: 13,
              color: textColor.withValues(alpha: 0.75),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
        if (payload.primaryPhone.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            payload.primaryPhone,
            style: TextStyle(
              fontSize: 13,
              color: textColor.withValues(alpha: 0.75),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
        if (hasExpandable) _buildChevron(context),
        if (isExpanded) ...[
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: _border),
              child: VcardDataDisplay(
                contact: payload.displayContact,
                textColor: textColor,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Builds the data section: photo (if any) + details column.
  /// Chevron and expanded content are inside the details column, aligned under the text.
  Widget _buildDataSection(
    BuildContext context, {
    required bool hasExpandable,
    required Color textColor,
  }) {
    final detailsColumn = _buildDetailsColumn(
      context,
      hasExpandable: hasExpandable,
      textColor: textColor,
    );

    if (payload.photo == null) {
      return detailsColumn;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _photoSize,
          height: _photoSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_photoBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.memory(
            payload.photo!,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 2 * _border),
        Flexible(child: detailsColumn),
      ],
    );
  }

  Widget _buildOverflowFallback(BuildContext context) {
    final textColor = widget.resolver.resolveTextColor(payload.textColor);
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(_border),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.qr_code_2,
                size: 64,
                color: textColor.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'Too much information to share via QR code. Try to remove some.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Open the menu or swipe to edit and remove fields.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              _buildDataSection(
                context,
                hasExpandable: false,
                textColor: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return _buildQrContent(context);
    } on InputTooLongException {
      return _buildOverflowFallback(context);
    }
  }

  Widget _buildQrContent(BuildContext context) {
    final decoration =
        QrDecorationFactory.forPayload(payload, widget.resolver);
    final textColor = widget.resolver.resolveTextColor(payload.textColor);
    final hasExpandable = VcardDataDisplay.hasExpandableData(payload.displayContact);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: QrLayoutShell(
              border: _border,
              qrBuilder: (context, qrSize) => _QrCodeArea(
                size: qrSize,
                data: payload.vCardContent,
                decoration: decoration,
              ),
              contentBuilder: (context, {required bool isLandscape}) =>
                  _buildDataSection(
                context,
                hasExpandable: hasExpandable,
                textColor: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QrCodeArea extends StatelessWidget {
  const _QrCodeArea({
    required this.size,
    required this.data,
    required this.decoration,
  });

  final double size;
  final String data;
  final PrettyQrDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: PrettyQrView.data(
        data: data,
        decoration: decoration,
        errorCorrectLevel: QrErrorCorrectLevel.H,
      ),
    );
  }
}
