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
import 'package:ouds_global_raw_tokens/typography_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/ouds_color_scheme.dart';
import 'package:ouds_theme_contract/theme/ouds_theme_contract.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_orange/tokens/material/orange_material_color_dark_tokens.dart';
import 'package:ouds_theme_orange/tokens/material/orange_material_color_light_tokens.dart';
import 'package:ouds_theme_orange/tokens/semantic/orange_border_semantic_tokens.dart';
import 'package:ouds_theme_orange/tokens/semantic/orange_color_semantic_tokens.dart';

class OrangeTheme implements OudsThemeContract {
  final ThemeMode themeMode;

  OrangeTheme({required this.themeMode});

  @override
  String get name => "Orange";

  @override
  ThemeData get themeData => ThemeData(
        colorScheme: OrangeMaterialColorLightTokens.colorScheme,
        scaffoldBackgroundColor:
            colorSemanticTokens.backgroundColorTokens.bgPrimaryLight,
        textTheme: const TextTheme(
          bodyMedium: RawTypography.bodyText,
          headlineLarge: RawTypography.headline1,
        ),
      );

  @override
  OudsColorSemanticTokens get colorSemanticTokens =>
      OrangeColorSemanticTokens();

  @override
  OudsBorderSemanticTokens get borderTokens => OrangeBorderSemanticTokens();

  @override
  OudsColorScheme get colorsScheme =>
      OudsColorScheme(colorTokens: colorSemanticTokens, themeMode: themeMode);

  @override
  OudsComponentsTokens get componentsTokens =>
      OudsComponentsTokens(colorScheme: colorsScheme);

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      colorScheme: OrangeMaterialColorDarkTokens.colorScheme,
      scaffoldBackgroundColor:
          colorSemanticTokens.backgroundColorTokens.bgPrimaryDark,
      textTheme: const TextTheme(
        bodyMedium: RawTypography.bodyText,
        headlineLarge: RawTypography.headline1,
      ),
    );
  }
}
