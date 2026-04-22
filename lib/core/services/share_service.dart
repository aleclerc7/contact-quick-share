// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:ui';

import 'package:share_plus/share_plus.dart';

/// Centralized service for sharing files and text across the app.
/// Handles platform-specific requirements (e.g., iOS share position).
class ShareService {
  const ShareService();

  /// Shares files and optional text using the native share sheet.
  /// Automatically handles iOS/macOS share sheet positioning.
  Future<void> share(ShareParams params) async {
    final paramsWithPosition = _addSharePositionOriginIfNeeded(params);
    await SharePlus.instance.share(paramsWithPosition);
  }

  /// Adds sharePositionOrigin for iOS/macOS if not already set.
  /// Uses the center of the screen as the anchor point.
  /// Only includes parameters that are actually set in the original params.
  ShareParams _addSharePositionOriginIfNeeded(ShareParams params) {
    // If position is already set, don't override it
    if (params.sharePositionOrigin != null) {
      return params;
    }

    // Calculate center of screen for iOS share sheet anchor
    final view = PlatformDispatcher.instance.views.first;
    final screenSize = view.physicalSize / view.devicePixelRatio;
    final sharePosition = Rect.fromLTWH(
      screenSize.width / 2,
      screenSize.height / 2,
      1,
      1,
    );

    // Create new params with position, preserving only non-empty values
    return ShareParams(
      files: params.files,
      fileNameOverrides: params.fileNameOverrides?.isNotEmpty == true ? params.fileNameOverrides : null,
      text: params.text?.isNotEmpty == true ? params.text : null,
      subject: params.subject?.isNotEmpty == true ? params.subject : null,
      sharePositionOrigin: sharePosition,
    );
  }
}
