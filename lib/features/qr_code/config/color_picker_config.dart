// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Centralized configuration for the flex_color_picker dialog used in the
/// appearance editor. All customizable options are defined here for easy
/// tweaking and future internationalization.
///
/// When adding i18n, replace the label strings with lookups such as
/// `AppLocalizations.of(context)!.colorPickerTitle`.
class ColorPickerConfig {
  ColorPickerConfig._();

  // ─────────────────────────────────────────────────────────────────────────
  // LABELS (i18n-ready: replace with l10n lookups when available)
  // ─────────────────────────────────────────────────────────────────────────

  /// Labels for the picker type tabs (wheel, primary, accent, etc.).
  static const Map<ColorPickerType, String> pickerTypeLabels = {
    ColorPickerType.both: 'Palette',
    ColorPickerType.primary: 'Primary',
    ColorPickerType.accent: 'Accent',
    ColorPickerType.bw: 'B & W',
    ColorPickerType.custom: 'Custom',
    ColorPickerType.customSecondary: 'Options',
    ColorPickerType.wheel: 'Wheel',
  };

  /// Dialog title shown in the toolbar. Set to empty string to hide (saves space).
  static const String titleLabel = '';

  /// Main heading below the toolbar. Set to empty string to hide (saves space).
  static const String headingLabel = '';

  /// Subheading for Material/primary/accent shade selection.
  /// Empty = hidden (saves space).
  static const String subheadingLabel = 'Color shade';

  /// Subheading for Material 3 tonal palette. Empty = hidden (saves space).
  static const String tonalSubheadingLabel = 'Material 3 tonal palette';

  /// Subheading for the HSV wheel picker. Empty = hidden (saves space).
  static const String wheelSubheadingLabel =
      'Selected color and its shades';

  /// Subheading for the opacity slider. Empty = hidden (saves space).
  static const String opacitySubheadingLabel = 'Opacity';

  /// Subheading for recently used colors. Empty = hidden (saves space).
  static const String recentColorsSubheadingLabel = 'Recent colors';

  // ─────────────────────────────────────────────────────────────────────────
  // PICKER TYPES
  // ─────────────────────────────────────────────────────────────────────────

  /// Which picker types are enabled. Set to false to hide a tab.
  static const Map<ColorPickerType, bool> pickersEnabled = {
    ColorPickerType.both: true,
    ColorPickerType.primary: false,
    ColorPickerType.accent: false,
    ColorPickerType.bw: true,
    ColorPickerType.custom: false,
    ColorPickerType.customSecondary: false,
    ColorPickerType.wheel: true,
  };

  // ─────────────────────────────────────────────────────────────────────────
  // CUSTOM COLOR SWATCHES
  // ─────────────────────────────────────────────────────────────────────────

  /// Custom color swatches for the Custom picker tab. Add brand or QR-friendly
  /// colors here. Empty by default; if empty and custom is enabled, the tab
  /// will not show.
  static Map<ColorSwatch<Object>, String> get customColorSwatchesAndNames =>
      _customColorSwatches;

  static final Map<ColorSwatch<Object>, String> _customColorSwatches = {
    ColorTools.createPrimarySwatch(const Color(0xFF1a1a2e)): 'Dark navy',
    ColorTools.createPrimarySwatch(const Color(0xFF16213e)): 'Navy',
    ColorTools.createPrimarySwatch(const Color(0xFF0f3460)): 'Blue grey',
    ColorTools.createPrimarySwatch(const Color(0xFFe94560)): 'Accent red',
    ColorTools.createPrimarySwatch(const Color(0xFF533483)): 'Purple',
  };

  // ─────────────────────────────────────────────────────────────────────────
  // COLOR ITEM DESIGN (swatch boxes)
  // ─────────────────────────────────────────────────────────────────────────

  static const double colorItemWidth = 36.0;
  static const double colorItemHeight = 36.0;
  static const double colorItemBorderRadius = 8.0;
  static const double colorItemSpacing = 4.0;
  static const double colorItemRunSpacing = 4.0;
  static const double colorItemElevation = 0.0;
  static const bool colorItemHasBorder = false;

  // ─────────────────────────────────────────────────────────────────────────
  // WHEEL PICKER
  // ─────────────────────────────────────────────────────────────────────────

  static const double wheelDiameter = 180.0;
  static const double wheelWidth = 16.0;
  static const bool wheelHasBorder = false;
  static const double wheelSquarePadding = 0.0;
  static const double wheelSquareBorderRadius = 4.0;

