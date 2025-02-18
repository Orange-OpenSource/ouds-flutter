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
import 'package:ouds_theme_contract/ouds_color_scheme.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_contract/ouds_tokens_provider.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_elevation_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_font_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_grid_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_opacity_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_size_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_space_semantic_tokens.dart';
import 'package:ouds_theme_white_label/material/white_label_material_color_dark_tokens.dart';
import 'package:ouds_theme_white_label/material/white_label_material_color_light_tokens.dart';
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
  final ThemeMode themeMode;

  WhiteLabelTheme({required this.themeMode});

  @override
  String get name => "White label";

  @override
  ThemeData get themeData => ThemeData(
        fontFamily: 'oswald',
        colorScheme: WhiteLabelMaterialColorLightTokens.colorScheme,
        scaffoldBackgroundColor:
            colorSemanticTokens.backgroundColorTokens.bgPrimaryLight,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: fontTokens.sizeBodyMediumMobile,
            fontWeight: fontTokens.weightBodyDefault,
            color:
                colorSemanticTokens.contentColorTokens.contentBrandPrimaryDark,
          ),
        ),
      );

  @override
  OudsColorSemanticTokens get colorSemanticTokens =>
      WhiteLabelColorSemanticTokens();

  @override
  OudsOpacitySemanticTokens get opacityTokens =>
      WhiteLabelOpacitySemanticTokens();

  @override
  OudsBorderSemanticTokens get borderTokens => WhiteLabelBorderSemanticTokens();

  @override
  OudsElevationSemanticTokens get elevationTokens =>
      WhiteLabelElevationSemanticTokens();

  @override
  OudsSpaceSemanticTokens get spaceTokens => WhiteLabelSpaceSemanticTokens();

  @override
  OudsSizeSemanticTokens get sizeTokens => WhiteLabelSizeSemanticTokens();

  @override
  OudsGridSemanticTokens get gridTokens => WhiteLabelGridSemanticTokens();

  @override
  OudsFontSemanticTokens get fontTokens => WhiteLabelFontSemanticTokens();

  @override
  OudsColorScheme get colorsScheme => OudsColorScheme(
        colorTokens: colorSemanticTokens,
        themeMode: themeMode,
      );

  @override
  OudsProvidersTokens get providersTokens => OudsProvidersTokens(
      colorScheme: colorsScheme,
      opacityTokens: opacityTokens,
      borderTokens: borderTokens,
      elevationTokens: elevationTokens,
      spaceTokens: spaceTokens,
      sizeTokens: sizeTokens,
      gridTokens: gridTokens,
      fontTokens: fontTokens);

  @override
  OudsComponentsTokens get componentsTokens => OudsComponentsTokens(
      button: OudsButtonTokens(providersTokens: providersTokens),
      providersTokens: providersTokens);

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      colorScheme: WhiteLabelMaterialColorDarkTokens.colorScheme,
      scaffoldBackgroundColor:
          colorSemanticTokens.backgroundColorTokens.bgPrimaryDark,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: fontTokens.sizeBodyMediumMobile,
          fontWeight: fontTokens.weightBodyDefault,
          color: colorSemanticTokens.contentColorTokens.contentBrandPrimaryDark,
        ),
      ),
    );
  }
}
