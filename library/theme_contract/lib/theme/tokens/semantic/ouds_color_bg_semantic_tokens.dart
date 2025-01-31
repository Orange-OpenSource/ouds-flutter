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
import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';
import 'package:ouds_global_raw_tokens/orange_brand_color_raw_tokens.dart';

class OudsColorBgSemanticTokens {
  final Color bgEmphasizedLight;
  final Color bgPrimaryLight;
  final Color bgSecondaryLight;
  final Color bgTertiaryLight;
  final Color bgEmphasizedDark;
  final Color bgPrimaryDark;
  final Color bgSecondaryDark;
  final Color bgTertiaryDark;

  const OudsColorBgSemanticTokens({
    this.bgEmphasizedLight = ColorRawTokens.colorFunctionalDarkGray880,
    this.bgPrimaryLight = ColorRawTokens.colorFunctionalWhite,
    this.bgSecondaryLight = ColorRawTokens.colorFunctionalBlack,
    this.bgTertiaryLight = OrangeBrandColorRawTokens.colorWarmGray100,
    this.bgEmphasizedDark = ColorRawTokens.colorFunctionalDarkGray640,
    this.bgPrimaryDark = ColorRawTokens.colorFunctionalDarkGray880,
    this.bgSecondaryDark = ColorRawTokens.colorFunctionalWhite,
    this.bgTertiaryDark = OrangeBrandColorRawTokens.colorWarmGray900,
  });
}