  // ─────────────────────────────────────────────────────────────────────────
  // OPACITY SLIDER
  // ─────────────────────────────────────────────────────────────────────────

  static const bool enableOpacity = false;
  static const double opacityTrackHeight = 36.0;
  static const double? opacityTrackWidth = null; // null = fill available width
  static const double opacityThumbRadius = 16.0;

  // ─────────────────────────────────────────────────────────────────────────
  // PICKER TYPE TABS (segmented control)
  // ─────────────────────────────────────────────────────────────────────────

  /// Text style for the picker type tab labels (Primary, Accent, Wheel, etc.).
  /// Use a larger font size and line height so full labels are visible.
  static TextStyle pickerTypeTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall?.copyWith(
            height: 1.3,
          ) ??
      const TextStyle(fontSize: 14, height: 1.3);

  // ─────────────────────────────────────────────────────────────────────────
  // LAYOUT
  // ─────────────────────────────────────────────────────────────────────────

  static const CrossAxisAlignment crossAxisAlignment =
      CrossAxisAlignment.center;
  static const EdgeInsets padding = EdgeInsets.all(16);
  static const double columnSpacing = 8.0;
  static const double? toolbarSpacing = null;
  static const double? shadesSpacing = null;

  // ─────────────────────────────────────────────────────────────────────────
  // DISPLAY OPTIONS
  // ─────────────────────────────────────────────────────────────────────────

  static const bool enableShadesSelection = true;
  static const bool includeIndex850 = true;
  static const bool enableTonalPalette = true;
  static const bool tonalPaletteFixedMinChroma = false;
  static const bool tonalColorSameSize = false;

  static const bool showMaterialName = false;
  static const bool showColorName = false;
  static const bool showColorCode = true;
  static const bool colorCodeHasColor = true;
  static const bool showEditIconButton = true;
  static const bool focusedEditHasNoColor = false;
  static const bool colorCodeReadOnly = false;
  static const bool showColorValue = false;

  static const bool showRecentColors = false;
  static const int maxRecentColors = 5;
  static const List<Color> recentColors = [];

  static const bool enableTooltips = true;

  // ─────────────────────────────────────────────────────────────────────────
  // COPY-PASTE BEHAVIOR
  // ─────────────────────────────────────────────────────────────────────────

  static const ColorPickerCopyPasteBehavior copyPasteBehavior =
      ColorPickerCopyPasteBehavior(
    copyButton: false,
    pasteButton: false,
    longPressMenu: false,
  );

  // ─────────────────────────────────────────────────────────────────────────
  // ACTION BUTTONS (OK / Cancel)
  // ─────────────────────────────────────────────────────────────────────────

  static const ColorPickerActionButtons actionButtons =
      ColorPickerActionButtons(
    okButton: false,
    closeButton: false,
    dialogActionButtons: true,
  );

  // ─────────────────────────────────────────────────────────────────────────
  // DIALOG
  // ─────────────────────────────────────────────────────────────────────────

  /// Dialog size. Wider maxWidth gives more room for tab labels.
  static const BoxConstraints constraints = BoxConstraints(
    minHeight: 420,
    minWidth: 320,
    maxWidth: 360,
  );
  static const Color barrierColor = Colors.black12;
  static const double? dialogElevation = null;
}

Map<ColorPickerType, String> _pickerTypeLabels(AppLocalizations loc) => {
  ColorPickerType.both: loc.colorPickerPalette,
  ColorPickerType.primary: loc.colorPickerPrimary,
  ColorPickerType.accent: loc.colorPickerAccent,
  ColorPickerType.bw: loc.colorPickerBW,
  ColorPickerType.custom: loc.colorPickerCustom,
  ColorPickerType.customSecondary: loc.colorPickerOptions,
  ColorPickerType.wheel: loc.colorPickerWheel,
};

Map<ColorSwatch<Object>, String> _localizedCustomSwatches(AppLocalizations loc) {
  final src = ColorPickerConfig.customColorSwatchesAndNames;
  final nameMap = <String, String>{
    'Dark navy': loc.colorPickerDarkNavy,
    'Navy': loc.colorPickerNavy,
    'Blue grey': loc.colorPickerBlueGrey,
    'Accent red': loc.colorPickerAccentRed,
    'Purple': loc.colorPickerPurple,
  };
  return Map.fromEntries(
    src.entries.map((e) => MapEntry(e.key, nameMap[e.value] ?? e.value)),
  );
}

