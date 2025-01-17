import 'package:flutter/material.dart';
import 'package:ouds_flutter/global-raw-tokens/colors.dart';
import 'package:ouds_flutter/global-raw-tokens/dimensions.dart';
import 'package:ouds_flutter/global-raw-tokens/spacings.dart';
import 'package:ouds_flutter/global-raw-tokens/typography.dart';
import 'package:ouds_flutter/theme_contract/ouds_theme_contract.dart';

class OrangeTheme implements OudsThemeContract {
  @override
  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(
          bodyMedium: bodyTextStyle,
          headlineLarge: headlineTextStyle,
        ),
      );

  // Implémentation des couleurs
  @override
  // TODO: implement bodyTextStyle
  Color get primaryColor => RawColors.orangePrimary;

  @override
  // TODO: implement bodyTextStyle
  Color get secondaryColor => RawColors.orangeSecondary;

  @override
  // TODO: implement bodyTextStyle
  Color get backgroundColor => RawColors.backgroundOrange;

  // Implémentation des styles de texte
  @override
  // TODO: implement bodyTextStyle
  TextStyle get headlineTextStyle => RawTypography.headline1;

  // Implémentation des tokens pour les composants
  @override
  // TODO: implement bodyTextStyle
  double get buttonHeight => RawDimensions.buttonHeight;

  @override
  // TODO: implement bodyTextStyle
  TextStyle get bodyTextStyle => RawTypography.bodyText;

  @override
  // TODO: implement buttonBorderRadius
  double get buttonBorderRadius => RawDimensions.buttonRadius;

  @override
  // TODO: implement largeSpacing
  double get largeSpacing => RawSpacings.large;

  @override
  // TODO: implement mediumSpacing
  double get mediumSpacing => throw RawSpacings.medium;

  @override
  // TODO: implement smallSpacing
  double get smallSpacing => throw RawSpacings.small;
}
