// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../core/utils/appearance_image_normalizer.dart';
import '../../../core/widgets/form_section_title.dart';
import '../../settings/services/default_appearance_resolver.dart';
import '../config/color_picker_config.dart';
import '../models/appearance_config.dart';
import '../models/qr_appearance.dart';
import 'qr_appearance_preview.dart';

/// Reusable appearance editor: card colors, photos (optional), QR style.
/// Used by BusinessCardAppearanceTab and Settings > Default QR Code Style.
/// When [resolver] is provided (business card), the "no color" swatch shows the
/// effective default behind the red line. When null (settings screen), uses theme.
class AppearanceEditorWidget extends StatelessWidget {
  const AppearanceEditorWidget({
    super.key,
    required this.config,
    required this.onChanged,
    this.resolver,
    this.showPhotoSection = true,
    this.previewDisplayName = 'Your Name',
    this.previewSubtitle = 'Your info',
    this.sampleVCardData,
  });

  final AppearanceConfig config;
  final void Function(AppearanceConfig) onChanged;
  final DefaultAppearanceResolver? resolver;
  final bool showPhotoSection;
  final String previewDisplayName;
  final String previewSubtitle;
  final String? sampleVCardData;

  static const _previewBorder = 15.0;

  static const _defaultSampleVCard =
      'BEGIN:VCARD\nVERSION:3.0\nFN:Your Name\nORG:Your Company\nTITLE:Your Title\nEND:VCARD';

  /// Returns a minimal vCard that always fits QR Version 1 (~17 bytes with H correction).
  /// Use for preview-only contexts (appearance editor) so the QR always renders.
  static String minimalPreviewVCard(String name) {
    final safeName = name.trim().isEmpty ? 'Your Name' : name;
    return 'BEGIN:VCARD\nVERSION:3.0\nFN:$safeName\nEND:VCARD';
  }

