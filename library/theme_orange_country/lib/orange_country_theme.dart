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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_orange/orange_theme.dart';

class OrangeCountryCustomTheme extends OrangeTheme {
  final ThemeMode themeMode;

  OrangeCountryCustomTheme({required this.themeMode})
      : super(themeMode: themeMode);

  @override
  String get name => "Orange Country";

  @override
  OudsColorSemanticTokens get colorSemanticTokens {
    return const OudsColorSemanticTokens(
      backgroundColorTokens: OudsColorBgSemanticTokens(
        bgPrimaryLight: Color(0xFF34D349),
        bgPrimaryDark: Color(0xFF069D1A),
        bgSecondaryLight: Color(0xFFFF7404),
        bgSecondaryDark: Color(0xFFB65100),
      ),
    );
  }

  @override
  OudsComponentsTokens get componentsTokens {
    return OudsComponentsTokens(
        colorScheme: colorsScheme,
        button: OudsButtonTokens(colorScheme: colorsScheme, borderRadius: 20));
  }

  @override
  ThemeData get themeData {
    return super.themeData.copyWith();
  }
}
