/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_contract/ouds_tokens_provider.dart';
import 'package:ouds_theme_contract/theme/scheme/color/ouds_color_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_grid_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_size_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_space_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/typography/ouds_typography.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_checkbox_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/material/ouds_material_color_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_elevation_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_font_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_grid_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_opacity_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_size_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_space_semantic_tokens.dart';
import 'package:ouds_theme_white_label/material/white_label_material_color_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_border_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_elevation_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_font_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_grid_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_opacity_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_size_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_space_semantic_tokens.dart';

/// [WhiteLabelTheme] implements the [OudsThemeContract] and defines the theme for the "White label" version of the application.
/// This theme provides configurations for both light and dark modes, with customizable color schemes, typography,
/// and component styles, ensuring consistency across different platforms.
///
/// The class offers:
/// - Configurations for light and dark theme modes, with color schemes suited to the overall design.
/// - Typography settings and text styles aligned with the theme.
/// - Component and UI element tokens to ensure a consistent appearance throughout the app.
///
/// This theme is designed to be flexible and adaptable, supporting future changes or customizations while maintaining
/// a cohesive user experience across Android and iOS platforms.
///

class WhiteLabelTheme implements OudsThemeContract {
  WhiteLabelTheme();

  @override
  String get name => "White label";

  @override
  OudsMaterialColorTokens get materialColorTokens => WhiteLabelMaterialColorTokens();

