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
import 'package:ouds_flutter/global-raw-tokens/typography_raw_tokens.dart';
import 'package:ouds_flutter/theme-contract/theme/ouds_theme_contract.dart';
import 'package:ouds_flutter/theme-contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

class WhiteLabelTheme implements OudsThemeContract {
  @override
  ThemeData get themeData => ThemeData(
        primaryColor: colorTokens.actionColorTokens.actionDisabledLight,
        scaffoldBackgroundColor:
            colorTokens.actionColorTokens.actionDisabledDark,
        textTheme: const TextTheme(
          bodyMedium: RawTypography.bodyText,
          headlineLarge: RawTypography.headline1,
        ),
      );

  // Implémentation des couleurs (directement dans la classe)
  @override
  OudsColorSemanticTokens get colorTokens => const OudsColorSemanticTokens();

  @override
  String get name => "WhiteLabelTheme";
}
