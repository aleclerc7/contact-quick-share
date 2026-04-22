// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// This is the single source of truth for QR styling (used by Business Cards
/// Design tab and Settings > Default QR Code Style).
///
/// All properties are JSON-serializable for storage. Use [toPrettyQrDecoration]
/// to convert to pretty_qr_code's [PrettyQrDecoration] for rendering.
class QrAppearance {
  const QrAppearance({
    this.primaryColor,
    this.backgroundColor,
    this.eyeShape = QrShapeType.smooth,
    this.dataModuleShape = QrShapeType.smooth,
    this.dataModuleRoundFactor = 1.0,
    this.eyeShapeDensity = 1.0,
    this.eyeShapeRounding = 0.0,
    this.eyeShapeUnifiedFinder = true,
    this.quietZoneModules = 0,
    this.gradient,
    this.centerLogoEnabled = false,
    this.imagePosition = PrettyQrDecorationImagePosition.embedded,
  });

  /// Primary color for QR modules (ARGB). Null = automatic (black on light
  /// background, white on dark background).
  final int? primaryColor;

  /// Background color (ARGB). Null = transparent.
  final int? backgroundColor;

  /// Shape for finder pattern (eye corners).
  final QrShapeType eyeShape;

  /// Shape for data modules.
  final QrShapeType dataModuleShape;

  /// Round factor for smooth data modules (0.0–1.0).
  final double dataModuleRoundFactor;

  /// Density for dots/squares eye shape (0.0–1.0).
  final double eyeShapeDensity;

  /// Rounding for squares eye shape (0.0–1.0).
  final double eyeShapeRounding;

  /// Unified finder pattern for dots/squares.
  final bool eyeShapeUnifiedFinder;

  /// Quiet zone width in modules.
  final double quietZoneModules;

  /// Optional gradient. When set, overrides primaryColor for fill.
  final QrGradientConfig? gradient;

  /// Whether to show center logo (image provided separately when rendering).
  final bool centerLogoEnabled;

  /// Position of the center logo relative to QR modules.
  final PrettyQrDecorationImagePosition imagePosition;

  /// The actual color used for the QR background when [backgroundColor] is set.
  /// Null when no background fill is used (transparent).
  Color? get effectiveQrBackgroundColor =>
      backgroundColor != null ? Color(backgroundColor!) : null;

  /// Resolves primary color: explicit value or automatic contrast against
  /// [backgroundForContrast]. When null, returns black on light backgrounds,
  /// white on dark backgrounds.
  static Color resolvePrimaryColor(int? value, Color backgroundForContrast) {
    if (value != null) return Color(value);
    return backgroundForContrast.computeLuminance() > 0.5
        ? const Color(0xFF000000)
        : const Color(0xFFFFFFFF);
  }

  factory QrAppearance.defaultAppearance() => const QrAppearance();

