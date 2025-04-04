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
import 'package:ouds_theme_contract/ouds_tokens_provider.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_components_tokens.dart';
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

  /// Color semantic tokens values used in the theme
  OudsColorSemanticTokens get colorSemanticTokens;

  /// Customization of the OUDS components if needed
  OudsComponentsTokens get componentsTokens;

  /// Opacity semantic tokens values used in the theme
  OudsOpacitySemanticTokens get opacityTokens;

  /// Border semantic tokens values used in the theme
  OudsBorderSemanticTokens get borderTokens;

  /// Elevation semantic tokens values used in the theme
  OudsElevationSemanticTokens get elevationTokens;

  /// Space semantic tokens values used in the theme
  OudsSpaceSemanticTokens get spaceTokens;

  /// Size semantic tokens values used in the theme
  OudsSizeSemanticTokens get sizeTokens;

  /// Grid semantic tokens values used in the theme
  OudsGridSemanticTokens get gridTokens;

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

  /// Defines the configuration of the overall visual Theme for a MaterialApp or a widget subtree within the app,  specifically for the dark theme
  OudsColorScheme get colorsScheme;

  /// A getter to retrieve the set of tokens (color scheme, border tokens etc..)
  /// that define the theme's visual properties, which can be accessed throughout the widget tree.
  /// This allows components to access the necessary styling data in a consistent manner.
  OudsProvidersTokens get providersTokens;
}
