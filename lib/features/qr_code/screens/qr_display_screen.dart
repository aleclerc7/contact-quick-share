// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import '../../settings/services/default_appearance_resolver.dart';
import '../models/qr_display_payload.dart';
import '../widgets/qr_close_button.dart';
import '../widgets/qr_display_view.dart';

/// Full-screen QR display. Shared by business cards and contact sharing.
/// When [editContentBuilder] is provided, tap to flip shows edit content; [onDone] flips back.
class QrDisplayScreen extends StatefulWidget {
  const QrDisplayScreen({
    super.key,
    required this.payload,
    required this.resolver,
    this.editContentBuilder,
    this.onClose,
  });

  final QrDisplayPayload payload;
  final DefaultAppearanceResolver resolver;
  /// When provided, tap to flip shows edit content.
  /// Call [onDone] to flip back; pass [QrDisplayPayload] to update the displayed QR.
  final Widget Function(
    BuildContext context,
    void Function([QrDisplayPayload? updatedPayload]) onDone,
  )? editContentBuilder;
  final VoidCallback? onClose;

  @override
  State<QrDisplayScreen> createState() => _QrDisplayScreenState();
}

class _QrDisplayScreenState extends State<QrDisplayScreen> {
  late QrDisplayPayload _payload;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  void didUpdateWidget(QrDisplayScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditMode && widget.payload != oldWidget.payload) {
      _payload = widget.payload;
    }
  }

  void _toggleMode() {
    setState(() => _isEditMode = !_isEditMode);
  }

  void _onDone([QrDisplayPayload? updatedPayload]) {
    if (updatedPayload != null) {
      setState(() => _payload = updatedPayload);
    }
    setState(() => _isEditMode = false);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.resolver.resolveBackgroundColor(_payload.backgroundColor);
    final textColor = widget.resolver.resolveTextColor(_payload.textColor);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (widget.onClose != null) {
          widget.onClose!();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: null,
        backgroundColor: _isEditMode ? null : backgroundColor,
        body: Stack(
          children: [
            GestureDetector(
              onTap: _isEditMode ? null : _toggleMode,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isEditMode && widget.editContentBuilder != null
                    ? KeyedSubtree(
                        key: const ValueKey('edit'),
                        child: widget.editContentBuilder!(
                          context,
                          _onDone,
                        ),
                      )
                    : QrDisplayView(
                        key: const ValueKey('qr'),
                        payload: _payload,
                        resolver: widget.resolver,
                      ),
              ),
            ),
            if (!_isEditMode)
              QrCloseButton(
                backgroundColor: backgroundColor,
                iconColor: textColor,
                onTap: widget.onClose ?? () => Navigator.of(context).pop(),
              ),
          ],
        ),
      ),
    );
  }
}