  Widget _buildPreviewSection(BuildContext context, AppLocalizations loc) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.size.width > mediaQuery.size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final themeDefaultCardBg = colorScheme.surfaceContainerLow;
    final themeOnSurface = colorScheme.onSurface;
    final bgColor = resolver != null
        ? resolver!.resolveBackgroundColor(config.backgroundColor)
        : (config.backgroundColor != null
            ? Color(config.backgroundColor!)
            : themeDefaultCardBg);
    final textColor = resolver != null
        ? resolver!.resolveTextColor(config.textColor)
        : (config.textColor != null
            ? Color(config.textColor!)
            : themeOnSurface);
    final sampleData = sampleVCardData ?? _defaultSampleVCard;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FormSectionTitle(title: loc.preview),
        ),
        const SizedBox(height: 12),
        Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final maxHeight = 260.0;

              if (isLandscape) {
                final qrSize = (maxHeight - 2 * _previewBorder)
                    .clamp(0.0, (maxWidth - 2 * _previewBorder - 15) / 2);
                final dataMinWidth = 100.0;
                final requiredWidth =
                    qrSize + 15 + dataMinWidth + 2 * _previewBorder;
                final containerWidth = requiredWidth.clamp(0.0, maxWidth);

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: containerWidth,
                    maxHeight: maxHeight,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(_previewBorder),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: qrSize,
                          height: qrSize,
                          child: QrAppearancePreviewWidget(
                            appearance: config.qrAppearance,
                            sampleData: sampleData,
                            centerImage: config.qrLogo,
                            size: qrSize - 2 * _previewBorder,
                            backgroundColor: bgColor,
                            border: _previewBorder,
                            primaryColorOverride: resolver?.resolveQrPrimaryColor(
                              config.qrAppearance.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                previewDisplayName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              if (previewSubtitle.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  previewSubtitle,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: textColor.withValues(alpha: 0.85),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final qrSize = (maxWidth - 2 * _previewBorder)
                  .clamp(0.0, maxHeight - 2 * _previewBorder - 50);
              final requiredWidth = qrSize + 2 * _previewBorder;
              final containerWidth = requiredWidth.clamp(0.0, maxWidth);

              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: containerWidth),
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: qrSize + 2 * _previewBorder,
                        width: double.infinity,
                        child: QrAppearancePreviewWidget(
                          appearance: config.qrAppearance,
                          sampleData: sampleData,
                          centerImage: config.qrLogo,
                          size: qrSize,
                          backgroundColor: bgColor,
                          border: _previewBorder,
                          primaryColorOverride: resolver?.resolveQrPrimaryColor(
                            config.qrAppearance.primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          _previewBorder,
                          12,
                          _previewBorder,
                          _previewBorder,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              previewDisplayName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            if (previewSubtitle.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                previewSubtitle,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textColor.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCardSection(BuildContext context, AppLocalizations loc) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeDefaultCardBg = colorScheme.surfaceContainerLow;
    final themeOnSurface = colorScheme.onSurface;
    final effectiveBgDefault =
        resolver?.defaultBackgroundColor ?? themeDefaultCardBg;
    final effectiveTextDefault =
        resolver?.defaultTextColor ?? themeOnSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FormSectionTitle(title: loc.card),
        ),
        const SizedBox(height: 12),
        _buildInlineColorPicker(
          context,
          loc,
          loc.backgroundColor,
          config.backgroundColor,
          themeDefaultCardBg,
          effectiveBgDefault,
          (value) => onChanged(config.copyWith(backgroundColor: value)),
        ),
        const SizedBox(height: 16),
        _buildInlineColorPicker(
          context,
          loc,
          loc.textColor,
          config.textColor,
          themeOnSurface,
          effectiveTextDefault,
          (value) => onChanged(config.copyWith(textColor: value)),
        ),
        if (showPhotoSection) ...[
          const SizedBox(height: 16),
          _buildImagePicker(
            context,
            loc,
            config.cardPhoto,
            loc.imageOrLogo,
            AppearanceImageKind.cardPhoto,
            (bytes) => onChanged(config.copyWith(cardPhoto: bytes)),
          ),
        ],
      ],
    );
  }

  Widget _buildQrSection(BuildContext context, AppLocalizations loc) {
    final themeOnSurface = Theme.of(context).colorScheme.onSurface;
    // When resolver present: use app default (settings or theme) for null.
    // When resolver null (settings screen): use theme for null.
    final effectiveQrDefault = resolver != null
        ? resolver!.resolveQrPrimaryColor(config.qrAppearance.primaryColor)
        : (config.qrAppearance.primaryColor != null
            ? Color(config.qrAppearance.primaryColor!)
            : themeOnSurface);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FormSectionTitle(title: loc.qrCodeStyle),
        ),
        const SizedBox(height: 12),
        // 1. Color (null = app default from settings or theme)
        _buildInlineColorPicker(
          context,
          loc,
          loc.color,
          config.qrAppearance.primaryColor,
          effectiveQrDefault,
          effectiveQrDefault,
          (value) => onChanged(config.copyWith(
            qrAppearance: config.qrAppearance.copyWith(
              primaryColor: value,
              gradient: null,
            ),
          )),
          allowNone: true,
        ),
        const SizedBox(height: 16),
        // 2. Background
        SwitchListTile(
          title: Text(loc.background, style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface)),
          subtitle: Text(loc.backgroundSubtitle),
          value: config.qrAppearance.backgroundColor != null,
          onChanged: (v) {
            onChanged(config.copyWith(
              qrAppearance: config.qrAppearance.copyWith(
                backgroundColor: v
                    ? (effectiveQrDefault.toARGB32() & 0x00FFFFFF | 0x10000000)
                    : null,
              ),
            ));
          },
        ),
        // 3. Quiet zone
        SwitchListTile(
          title: Text(loc.quietZone, style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface)),
          subtitle: Text(loc.quietZoneSubtitle),
          value: config.qrAppearance.quietZoneModules > 0,
          onChanged: (v) {
            onChanged(config.copyWith(
              qrAppearance: config.qrAppearance.copyWith(
                quietZoneModules: v ? 4.0 : 0,
              ),
            ));
          },
        ),
        const SizedBox(height: 12),
        // 4. Style (Smooth, Squares, Dots)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<QrShapeType>(
            key: ValueKey(config.qrAppearance.dataModuleShape),
            initialValue: config.qrAppearance.dataModuleShape,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize ?? 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              labelText: loc.style,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            ),
            items: [
              DropdownMenuItem(value: QrShapeType.smooth, child: Text(loc.qrShapeSmooth)),
              DropdownMenuItem(value: QrShapeType.squares, child: Text(loc.qrShapeSquares)),
              DropdownMenuItem(value: QrShapeType.dots, child: Text(loc.qrShapeDots)),
            ],
            onChanged: (s) {
              if (s != null) {
                onChanged(config.copyWith(
                  qrAppearance: config.qrAppearance.copyWith(
                    dataModuleShape: s,
                    eyeShape: s,
                  ),
                ));
              }
            },
          ),
        ),
        const SizedBox(height: 12),
        // 5. Rounded corners (when supported)
        if (config.qrAppearance.dataModuleShape != QrShapeType.dots)
          SwitchListTile(
            title: Text(loc.roundedCorners, style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface)),
            subtitle: Text(loc.roundedCornersSubtitle),
            value: config.qrAppearance.dataModuleShape == QrShapeType.smooth
                ? config.qrAppearance.dataModuleRoundFactor > 0
                : config.qrAppearance.eyeShapeRounding > 0,
            onChanged: (v) {
              final qr = config.qrAppearance;
              final updated = qr.dataModuleShape == QrShapeType.smooth
                  ? qr.copyWith(dataModuleRoundFactor: v ? 1.0 : 0)
                  : qr.copyWith(eyeShapeRounding: v ? 0.5 : 0);
              onChanged(config.copyWith(qrAppearance: updated));
            },
          ),
        // 6. QR Center Image
        if (showPhotoSection) ...[
          const SizedBox(height: 16),
          _buildImagePicker(
            context,
            loc,
            config.qrLogo,
            loc.qrCenterImage,
            AppearanceImageKind.qrLogo,
            (bytes) => onChanged(config.copyWith(
              qrLogo: bytes,
              qrAppearance: config.qrAppearance.copyWith(
                centerLogoEnabled: bytes != null,
              ),
            )),
          ),
        ],
        // Position of image (only when image selected)
        if (config.qrLogo != null && showPhotoSection) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<PrettyQrDecorationImagePosition>(
              key: ValueKey(config.qrAppearance.imagePosition),
              initialValue: config.qrAppearance.imagePosition,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize ?? 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                labelText: loc.logoPosition,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              ),
              items: [
                DropdownMenuItem(
                  value: PrettyQrDecorationImagePosition.embedded,
                  child: Text(loc.embedded),
                ),
                DropdownMenuItem(
                  value: PrettyQrDecorationImagePosition.foreground,
                  child: Text(loc.foreground),
                ),
                DropdownMenuItem(
                  value: PrettyQrDecorationImagePosition.background,
                  child: Text(loc.background),
                ),
              ],
              onChanged: (p) {
                if (p != null) {
                  onChanged(config.copyWith(
                    qrAppearance: config.qrAppearance.copyWith(imagePosition: p),
                  ));
                }
              },
            ),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildFieldsColumn(BuildContext context, AppLocalizations loc, {required bool includePreview}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCardSection(context, loc),
        const SizedBox(height: 24),
        if (includePreview) ...[
          _buildPreviewSection(context, loc),
          const SizedBox(height: 24),
        ],
        _buildQrSection(context, loc),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    const padding = EdgeInsets.all(16);

    if (isLandscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width * 0.5),
            child: SingleChildScrollView(
              padding: padding,
              child: Center(
                child: _buildPreviewSection(context, loc),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: padding,
              child: _buildFieldsColumn(context, loc, includePreview: false),
            ),
          ),
        ],
      );
    }

    return ListView(
      padding: padding,
      children: [
        _buildCardSection(context, loc),
        const SizedBox(height: 24),
        _buildPreviewSection(context, loc),
        const SizedBox(height: 24),
        _buildQrSection(context, loc),
      ],
    );
  }

  Widget _buildColorSwatch(
    BuildContext context, {
    required Color displayColor,
    required bool isNone,
  }) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: displayColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          if (isNone)
            Positioned.fill(
              child: CustomPaint(
                painter: _DiagonalLinePainter(
                  color: Colors.red.shade400,
                  strokeWidth: 2,
                ),
                size: const Size(32, 32),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInlineColorPicker(
    BuildContext context,
    AppLocalizations loc,
    String label,
    int? currentValue,
    Color themeDefault,
    Color effectiveDefault,
    void Function(int?) onChanged, {
    bool allowNone = true,
  }) {
    final displayColor = currentValue != null
        ? Color(currentValue)
        : effectiveDefault;

    final textStyle = (Theme.of(context).textTheme.titleMedium ??
            const TextStyle(fontSize: 16))
        .copyWith(fontWeight: FontWeight.normal);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (allowNone) ...[
                TextButton(
                  onPressed: () => onChanged(null),
                  child: Text(loc.none),
                ),
                const SizedBox(width: 8),
              ],
              GestureDetector(
                onTap: () async {
                  final picked = await showAppColorPickerDialogWithConfirmation(
                    context,
                    displayColor,
                  );
                  if (picked != null) onChanged(picked.toARGB32());
                },
                child: _buildColorSwatch(
                  context,
                  displayColor: displayColor,
                  isNone: currentValue == null && allowNone,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(
    BuildContext context,
    AppLocalizations loc,
    Uint8List? currentBytes,
    String label,
    AppearanceImageKind imageKind,
    void Function(Uint8List?) onPicked,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ImagePickerButton(
              currentBytes: currentBytes,
              imageKind: imageKind,
              messageInputTooLarge: loc.appearanceImageInputTooLarge,
              messageDecodeFailed: loc.appearanceImageCouldNotProcess,
              onPicked: onPicked,
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            if (currentBytes != null)
              TextButton(
                onPressed: () => onPicked(null),
                child: Text(loc.remove),
              ),
          ],
        ),
      ),
    );
  }
}

class _ImagePickerButton extends StatefulWidget {
  const _ImagePickerButton({
    required this.currentBytes,
    required this.imageKind,
    required this.messageInputTooLarge,
    required this.messageDecodeFailed,
    required this.onPicked,
  });

  final Uint8List? currentBytes;
  final AppearanceImageKind imageKind;
  final String messageInputTooLarge;
  final String messageDecodeFailed;
  final void Function(Uint8List?) onPicked;

  @override
  State<_ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<_ImagePickerButton> {
  bool _isPicking = false;

  Future<void> _pickImage() async {
    if (_isPicking) return;
    setState(() => _isPicking = true);
    try {
      final picker = ImagePicker();
      final maxEdge =
          AppearanceImageNormalizer.maxEdgeFor(widget.imageKind).toDouble();
      final xFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxEdge,
        maxHeight: maxEdge,
        imageQuality: 90,
      );
      if (xFile != null) {
        final bytes = await xFile.readAsBytes();
        final result =
            AppearanceImageNormalizer.normalize(bytes, widget.imageKind);
        if (!mounted) return;
        if (result.isSuccess) {
          widget.onPicked(result.bytes);
        } else {
          final msg = result.error == AppearanceImageNormalizeError.inputTooLarge
              ? widget.messageInputTooLarge
              : widget.messageDecodeFailed;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _isPicking,
      child: GestureDetector(
        onTap: _pickImage,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              backgroundImage: widget.currentBytes != null
                  ? MemoryImage(widget.currentBytes!)
                  : null,
              child: widget.currentBytes == null
                  ? const Icon(Icons.add_a_photo, size: 32)
                  : null,
            ),
            if (_isPicking)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Paints a diagonal line from top-left to bottom-right to indicate "no color".
class _DiagonalLinePainter extends CustomPainter {
  _DiagonalLinePainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _DiagonalLinePainter oldDelegate) =>
      color != oldDelegate.color || strokeWidth != oldDelegate.strokeWidth;
}
