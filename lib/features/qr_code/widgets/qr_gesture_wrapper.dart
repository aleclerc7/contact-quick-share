// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import '../../settings/services/default_appearance_resolver.dart';
import '../models/qr_display_payload.dart';
import 'qr_action_menu.dart';
import 'qr_display_view.dart';
import 'qr_raw_data_dialog.dart';

/// Wraps [QrDisplayView] with gesture handling: tap opens the action menu,
/// swipe right-to-left enters edit, swipe left-to-right closes.
/// Used by both business cards and contact sharing flows.
class QrGestureWrapper extends StatefulWidget {
  const QrGestureWrapper({
    super.key,
    required this.payload,
    required this.resolver,
    required this.onEnterEdit,
    required this.onClose,
    required this.onShareAsImage,
    required this.onShareAsVCard,
    required this.editLabel,
  });

  final QrDisplayPayload payload;
  final DefaultAppearanceResolver resolver;
  final VoidCallback onEnterEdit;
  final VoidCallback onClose;
  final VoidCallback onShareAsImage;
  final VoidCallback onShareAsVCard;
  final String editLabel;

  @override
  State<QrGestureWrapper> createState() => _QrGestureWrapperState();
}

class _QrGestureWrapperState extends State<QrGestureWrapper> {
  static const _swipeThreshold = 100.0;

  void _onHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity < -_swipeThreshold) {
      widget.onEnterEdit();
    } else if (velocity > _swipeThreshold) {
      widget.onClose();
    }
  }

  void _openActionMenu() {
    QrActionMenu.show(
      context,
      onShareAsImage: widget.onShareAsImage,
      onShareAsVCard: widget.onShareAsVCard,
      onViewQrDataAsText: () => QrRawDataDialog.show(
        context,
        widget.payload.vCardContent,
      ),
      trailing: QrActionMenuTrailingItem(
        label: widget.editLabel,
        icon: Icons.edit,
        onTap: widget.onEnterEdit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _openActionMenu,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: QrDisplayView(
        payload: widget.payload,
        resolver: widget.resolver,
      ),
    );
  }
}
