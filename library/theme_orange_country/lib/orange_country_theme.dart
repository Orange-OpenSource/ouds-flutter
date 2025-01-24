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
import 'package:theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:theme_contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:theme_contract/theme/tokens/semantic/ouds_color_bg_semantic_tokens.dart';
import 'package:theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:theme_orange/orange_theme.dart';

class OrangeCountryCustomTheme extends OrangeTheme {
  @override
  String get name => "Orange Country";

  @override
  OudsColorSemanticTokens get colorTokens {
    return const OudsColorSemanticTokens(
      backgroundColorTokens: OudsColorBgSemanticTokens(
        bgPrimaryLight: Color(0xFF34D349),
        bgPrimaryDark: Color(0xFF069D1A),
      ),
    );
  }

  @override
  OudsComponentsTokens get componentsTokens {
    return const OudsComponentsTokens(
      button: OudsButtonTokens(
        borderRadius: 34,
        borderWidthDefault: 39,
      ),
    );
  }

  @override
  ThemeData get themeData {
    return super.themeData.copyWith();
  }
}
