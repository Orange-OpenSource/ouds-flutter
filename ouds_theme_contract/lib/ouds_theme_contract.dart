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

/// Contract to create an OUDS-compliant theme.
/// Any values that are not defined will inherit from the default Orange theme.

abstract interface class OudsThemeContract {
  /// Theme display name.
  String get name;

  /// Material color matching used in the theme
  OudsMaterialColorTokens get materialColorTokens;

  /// Color semantic tokens values used in the theme
  OudsColorSemanticTokens get colorSemanticTokens;

  /// Returns design tokens specific to OUDS components for the active theme, using [BuildContext] to access the correct widget tree context.
  OudsComponentsTokens componentsTokens(BuildContext context);

  /// Opacity semantic tokens values used in the theme
  OudsOpacitySemanticTokens get opacityTokens;

  /// Border semantic tokens values used in the theme
  OudsBorderSemanticTokens get borderTokens;

  /// Elevation semantic tokens values used in the theme
  OudsElevationSemanticTokens get elevationTokens;

  /// Space semantic tokens values used in the theme
  OudsSpaceSemanticTokens get spaceSemanticTokens;

  /// Size semantic tokens values used in the theme
  OudsSizeSemanticTokens get sizeSemanticTokens;

  /// Grid semantic tokens values used in the theme
  OudsGridSemanticTokens get gridSemanticTokens;

  /// Font semantic tokens values used in the theme
  OudsFontSemanticTokens get fontTokens;

  /// Font family used in the theme
  /// You can provide your own theme font family `fontFamily: 'Oswald'`
  String get fontFamily;

  /// Package name used in the theme: Ex : 'ouds_theme_white_label'.
  /// This refers to the package containing the theme resources
  /// ensuring that the font and other assets are correctly loaded from it
  String get packageName;

  /// Defines the configuration of the overall visual Theme for a MaterialApp or a widget subtree within the app,  specifically for the light theme
  ThemeData get themeData;

  /// Defines the configuration of the overall visual Theme for a MaterialApp or a widget subtree within the app,  specifically for the dark theme
  ThemeData get darkThemeData;

  /// Returns the color scheme for the active theme, using [BuildContext] to access the correct widget tree context.
  OudsColorScheme colorScheme(BuildContext context);

  /// Returns the space scheme for the active theme, using [BuildContext] to access the correct widget tree context.
  OudsSpaceScheme spaceScheme(BuildContext context);

  /// Returns the size scheme for the active theme, using [BuildContext] to access the correct widget tree context.
  OudsSizeScheme sizeScheme(BuildContext context);

  /// Returns the grid scheme for the active theme, using [BuildContext] to access the correct widget tree context.
  OudsGridScheme gridScheme(BuildContext context);

  /// Returns the global design tokens (colors, borders, etc.) for the active theme, using [BuildContext] to access the correct widget tree context.
  OudsProvidersTokens providersTokens(BuildContext context);

  /// Provides access to responsive typography styles based on the current theme and context.
  OudsTypography get typographyTokens;
}
