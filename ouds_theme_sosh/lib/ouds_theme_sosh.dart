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
import 'package:ouds_theme_sosh/components/sosh_badge_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_buttonMono_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_button_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_checkbox_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_chip_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_controlItem_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_divider_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_pinCodeInput_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_radioButton_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_skeleton_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_switch_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_tagInput_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_tag_tokens.dart';
import 'package:ouds_theme_sosh/components/sosh_textInput_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_border_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_elevation_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_font_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_grid_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_opacity_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_size_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_space_semantic_tokens.dart';

/// [SoshTheme] implements the [OudsThemeContract] and defines the theme for the "White label" version of the application.
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

class SoshTheme implements OudsThemeContract {
  SoshTheme();

  @override
  String get name => "Sosh";

  @override
  OudsMaterialColorTokens get materialColorTokens => OudsMaterialColorTokens();

  @override
  ThemeData get themeData => ThemeData(
        fontFamily: fontFamily,
        package: packageName,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: OudsMaterialColorTokens.primaryLight,
          onPrimary: OudsMaterialColorTokens.onPrimaryLight,
          primaryContainer: OudsMaterialColorTokens.primaryContainerLight,
          onPrimaryContainer: OudsMaterialColorTokens.onPrimaryContainerLight,
          primaryFixed: OudsMaterialColorTokens.primaryFixedLight,
          primaryFixedDim: OudsMaterialColorTokens.primaryFixedDimLight,
          onPrimaryFixed: OudsMaterialColorTokens.onPrimaryFixedLight,
          onPrimaryFixedVariant: OudsMaterialColorTokens.onPrimaryFixedVariantLight,
          secondary: OudsMaterialColorTokens.secondaryLight,
          onSecondary: OudsMaterialColorTokens.onSecondaryLight,
          secondaryContainer: OudsMaterialColorTokens.secondaryContainerLight,
          onSecondaryContainer: OudsMaterialColorTokens.onSecondaryContainerLight,
          secondaryFixed: OudsMaterialColorTokens.secondaryFixedLight,
          secondaryFixedDim: OudsMaterialColorTokens.secondaryFixedDimLight,
          onSecondaryFixed: OudsMaterialColorTokens.onSecondaryFixedLight,
          onSecondaryFixedVariant: OudsMaterialColorTokens.onSecondaryFixedVariantLight,
          tertiary: OudsMaterialColorTokens.tertiaryLight,
          onTertiary: OudsMaterialColorTokens.onTertiaryLight,
          tertiaryContainer: OudsMaterialColorTokens.tertiaryContainerLight,
          onTertiaryContainer: OudsMaterialColorTokens.onTertiaryContainerLight,
          tertiaryFixed: OudsMaterialColorTokens.tertiaryFixedLight,
          tertiaryFixedDim: OudsMaterialColorTokens.tertiaryFixedDimLight,
          onTertiaryFixed: OudsMaterialColorTokens.onTertiaryFixedLight,
          onTertiaryFixedVariant: OudsMaterialColorTokens.onTertiaryFixedVariantLight,
          error: OudsMaterialColorTokens.errorLight,
          onError: OudsMaterialColorTokens.onErrorLight,
          errorContainer: OudsMaterialColorTokens.errorContainerLight,
          onErrorContainer: OudsMaterialColorTokens.onErrorContainerLight,
          surface: OudsMaterialColorTokens.surfaceLight,
          onSurface: OudsMaterialColorTokens.onSurfaceLight,
          surfaceDim: OudsMaterialColorTokens.surfaceDimLight,
          surfaceBright: OudsMaterialColorTokens.surfaceBrightLight,
          surfaceContainerLowest: OudsMaterialColorTokens.surfContainerLowestLight,
          surfaceContainerLow: OudsMaterialColorTokens.surfContainerLowLight,
          surfaceContainer: OudsMaterialColorTokens.surfContainerLight,
          surfaceContainerHigh: OudsMaterialColorTokens.surfContainerHighLight,
          surfaceContainerHighest: OudsMaterialColorTokens.surfContainerHighestLight,
          onSurfaceVariant: OudsMaterialColorTokens.onSurfaceVariantLight,
          outline: OudsMaterialColorTokens.outlineLight,
          outlineVariant: OudsMaterialColorTokens.outlineVariantLight,
          inverseSurface: OudsMaterialColorTokens.inverseSurfaceLight,
          onInverseSurface: OudsMaterialColorTokens.onSurfaceLight,
          inversePrimary: OudsMaterialColorTokens.inversePrimaryLight,
          surfaceTint: OudsMaterialColorTokens.surfaceTintLight,
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
  OudsColorSemanticTokens get colorSemanticTokens => SoshColorSemanticTokens();

  @override
  OudsOpacitySemanticTokens get opacityTokens => SoshOpacitySemanticTokens();

  @override
  OudsBorderSemanticTokens get borderTokens => SoshBorderSemanticTokens();

  @override
  OudsElevationSemanticTokens get elevationTokens => SoshElevationSemanticTokens();

  @override
  OudsSpaceSemanticTokens get spaceSemanticTokens => SoshSpaceSemanticTokens();

  @override
  OudsSizeSemanticTokens get sizeSemanticTokens => SoshSizeSemanticTokens();

  @override
  OudsGridSemanticTokens get gridSemanticTokens => SoshGridSemanticTokens();

  @override
  OudsFontSemanticTokens get fontTokens => SoshFontSemanticTokens();

  @override
  String get fontFamily => 'Sosh';

  @override
  String get packageName => 'ouds_theme_sosh';

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
      button: SoshButtonTokens(
        providersTokens(context),
      ),
      buttonMono: SoshButtonMonoTokens(
        providersTokens(context),
      ),
      checkbox: SoshCheckboxTokens(
        providersTokens(context),
      ),
      controlItem: SoshControlItemTokens(
        providersTokens(context),
      ),
      radioButton: SoshRadioButtonTokens(
        providersTokens(context),
      ),
      divider: SoshDividerTokens(
        providersTokens(context),
      ),
      skeleton: SoshSkeletonTokens(
        providersTokens(context),
      ),
      switchButton: SoshSwitchTokens(
        providersTokens(context),
      ),
      chip: SoshChipTokens(
        providersTokens(context),
      ),
      badge: SoshBadgeTokens(
        providersTokens(context),
      ),
      tag: SoshTagTokens(
        providersTokens(context),
      ),
      tagInput: SoshTagInputTokens(
        providersTokens(context),
      ),
      textInput: SoshTextInputTokens(
        providersTokens(context),
      ),
      pinCodeInput: SoshPinCodeInputTokens(providersTokens(context)),
    );
  }

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      fontFamily: fontFamily,
      package: packageName,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: OudsMaterialColorTokens.primaryDark,
        onPrimary: OudsMaterialColorTokens.onPrimaryDark,
        primaryContainer: OudsMaterialColorTokens.primaryContainerDark,
        onPrimaryContainer: OudsMaterialColorTokens.onPrimaryContainerDark,
        primaryFixed: OudsMaterialColorTokens.primaryFixedDark,
        primaryFixedDim: OudsMaterialColorTokens.primaryFixedDimDark,
        onPrimaryFixed: OudsMaterialColorTokens.onPrimaryFixedDark,
        onPrimaryFixedVariant: OudsMaterialColorTokens.onPrimaryFixedVariantDark,
        secondary: OudsMaterialColorTokens.secondaryDark,
        onSecondary: OudsMaterialColorTokens.onSecondaryDark,
        secondaryContainer: OudsMaterialColorTokens.secondaryContainerDark,
        onSecondaryContainer: OudsMaterialColorTokens.onSecondaryContainerDark,
        secondaryFixed: OudsMaterialColorTokens.secondaryFixedDark,
        secondaryFixedDim: OudsMaterialColorTokens.secondaryFixedDimDark,
        onSecondaryFixed: OudsMaterialColorTokens.onSecondaryFixedDark,
        onSecondaryFixedVariant: OudsMaterialColorTokens.onSecondaryFixedVariantDark,
        tertiary: OudsMaterialColorTokens.tertiaryDark,
        onTertiary: OudsMaterialColorTokens.onTertiaryDark,
        tertiaryContainer: OudsMaterialColorTokens.tertiaryContainerDark,
        onTertiaryContainer: OudsMaterialColorTokens.onTertiaryContainerDark,
        tertiaryFixed: OudsMaterialColorTokens.tertiaryFixedDark,
        tertiaryFixedDim: OudsMaterialColorTokens.tertiaryFixedDimDark,
        onTertiaryFixed: OudsMaterialColorTokens.onTertiaryFixedDark,
        onTertiaryFixedVariant: OudsMaterialColorTokens.onTertiaryFixedVariantDark,
        error: OudsMaterialColorTokens.errorDark,
        onError: OudsMaterialColorTokens.onErrorDark,
        errorContainer: OudsMaterialColorTokens.errorContainerDark,
        onErrorContainer: OudsMaterialColorTokens.onErrorContainerDark,
        surface: OudsMaterialColorTokens.surfaceDark,
        onSurface: OudsMaterialColorTokens.onSurfaceDark,
        surfaceDim: OudsMaterialColorTokens.surfaceDimDark,
        surfaceBright: OudsMaterialColorTokens.surfaceBrightDark,
        surfaceContainerLowest: OudsMaterialColorTokens.surfContainerLowestDark,
        surfaceContainerLow: OudsMaterialColorTokens.surfContainerLowDark,
        surfaceContainer: OudsMaterialColorTokens.surfContainerDark,
        surfaceContainerHigh: OudsMaterialColorTokens.surfContainerHighDark,
        surfaceContainerHighest: OudsMaterialColorTokens.surfContainerHighestDark,
        onSurfaceVariant: OudsMaterialColorTokens.onSurfaceVariantDark,
        outline: OudsMaterialColorTokens.outlineDark,
        outlineVariant: OudsMaterialColorTokens.outlineVariantDark,
        inverseSurface: OudsMaterialColorTokens.inverseSurfaceDark,
        onInverseSurface: OudsMaterialColorTokens.onSurfaceDark,
        inversePrimary: OudsMaterialColorTokens.inversePrimaryDark,
        surfaceTint: OudsMaterialColorTokens.surfaceTintDark,
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
