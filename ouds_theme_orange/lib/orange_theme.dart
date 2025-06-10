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
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_space_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/typography/ouds_typography.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_elevation_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_font_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_grid_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_opacity_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_size_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_space_semantic_tokens.dart';
import 'package:ouds_theme_orange/material/orange_material_color_dark_tokens.dart';
import 'package:ouds_theme_orange/material/orange_material_color_light_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_border_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_elevation_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_font_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_grid_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_opacity_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_size_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_space_semantic_tokens.dart';

/// [OrangeTheme] implements the [OudsThemeContract] and defines the "Orange" theme for the application.
/// It provides both light and dark theme configurations using the OUDS design system, including color, typography,
/// and component tokens. The class handles the theme's data for both light and dark modes, allowing dynamic
/// switching based on the current [ThemeMode] setting.
///
/// The theme includes the following:
/// - A color scheme with semantic tokens for light and dark modes,
/// - Typography settings based on the defined font tokens,
/// - Component tokens for consistency across the app's UI elements.
///
/// This theme is used for the visual styling of the Flutter application, ensuring a consistent user experience
/// across both Android and iOS platforms.
class OrangeTheme implements OudsThemeContract {
  OrangeTheme();

  @override
  String get name => "Orange";

  @override
  ThemeData get themeData => ThemeData(
        fontFamily: fontFamily,
        package: packageName,
        colorScheme: OrangeMaterialColorLightTokens.colorScheme,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: fontTokens.sizeBodyMediumMobile,
            fontWeight: fontTokens.weightBodyDefault,
            color: colorSemanticTokens.contentColorTokens.contentDefaultLight,
          ),
        ),
      );

  @override
  OudsColorSemanticTokens get colorSemanticTokens => OrangeColorSemanticTokens();

  @override
  OudsOpacitySemanticTokens get opacityTokens => OrangeOpacitySemanticTokens();

  @override
  OudsBorderSemanticTokens get borderTokens => OrangeBorderSemanticTokens();

  @override
  OudsElevationSemanticTokens get elevationTokens => OrangeElevationSemanticTokens();

  @override
  OudsSpaceSemanticTokens get spaceSemanticTokens => OrangeSpaceSemanticTokens();

  @override
  OudsSizeSemanticTokens get sizeTokens => OrangeSizeSemanticTokens();

  @override
  OudsGridSemanticTokens get gridSemanticTokens => OrangeGridSemanticTokens();

  @override
  OudsFontSemanticTokens get fontTokens => OrangeFontSemanticTokens();

  @override
  String get fontFamily => 'Roboto';

  @override
  String get packageName => 'ouds_theme_orange';

  @override
  OudsColorScheme colorScheme(BuildContext context) {
    return OudsColorScheme.fromContext(context: context, colorTokens: colorSemanticTokens);
  }

  @override
  OudsSpaceScheme spaceScheme(BuildContext context) {
    return OudsSpaceScheme.fromContext(context: context, spaceTokens: spaceSemanticTokens);
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
      sizeTokens: sizeTokens,
      fontTokens: fontTokens,
    );
  }

  @override
  OudsComponentsTokens componentsTokens(BuildContext context) {
    return OudsComponentsTokens(
      providersTokens: providersTokens(context),
    );
  }

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      fontFamily: fontFamily,
      package: packageName,
      colorScheme: OrangeMaterialColorDarkTokens.colorScheme,
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
