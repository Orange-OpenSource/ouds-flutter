import 'package:flutter/material.dart';
import 'package:ouds_flutter/global-raw-tokens/colors.dart';
import 'package:ouds_flutter/global-raw-tokens/dimensions.dart';
import 'package:ouds_flutter/global-raw-tokens/spacings.dart';
import 'package:ouds_flutter/global-raw-tokens/typography.dart';
import 'package:ouds_flutter/theme_contract/theme/ouds_theme_contract.dart';

class OrangeTheme implements OudsThemeContract {
  @override
  ThemeData get themeData => ThemeData(
        primaryColor: colorTokens.primaryColor,
        scaffoldBackgroundColor: colorTokens.backgroundColor,
        textTheme: TextTheme(
          bodyMedium: fontTokens.bodyTextStyle,
          headlineLarge: fontTokens.headlineTextStyle,
        ),
      );

  // Implémentation des couleurs (directement dans la classe)
  @override
  ColorTokens get colorTokens => _ColorTokens();

  // Implémentation des styles de texte
  @override
  FontTokens get fontTokens => _FontTokens();

  // Implémentation des tokens pour les composants
  @override
  SizeTokens get sizeTokens => _SizeTokens();

  @override
  BorderTokens get borderTokens => _BorderTokens();

  @override
  ElevationTokens get elevationTokens => _ElevationTokens();

  @override
  GridTokens get gridTokens => _GridTokens();

  @override
  OpacityTokens get opacityTokens => _OpacityTokens();

  @override
  SpaceTokens get spaceTokens => _SpaceTokens();

  @override
  ComponentsTokens get componentsTokens => _ComponentsTokens();

  @override
  String get name => "OrangeTheme";
}

class _ColorTokens implements ColorTokens {
  @override
  Color get primaryColor => RawColors.orangePrimary;

  @override
  Color get secondaryColor => RawColors.orangeSecondary;

  @override
  Color get backgroundColor => RawColors.backgroundOrange;
}

class _FontTokens implements FontTokens {
  @override
  TextStyle get headlineTextStyle => RawTypography.headline1;

  @override
  TextStyle get bodyTextStyle => RawTypography.bodyText;
}

class _SizeTokens implements SizeTokens {
  @override
  double get buttonHeight => RawDimensions.buttonHeight;

  @override
  double get inputFieldHeight => RawDimensions.inputFieldHeight;
}

class _BorderTokens implements BorderTokens {
  @override
  double get borderRadius => RawDimensions.buttonRadius;
}

class _ElevationTokens implements ElevationTokens {
  @override
  double get cardElevation => 4.0;

  @override
  double get buttonElevation => 2.0;
}

class _GridTokens implements GridTokens {
  @override
  double get gridSize => RawDimensions.gridSize;

  @override
  double get gutterSize => RawDimensions.gutterSize;
}

class _OpacityTokens implements OpacityTokens {
  @override
  double get primaryOpacity => 0.8;

  @override
  double get secondaryOpacity => 0.6;
}

class _SpaceTokens implements SpaceTokens {
  @override
  double get smallSpacing => RawSpacings.small;

  @override
  double get mediumSpacing => RawSpacings.medium;

  @override
  double get largeSpacing => RawSpacings.large;
}

class _ComponentsTokens implements ComponentsTokens {
  @override
  double get buttonHeight => RawDimensions.buttonHeight;

  @override
  double get buttonBorderRadius => RawDimensions.buttonRadius;
}
