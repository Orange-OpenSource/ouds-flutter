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
import 'package:global_raw_tokens/typography_raw_tokens.dart';
import 'package:theme_contract/theme/ouds_theme_contract.dart';
import 'package:theme_contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:theme_contract/theme/tokens/flutter/ouds_flutter_color_dark_tokens.dart';
import 'package:theme_contract/theme/tokens/flutter/ouds_flutter_color_light_tokens.dart';
import 'package:theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

class OrangeTheme implements OudsThemeContract {
  @override
  ThemeData get themeData => ThemeData(
        colorScheme: OudsFlutterColorLightTokens.colorScheme,
        scaffoldBackgroundColor:
            colorSemanticTokens.backgroundColorTokens.bgPrimaryLight,
        textTheme: const TextTheme(
          bodyMedium: RawTypography.bodyText,
          headlineLarge: RawTypography.headline1,
        ),

        /// ElevatedButtonTheme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: componentsTokens.button.colorBgDefaultEnabled,
            textStyle: RawTypography.bodyText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  componentsTokens.button.borderWidthDefaultInteraction),
            ),
            minimumSize: const Size(130, 60),
            foregroundColor: componentsTokens.button.colorContentDefaultEnabled,
          ),
        ),
      );

  @override
  OudsColorSemanticTokens get colorSemanticTokens =>
      const OudsColorSemanticTokens();

  @override
  String get name => "Orange";

  @override
  OudsComponentsTokens get componentsTokens =>
      OudsComponentsTokens(colorTokens: colorSemanticTokens);

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      colorScheme: OudsFlutterColorDarkTokens.colorScheme,
      scaffoldBackgroundColor:
          colorSemanticTokens.backgroundColorTokens.bgPrimaryDark,
      textTheme: const TextTheme(
        bodyMedium: RawTypography.bodyText,
        headlineLarge: RawTypography.headline1,
      ),

      /// ElevatedButtonTheme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: componentsTokens.button.colorBgDefaultEnabled,
          textStyle: RawTypography.bodyText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                componentsTokens.button.borderWidthDefaultInteraction),
          ),
          minimumSize: const Size(130, 60),
          foregroundColor: componentsTokens.button.colorContentDefaultEnabled,
        ),
      ),
    );
  }
}
