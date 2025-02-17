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

import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_white_label/raw/white_label_color_raw_tokens.dart';

class WhiteLabelColorBgSemanticTokens extends OudsColorBgSemanticTokens {
  const WhiteLabelColorBgSemanticTokens({
    super.bgEmphasizedLight = ColorRawTokens.colorFunctionalDarkGray880,
    super.bgPrimaryLight = ColorRawTokens.colorFunctionalWhite,
    super.bgSecondaryLight = ColorRawTokens.colorFunctionalBlack,
    super.bgTertiaryLight = WhiteLabelColorRawTokens.colorWarmGray100,
    super.bgEmphasizedDark = ColorRawTokens.colorFunctionalDarkGray640,
    super.bgPrimaryDark = ColorRawTokens.colorFunctionalDarkGray880,
    super.bgSecondaryDark = ColorRawTokens.colorFunctionalWhite,
    super.bgTertiaryDark = WhiteLabelColorRawTokens.colorWarmGray900,
  });
}
