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

/// [OrangeCountryCustomTheme] is a custom implementation of the [OrangeTheme] designed specifically for the "Orange Country" variant.
/// It overrides the color and component tokens to apply unique styles tailored to this specific version of the theme.
///
/// The class provides the following customizations:
/// - Custom color palette for background and content colors, including shades of green and orange for light and dark themes.
/// - Custom button styling with adjusted border radius and width, making the buttons fit the "Orange Country" visual identity.
///
/// This theme extends the base [OrangeTheme] while adding country-specific variations, ensuring the application maintains
/// a consistent design while reflecting the branding of the "Orange Country" variant.
///

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
      providersTokens: providersTokens,
      button: OudsButtonTokens(
          borderRadius: 30,
          borderWidthDefault: 2,
          providersTokens: providersTokens),
    );
  }
}
