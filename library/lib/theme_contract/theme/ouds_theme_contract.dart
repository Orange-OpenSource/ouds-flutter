import 'package:flutter/material.dart';

/// Contract to create an OUDS-compliant theme.
///
/// Any values that are not defined will inherit from the default Orange theme.
abstract class OudsThemeContract {
  /// Theme display name.
  String get name;

  /// Color semantic tokens values used in the theme.
  ColorTokens get colorTokens;

  /// Border semantic tokens values used in the theme.
  BorderTokens get borderTokens;

  /// Elevation semantic tokens values used in the theme.
  ElevationTokens get elevationTokens;

  /// Font semantic tokens values used in the theme.
  FontTokens get fontTokens;

  /// Grid semantic tokens values used in the theme.
  GridTokens get gridTokens;

  /// Opacity semantic tokens values used in the theme.
  OpacityTokens get opacityTokens;

  /// Size semantic tokens values used in the theme.
  SizeTokens get sizeTokens;

  /// Space semantic tokens values used in the theme.
  SpaceTokens get spaceTokens;

  /// Customization of the OUDS components if needed.
  ComponentsTokens get componentsTokens;

  ThemeData get themeData => themeData;
}

/// Color semantic tokens used in the theme.
abstract class ColorTokens {
  Color get primaryColor;
  Color get secondaryColor;
  Color get backgroundColor;
}

/// Border semantic tokens used in the theme.
abstract class BorderTokens {
  double get borderRadius;
}

/// Elevation semantic tokens used in the theme.
abstract class ElevationTokens {
  double get cardElevation;
  double get buttonElevation;
}

/// Font semantic tokens used in the theme.
abstract class FontTokens {
  TextStyle get headlineTextStyle;
  TextStyle get bodyTextStyle;
}

/// Grid semantic tokens used in the theme.
abstract class GridTokens {
  double get gridSize;
  double get gutterSize;
}

/// Opacity semantic tokens used in the theme.
abstract class OpacityTokens {
  double get primaryOpacity;
  double get secondaryOpacity;
}

/// Size semantic tokens used in the theme.
abstract class SizeTokens {
  double get buttonHeight;
  double get inputFieldHeight;
}

/// Space semantic tokens used in the theme.
abstract class SpaceTokens {
  double get smallSpacing;
  double get mediumSpacing;
  double get largeSpacing;
}

/// Tokens for customizing specific OUDS components.
abstract class ComponentsTokens {
  double get buttonHeight;
  double get buttonBorderRadius;
}
