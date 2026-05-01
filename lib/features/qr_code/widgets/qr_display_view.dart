// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../settings/services/default_appearance_resolver.dart';
import '../models/qr_display_payload.dart';
import '../providers/qr_display_expansion_notifier.dart';
import '../utils/qr_decoration_factory.dart';
import 'qr_layout_shell.dart';
import 'vcard_data_display.dart';

/// Pure presentational widget: QR code + details below.
/// Used by both business cards and contact sharing flows.
/// Supports progressive disclosure: tap the summary text or chevron to expand/collapse
/// additional data (when present).
///
/// [expansionScopeId] must be unique per concurrent instance (see [QrDisplayExpansion]).
class QrDisplayView extends ConsumerStatefulWidget {
  const QrDisplayView({
    super.key,
    required this.payload,
    required this.resolver,
    required this.expansionScopeId,
  });

  final QrDisplayPayload payload;
  final DefaultAppearanceResolver resolver;
  final String expansionScopeId;

  @override
  ConsumerState<QrDisplayView> createState() => _QrDisplayViewState();
}

class _QrDisplayViewState extends ConsumerState<QrDisplayView> {
  static const _border = 15.0;
  static const _photoSize = 108.0;
  static const _photoBorderRadius = 18.0;

  QrDisplayPayload get payload => widget.payload;

  void _toggleExpanded() {
    ref
        .read(qrDisplayExpansionProvider(widget.expansionScopeId).notifier)
        .toggle();
  }

  Widget _buildChevron(BuildContext context, {required bool expanded}) {
    final textColor = widget.resolver.resolveTextColor(payload.textColor);
    return GestureDetector(
      onTap: _toggleExpanded,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Icon(
          expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
    required bool expanded,
  }) {
    final isExpanded = hasExpandable && expanded;
    final summaryBlock = Column(
      mainAxisSize: MainAxisSize.min,
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
      ],
    );

    return Column(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasExpandable)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _toggleExpanded,
            child: summaryBlock,
          )
        else
          summaryBlock,
        if (hasExpandable) _buildChevron(context, expanded: expanded),
        if (isExpanded) ...[
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: _border),
              child: VcardDataDisplay(
                contact: payload.displayContact,
                textColor: textColor,
                summaryDisplayName: payload.displayName,
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
    required bool expanded,
  }) {
    final detailsColumn = _buildDetailsColumn(
      context,
      hasExpandable: hasExpandable,
      textColor: textColor,
      expanded: expanded,
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
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.memory(payload.photo!, fit: BoxFit.cover),
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
                style: TextStyle(fontSize: 16, color: textColor),
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
                expanded: false,
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
    final decoration = QrDecorationFactory.forPayload(payload, widget.resolver);
    final textColor = widget.resolver.resolveTextColor(payload.textColor);
    final hasExpandable = VcardDataDisplay.hasExpandableData(
      payload.displayContact,
      summaryDisplayName: payload.displayName,
    );
    final expanded = ref.watch(
      qrDisplayExpansionProvider(widget.expansionScopeId),
    );

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
                    expanded: expanded,
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
