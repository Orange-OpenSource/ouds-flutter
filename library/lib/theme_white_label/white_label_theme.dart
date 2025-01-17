import 'package:flutter/material.dart';
import 'package:ouds_flutter/global-raw-tokens/colors.dart';
import 'package:ouds_flutter/global-raw-tokens/dimensions.dart';
import 'package:ouds_flutter/global-raw-tokens/spacings.dart';
import 'package:ouds_flutter/global-raw-tokens/typography.dart';
import 'package:ouds_flutter/theme_contract/ouds_theme_contract.dart';

class WhiteLabelTheme implements OudsThemeContract {
  @override
  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: TextTheme(
          bodyMedium: bodyTextStyle,
          headlineLarge: headlineTextStyle,
        ),
      );

  @override
  Color get primaryColor => RawColors.whitePrimary;

  @override
  // TODO: implement secondaryColor
  Color get secondaryColor => RawColors.whiteSecondary;

  @override
  Color get scaffoldBackgroundColor => RawColors.backgroundWhite;

  @override
  TextStyle get headlineTextStyle => RawTypography.headline1;

  @override
  double get buttonHeight => RawDimensions.buttonHeight;

  @override
  // TODO: implement backgroundColor
  Color get backgroundColor => throw UnimplementedError();

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
