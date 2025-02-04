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
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange/semantic/orange_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_content_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_semantic_tokens.dart';

class OrangeCountryCustomTheme extends OrangeTheme {
  static const Color colorGreen500 = Color(0xFF34D349);
  static const Color colorGreen600 = Color(0xFF069D1A);

  OrangeCountryCustomTheme({required super.themeMode});

  @override
  String get name => "Orange Country";

  @override
  OudsColorSemanticTokens get colorSemanticTokens {
    return OrangeColorSemanticTokens(
      backgroundColorTokens: OrangeColorBgSemanticTokens(
        bgPrimaryLight: Color(0xFF34D349),
        bgPrimaryDark: Color(0xFF069D1A),
        bgSecondaryLight: Color(0xFFFF7404),
        bgSecondaryDark: Color(0xFFB65100),
      ),
      contentColorTokens: OrangeColorContentSemanticTokens(
        contentBrandPrimaryLight: colorGreen500,
        contentBrandPrimaryDark: colorGreen600,
      ),
    );
  }

  @override
  OudsComponentsTokens get componentsTokens {
    return OudsComponentsTokens(
        colorScheme: colorsScheme,
        button: OudsButtonTokens(colorScheme: colorsScheme, borderRadius: 5));
  }
}