  factory QrAppearance.fromJson(Map<String, dynamic> json) {
    return QrAppearance(
      primaryColor: json['primaryColor'] as int?,
      backgroundColor: json['backgroundColor'] as int?,
      eyeShape: QrShapeType.fromJson(json['eyeShape'] as String?),
      dataModuleShape: QrShapeType.fromJson(json['dataModuleShape'] as String?),
      dataModuleRoundFactor:
          (json['dataModuleRoundFactor'] as num?)?.toDouble() ?? 1.0,
      eyeShapeDensity: (json['eyeShapeDensity'] as num?)?.toDouble() ?? 1.0,
      eyeShapeRounding: (json['eyeShapeRounding'] as num?)?.toDouble() ?? 0.0,
      eyeShapeUnifiedFinder:
          json['eyeShapeUnifiedFinder'] as bool? ?? true,
      quietZoneModules: (json['quietZoneModules'] as num?)?.toDouble() ?? 0,
      gradient: json['gradient'] != null
          ? QrGradientConfig.fromJson(
              json['gradient'] as Map<String, dynamic>,
            )
          : null,
      centerLogoEnabled: json['centerLogoEnabled'] as bool? ?? false,
      imagePosition: _imagePositionFromJson(json['imagePosition'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
        'primaryColor': primaryColor,
        'backgroundColor': backgroundColor,
        'eyeShape': eyeShape.toJson(),
        'dataModuleShape': dataModuleShape.toJson(),
        'dataModuleRoundFactor': dataModuleRoundFactor,
        'eyeShapeDensity': eyeShapeDensity,
        'eyeShapeRounding': eyeShapeRounding,
        'eyeShapeUnifiedFinder': eyeShapeUnifiedFinder,
        'quietZoneModules': quietZoneModules,
        if (gradient != null) 'gradient': gradient!.toJson(),
        'centerLogoEnabled': centerLogoEnabled,
        'imagePosition': imagePosition.name,
      };

  static PrettyQrDecorationImagePosition _imagePositionFromJson(String? value) {
    switch (value) {
      case 'foreground':
        return PrettyQrDecorationImagePosition.foreground;
      case 'background':
        return PrettyQrDecorationImagePosition.background;
      default:
        return PrettyQrDecorationImagePosition.embedded;
    }
  }

  static const _undefined = Object();

  QrAppearance copyWith({
    Object? primaryColor = _undefined,
    Object? backgroundColor = _undefined,
    QrShapeType? eyeShape,
    QrShapeType? dataModuleShape,
    double? dataModuleRoundFactor,
    double? eyeShapeDensity,
    double? eyeShapeRounding,
    bool? eyeShapeUnifiedFinder,
    double? quietZoneModules,
    QrGradientConfig? gradient,
    bool? centerLogoEnabled,
    PrettyQrDecorationImagePosition? imagePosition,
  }) {
    return QrAppearance(
      primaryColor: identical(primaryColor, _undefined)
          ? this.primaryColor
          : primaryColor as int?,
      backgroundColor: identical(backgroundColor, _undefined)
          ? this.backgroundColor
          : backgroundColor as int?,
      eyeShape: eyeShape ?? this.eyeShape,
      dataModuleShape: dataModuleShape ?? this.dataModuleShape,
      dataModuleRoundFactor:
          dataModuleRoundFactor ?? this.dataModuleRoundFactor,
      eyeShapeDensity: eyeShapeDensity ?? this.eyeShapeDensity,
      eyeShapeRounding: eyeShapeRounding ?? this.eyeShapeRounding,
      eyeShapeUnifiedFinder:
          eyeShapeUnifiedFinder ?? this.eyeShapeUnifiedFinder,
      quietZoneModules: quietZoneModules ?? this.quietZoneModules,
      gradient: gradient ?? this.gradient,
      centerLogoEnabled: centerLogoEnabled ?? this.centerLogoEnabled,
      imagePosition: imagePosition ?? this.imagePosition,
    );
  }

  /// Converts to [PrettyQrDecoration] for rendering with pretty_qr_code.
  /// Pass [centerImage] when [centerLogoEnabled] is true (e.g. qr_logo from
  /// business card). Pass [backgroundForContrast] for automatic color when
  /// [primaryColor] is null and [primaryColorOverride] is not provided.
  /// When [primaryColorOverride] is non-null, it is used instead of resolving
  /// from [primaryColor] (e.g. from DefaultAppearanceResolver).
  PrettyQrDecoration toPrettyQrDecoration({
    ImageProvider? centerImage,
    required Color backgroundForContrast,
    Color? primaryColorOverride,
  }) {
    final resolvedColor = primaryColorOverride ??
        resolvePrimaryColor(primaryColor, backgroundForContrast);
    final brush = gradient != null
        ? PrettyQrBrush.gradient(gradient: gradient!.toGradient())
        : PrettyQrBrush.solid(resolvedColor.toARGB32());

    final dataShape = _buildShape(dataModuleShape, brush, dataModuleRoundFactor,
        eyeShapeDensity, eyeShapeRounding, eyeShapeUnifiedFinder);

    PrettyQrShape shape;
    if (eyeShape == dataModuleShape) {
      shape = dataShape;
    } else {
      final eyeShapeObj = _buildShape(eyeShape, brush, dataModuleRoundFactor,
          eyeShapeDensity, eyeShapeRounding, eyeShapeUnifiedFinder);
      // ignore: experimental_member_use - PrettyQrShape.custom
      shape = PrettyQrShape.custom(
        dataShape,
        finderPattern: eyeShapeObj,
      );
    }

    return PrettyQrDecoration(
      shape: shape,
      background: backgroundColor != null ? Color(backgroundColor!) : null,
      quietZone: quietZoneModules > 0
          ? PrettyQrQuietZone.modules(quietZoneModules)
          : PrettyQrQuietZone.zero,
      image: centerLogoEnabled && centerImage != null
          ? PrettyQrDecorationImage(
              image: centerImage,
              scale: 0.2,
              position: imagePosition,
            )
          : null,
    );
  }

  PrettyQrShape _buildShape(
    QrShapeType type,
    Color colorOrBrush,
    double roundFactor,
    double density,
    double rounding,
    bool unifiedFinder,
  ) {
    final brush = PrettyQrBrush.from(colorOrBrush);
    switch (type) {
      case QrShapeType.smooth:
        return PrettyQrSmoothSymbol(color: brush, roundFactor: roundFactor);
      case QrShapeType.dots:
        return PrettyQrDotsSymbol(
          color: brush,
          density: density,
          unifiedFinderPattern: unifiedFinder,
          unifiedAlignmentPatterns: unifiedFinder,
        );
      case QrShapeType.squares:
        return PrettyQrSquaresSymbol(
          color: brush,
          density: density,
          rounding: rounding,
          unifiedFinderPattern: unifiedFinder,
        );
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrAppearance &&
          runtimeType == other.runtimeType &&
          primaryColor == other.primaryColor &&
          backgroundColor == other.backgroundColor &&
          eyeShape == other.eyeShape &&
          dataModuleShape == other.dataModuleShape &&
          dataModuleRoundFactor == other.dataModuleRoundFactor &&
          eyeShapeDensity == other.eyeShapeDensity &&
          eyeShapeRounding == other.eyeShapeRounding &&
          eyeShapeUnifiedFinder == other.eyeShapeUnifiedFinder &&
          quietZoneModules == other.quietZoneModules &&
          gradient == other.gradient &&
          centerLogoEnabled == other.centerLogoEnabled &&
          imagePosition == other.imagePosition;

  @override
  int get hashCode => Object.hash(
        primaryColor,
        backgroundColor,
        eyeShape,
        dataModuleShape,
        dataModuleRoundFactor,
        eyeShapeDensity,
        eyeShapeRounding,
        eyeShapeUnifiedFinder,
        quietZoneModules,
        gradient,
        centerLogoEnabled,
        imagePosition,
      );
}

enum QrShapeType {
  smooth,
  dots,
  squares;

  static QrShapeType fromJson(String? value) {
    switch (value) {
      case 'dots':
        return QrShapeType.dots;
      case 'squares':
        return QrShapeType.squares;
      default:
        return QrShapeType.smooth;
    }
  }

  String toJson() => name;
}

class QrGradientConfig {
  const QrGradientConfig({
    required this.startColor,
    required this.endColor,
    this.type = QrGradientType.linear,
  });

  final int startColor;
  final int endColor;
  final QrGradientType type;

  factory QrGradientConfig.fromJson(Map<String, dynamic> json) {
    return QrGradientConfig(
      startColor: json['startColor'] as int,
      endColor: json['endColor'] as int,
      type: QrGradientType.fromJson(json['type'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
        'startColor': startColor,
        'endColor': endColor,
        'type': type.toJson(),
      };

  Gradient toGradient() {
    final start = Color(startColor);
    final end = Color(endColor);
    switch (type) {
      case QrGradientType.linear:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [start, end],
        );
      case QrGradientType.radial:
        return RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [start, end],
        );
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrGradientConfig &&
          runtimeType == other.runtimeType &&
          startColor == other.startColor &&
          endColor == other.endColor &&
          type == other.type;

  @override
  int get hashCode => Object.hash(startColor, endColor, type);
}

enum QrGradientType {
  linear,
  radial;

  static QrGradientType fromJson(String? value) {
    return value == 'radial' ? QrGradientType.radial : QrGradientType.linear;
  }

  String toJson() => name;
}