  @override
  ThemeData get themeData => ThemeData(
        fontFamily: fontFamily,
        package: packageName,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: materialColorTokens.primaryLight,
          onPrimary: materialColorTokens.onPrimaryLight,
          primaryContainer: materialColorTokens.primaryContainerLight,
          onPrimaryContainer: materialColorTokens.onPrimaryContainerLight,
          primaryFixed: materialColorTokens.primaryFixedLight,
          primaryFixedDim: materialColorTokens.primaryFixedDimLight,
          onPrimaryFixed: materialColorTokens.onPrimaryFixedLight,
          onPrimaryFixedVariant: materialColorTokens.onPrimaryFixedVariantLight,
          secondary: materialColorTokens.secondaryLight,
          onSecondary: materialColorTokens.onSecondaryLight,
          secondaryContainer: materialColorTokens.secondaryContainerLight,
          onSecondaryContainer: materialColorTokens.onSecondaryContainerLight,
          secondaryFixed: materialColorTokens.secondaryFixedLight,
          secondaryFixedDim: materialColorTokens.secondaryFixedDimLight,
          onSecondaryFixed: materialColorTokens.onSecondaryFixedLight,
          onSecondaryFixedVariant: materialColorTokens.onSecondaryFixedVariantLight,
          tertiary: materialColorTokens.tertiaryLight,
          onTertiary: materialColorTokens.onTertiaryLight,
          tertiaryContainer: materialColorTokens.tertiaryContainerLight,
          onTertiaryContainer: materialColorTokens.onTertiaryContainerLight,
          tertiaryFixed: materialColorTokens.tertiaryFixedLight,
          tertiaryFixedDim: materialColorTokens.tertiaryFixedDimLight,
          onTertiaryFixed: materialColorTokens.onTertiaryFixedLight,
          onTertiaryFixedVariant: materialColorTokens.onTertiaryFixedVariantLight,
          error: materialColorTokens.errorLight,
          onError: materialColorTokens.onErrorLight,
          errorContainer: materialColorTokens.errorContainerLight,
          onErrorContainer: materialColorTokens.onErrorContainerLight,
          surface: materialColorTokens.surfaceLight,
          onSurface: materialColorTokens.onSurfaceLight,
          surfaceDim: materialColorTokens.surfaceDimLight,
          surfaceBright: materialColorTokens.surfaceBrightLight,
          surfaceContainerLowest: materialColorTokens.surfContainerLowestLight,
          surfaceContainerLow: materialColorTokens.surfContainerLowLight,
          surfaceContainer: materialColorTokens.surfContainerLight,
          surfaceContainerHigh: materialColorTokens.surfContainerHighLight,
          surfaceContainerHighest: materialColorTokens.surfContainerHighestLight,
          onSurfaceVariant: materialColorTokens.onSurfaceVariantLight,
          outline: materialColorTokens.outlineLight,
          outlineVariant: materialColorTokens.outlineVariantLight,
          inverseSurface: materialColorTokens.inverseSurfaceLight,
          onInverseSurface: materialColorTokens.onSurfaceLight,
          inversePrimary: materialColorTokens.inversePrimaryLight,
          surfaceTint: materialColorTokens.surfaceTintLight,
        ),
        scaffoldBackgroundColor: colorSemanticTokens.backgroundColorTokens.bgPrimaryLight,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: fontTokens.sizeBodyMediumMobile,
            fontWeight: fontTokens.weightBodyDefault,
            color: colorSemanticTokens.contentColorTokens.contentDefaultLight,
          ),
        ),
      );

  @override
  OudsColorSemanticTokens get colorSemanticTokens => WhiteLabelColorSemanticTokens();

  @override
  OudsOpacitySemanticTokens get opacityTokens => WhiteLabelOpacitySemanticTokens();

  @override
  OudsBorderSemanticTokens get borderTokens => WhiteLabelBorderSemanticTokens();

  @override
  OudsElevationSemanticTokens get elevationTokens => WhiteLabelElevationSemanticTokens();

  @override
  OudsSpaceSemanticTokens get spaceSemanticTokens => WhiteLabelSpaceSemanticTokens();

  @override
  OudsSizeSemanticTokens get sizeSemanticTokens => WhiteLabelSizeSemanticTokens();

  @override
  OudsGridSemanticTokens get gridSemanticTokens => WhiteLabelGridSemanticTokens();

  @override
  OudsFontSemanticTokens get fontTokens => WhiteLabelFontSemanticTokens();

  @override
  String get fontFamily => 'Oswald';

  @override
  String get packageName => 'ouds_theme_white_label';

  @override
  OudsColorScheme colorScheme(BuildContext context) {
    return OudsColorScheme.fromContext(context: context, colorTokens: colorSemanticTokens);
  }

  @override
  OudsSpaceScheme spaceScheme(BuildContext context) {
    return OudsSpaceScheme.fromContext(context: context, spaceTokens: spaceSemanticTokens);
  }

  @override
  OudsSizeScheme sizeScheme(BuildContext context) {
    return OudsSizeScheme.fromContext(context: context, sizeTokens: sizeSemanticTokens);
  }

  @override
  OudsGridScheme gridScheme(BuildContext context) {
    return OudsGridScheme.fromContext(context: context, gridTokens: gridSemanticTokens);
  }

  @override
  OudsTypography get typographyTokens => OudsTypography();
  @override
  OudsProvidersTokens providersTokens(BuildContext context) {
    return OudsProvidersTokens(
      colorScheme: colorScheme(context),
      opacityTokens: opacityTokens,
      borderTokens: borderTokens,
      elevationTokens: elevationTokens,
      spaceTokens: spaceSemanticTokens,
      spaceScheme: spaceScheme(context),
      sizeTokens: sizeSemanticTokens,
      fontTokens: fontTokens,
    );
  }

  @override
  OudsComponentsTokens componentsTokens(BuildContext context) {
    return OudsComponentsTokens(
      providersTokens: providersTokens(context),
      button: OudsButtonTokens(borderRadius: borderTokens.radiusPill, providersTokens: providersTokens(context)),
      checkbox: OudsCheckboxTokens(borderRadius: borderTokens.radiusMedium, providersTokens: providersTokens(context)),
    );
  }

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      fontFamily: fontFamily,
      package: packageName,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: materialColorTokens.primaryDark,
        onPrimary: materialColorTokens.onPrimaryDark,
        primaryContainer: materialColorTokens.primaryContainerDark,
        onPrimaryContainer: materialColorTokens.onPrimaryContainerDark,
        primaryFixed: materialColorTokens.primaryFixedDark,
        primaryFixedDim: materialColorTokens.primaryFixedDimDark,
        onPrimaryFixed: materialColorTokens.onPrimaryFixedDark,
        onPrimaryFixedVariant: materialColorTokens.onPrimaryFixedVariantDark,
        secondary: materialColorTokens.secondaryDark,
        onSecondary: materialColorTokens.onSecondaryDark,
        secondaryContainer: materialColorTokens.secondaryContainerDark,
        onSecondaryContainer: materialColorTokens.onSecondaryContainerDark,
        secondaryFixed: materialColorTokens.secondaryFixedDark,
        secondaryFixedDim: materialColorTokens.secondaryFixedDimDark,
        onSecondaryFixed: materialColorTokens.onSecondaryFixedDark,
        onSecondaryFixedVariant: materialColorTokens.onSecondaryFixedVariantDark,
        tertiary: materialColorTokens.tertiaryDark,
        onTertiary: materialColorTokens.onTertiaryDark,
        tertiaryContainer: materialColorTokens.tertiaryContainerDark,
        onTertiaryContainer: materialColorTokens.onTertiaryContainerDark,
        tertiaryFixed: materialColorTokens.tertiaryFixedDark,
        tertiaryFixedDim: materialColorTokens.tertiaryFixedDimDark,
        onTertiaryFixed: materialColorTokens.onTertiaryFixedDark,
        onTertiaryFixedVariant: materialColorTokens.onTertiaryFixedVariantDark,
        error: materialColorTokens.errorDark,
        onError: materialColorTokens.onErrorDark,
        errorContainer: materialColorTokens.errorContainerDark,
        onErrorContainer: materialColorTokens.onErrorContainerDark,
        surface: materialColorTokens.surfaceDark,
        onSurface: materialColorTokens.onSurfaceDark,
        surfaceDim: materialColorTokens.surfaceDimDark,
        surfaceBright: materialColorTokens.surfaceBrightDark,
        surfaceContainerLowest: materialColorTokens.surfContainerLowestDark,
        surfaceContainerLow: materialColorTokens.surfContainerLowDark,
        surfaceContainer: materialColorTokens.surfContainerDark,
        surfaceContainerHigh: materialColorTokens.surfContainerHighDark,
        surfaceContainerHighest: materialColorTokens.surfContainerHighestDark,
        onSurfaceVariant: materialColorTokens.onSurfaceVariantDark,
        outline: materialColorTokens.outlineDark,
        outlineVariant: materialColorTokens.outlineVariantDark,
        inverseSurface: materialColorTokens.inverseSurfaceDark,
        onInverseSurface: materialColorTokens.onSurfaceDark,
        inversePrimary: materialColorTokens.inversePrimaryDark,
        surfaceTint: materialColorTokens.surfaceTintDark,
      ),
      scaffoldBackgroundColor: colorSemanticTokens.backgroundColorTokens.bgPrimaryDark,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: fontTokens.sizeBodyMediumMobile,
          fontWeight: fontTokens.weightBodyDefault,
          color: colorSemanticTokens.contentColorTokens.contentDefaultDark,
        ),
      ),
    );
  }
}