/// Shows the app's color picker dialog with all options from [ColorPickerConfig].
/// Returns the selected color when the user confirms (OK), or null when cancelled.
/// Use this when you need to distinguish cancel from confirm (e.g. do not apply
/// any change on cancel).
Future<Color?> showAppColorPickerDialogWithConfirmation(
  BuildContext context,
  Color color,
) async {
  final loc = AppLocalizations.of(context)!;
  final theme = Theme.of(context);
  Color selectedColor = color;
  final confirmed = await ColorPicker(
    color: color,
    onColorChanged: (Color newColor) {
      selectedColor = newColor;
    },
    pickersEnabled: ColorPickerConfig.pickersEnabled,
    enableShadesSelection: ColorPickerConfig.enableShadesSelection,
    includeIndex850: ColorPickerConfig.includeIndex850,
    enableTonalPalette: ColorPickerConfig.enableTonalPalette,
    tonalPaletteFixedMinChroma: ColorPickerConfig.tonalPaletteFixedMinChroma,
    crossAxisAlignment: ColorPickerConfig.crossAxisAlignment,
    padding: ColorPickerConfig.padding,
    columnSpacing: ColorPickerConfig.columnSpacing,
    toolbarSpacing: ColorPickerConfig.toolbarSpacing,
    shadesSpacing: ColorPickerConfig.shadesSpacing,
    enableOpacity: ColorPickerConfig.enableOpacity,
    opacityTrackHeight: ColorPickerConfig.opacityTrackHeight,
    opacityTrackWidth: ColorPickerConfig.opacityTrackWidth,
    opacityThumbRadius: ColorPickerConfig.opacityThumbRadius,
    actionButtons: ColorPickerConfig.actionButtons,
    copyPasteBehavior: ColorPickerConfig.copyPasteBehavior,
    width: ColorPickerConfig.colorItemWidth,
    height: ColorPickerConfig.colorItemHeight,
    spacing: ColorPickerConfig.colorItemSpacing,
    runSpacing: ColorPickerConfig.colorItemRunSpacing,
    tonalColorSameSize: ColorPickerConfig.tonalColorSameSize,
    elevation: ColorPickerConfig.colorItemElevation,
    hasBorder: ColorPickerConfig.colorItemHasBorder,
    borderRadius: ColorPickerConfig.colorItemBorderRadius,
    wheelDiameter: ColorPickerConfig.wheelDiameter,
    wheelWidth: ColorPickerConfig.wheelWidth,
    wheelSquarePadding: ColorPickerConfig.wheelSquarePadding,
    wheelSquareBorderRadius: ColorPickerConfig.wheelSquareBorderRadius,
    wheelHasBorder: ColorPickerConfig.wheelHasBorder,
    title: null,
    heading: null,
    subheading: Text(
      loc.colorPickerColorShade,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    tonalSubheading: Text(
      loc.colorPickerTonalPalette,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    wheelSubheading: Text(
      loc.colorPickerSelectedColorShades,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    opacitySubheading: Text(
      loc.colorPickerOpacity,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    recentColorsSubheading: Text(
      loc.colorPickerRecentColors,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    pickerTypeLabels: _pickerTypeLabels(loc),
    pickerTypeTextStyle: ColorPickerConfig.pickerTypeTextStyle(context),
    customColorSwatchesAndNames: _localizedCustomSwatches(loc),
    customSecondaryColorSwatchesAndNames: _localizedCustomSwatches(loc),
    showMaterialName: ColorPickerConfig.showMaterialName,
    showColorName: ColorPickerConfig.showColorName,
    showColorCode: ColorPickerConfig.showColorCode,
    colorCodeHasColor: ColorPickerConfig.colorCodeHasColor,
    showEditIconButton: ColorPickerConfig.showEditIconButton,
    focusedEditHasNoColor: ColorPickerConfig.focusedEditHasNoColor,
    colorCodeReadOnly: ColorPickerConfig.colorCodeReadOnly,
    showColorValue: ColorPickerConfig.showColorValue,
    showRecentColors: ColorPickerConfig.showRecentColors,
    maxRecentColors: ColorPickerConfig.maxRecentColors,
    recentColors: ColorPickerConfig.recentColors,
    enableTooltips: ColorPickerConfig.enableTooltips,
  ).showPickerDialog(
    context,
    title: null,
    contentPadding: ColorPickerConfig.padding,
    backgroundColor: null,
    constraints: ColorPickerConfig.constraints,
    barrierColor: ColorPickerConfig.barrierColor,
    elevation: ColorPickerConfig.dialogElevation,
  );
  return confirmed ? selectedColor : null;
}

/// Shows the app's color picker dialog with all options from [ColorPickerConfig].
/// Returns the selected color, or the original color if the user cancels.
Future<Color> showAppColorPickerDialog(
  BuildContext context,
  Color color,
) {
  final loc = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  return showColorPickerDialog(
    context,
    color,
    // Labels (i18n: replace with l10n lookups). Pass null when empty to hide.
    title: null,
    heading: null,
    subheading: Text(
      loc.colorPickerColorShade,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    tonalSubheading: Text(
      loc.colorPickerTonalPalette,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    wheelSubheading: Text(
      loc.colorPickerSelectedColorShades,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    opacitySubheading: Text(
      loc.colorPickerOpacity,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    recentColorsSubheading: Text(
      loc.colorPickerRecentColors,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    pickerTypeLabels: _pickerTypeLabels(loc),
    pickerTypeTextStyle: ColorPickerConfig.pickerTypeTextStyle(context),
    // Picker types
    pickersEnabled: ColorPickerConfig.pickersEnabled,
    // Custom swatches
    customColorSwatchesAndNames: _localizedCustomSwatches(loc),
    // Color item design
    width: ColorPickerConfig.colorItemWidth,
    height: ColorPickerConfig.colorItemHeight,
    borderRadius: ColorPickerConfig.colorItemBorderRadius,
    spacing: ColorPickerConfig.colorItemSpacing,
    runSpacing: ColorPickerConfig.colorItemRunSpacing,
    elevation: ColorPickerConfig.colorItemElevation,
    hasBorder: ColorPickerConfig.colorItemHasBorder,
    // Wheel
    wheelDiameter: ColorPickerConfig.wheelDiameter,
    wheelWidth: ColorPickerConfig.wheelWidth,
    wheelHasBorder: ColorPickerConfig.wheelHasBorder,
    wheelSquarePadding: ColorPickerConfig.wheelSquarePadding,
    wheelSquareBorderRadius: ColorPickerConfig.wheelSquareBorderRadius,
    // Opacity
    enableOpacity: ColorPickerConfig.enableOpacity,
    opacityTrackHeight: ColorPickerConfig.opacityTrackHeight,
    opacityTrackWidth: ColorPickerConfig.opacityTrackWidth,
    opacityThumbRadius: ColorPickerConfig.opacityThumbRadius,
    // Layout
    crossAxisAlignment: ColorPickerConfig.crossAxisAlignment,
    padding: ColorPickerConfig.padding,
    columnSpacing: ColorPickerConfig.columnSpacing,
    toolbarSpacing: ColorPickerConfig.toolbarSpacing,
    shadesSpacing: ColorPickerConfig.shadesSpacing,
    // Display
    enableShadesSelection: ColorPickerConfig.enableShadesSelection,
    includeIndex850: ColorPickerConfig.includeIndex850,
    enableTonalPalette: ColorPickerConfig.enableTonalPalette,
    tonalPaletteFixedMinChroma: ColorPickerConfig.tonalPaletteFixedMinChroma,
    tonalColorSameSize: ColorPickerConfig.tonalColorSameSize,
    showMaterialName: ColorPickerConfig.showMaterialName,
    showColorName: ColorPickerConfig.showColorName,
    showColorCode: ColorPickerConfig.showColorCode,
    colorCodeHasColor: ColorPickerConfig.colorCodeHasColor,
    showEditIconButton: ColorPickerConfig.showEditIconButton,
    focusedEditHasNoColor: ColorPickerConfig.focusedEditHasNoColor,
    colorCodeReadOnly: ColorPickerConfig.colorCodeReadOnly,
    showColorValue: ColorPickerConfig.showColorValue,
    showRecentColors: ColorPickerConfig.showRecentColors,
    maxRecentColors: ColorPickerConfig.maxRecentColors,
    recentColors: ColorPickerConfig.recentColors,
    enableTooltips: ColorPickerConfig.enableTooltips,
    // Copy-paste & actions
    copyPasteBehavior: ColorPickerConfig.copyPasteBehavior,
    actionButtons: ColorPickerConfig.actionButtons,
    // Dialog
    constraints: ColorPickerConfig.constraints,
    barrierColor: ColorPickerConfig.barrierColor,
    dialogElevation: ColorPickerConfig.dialogElevation,
  );
}
