/*
 * Software Name: OUDS Android
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Android library of reusable graphical components
 */

import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_border_semantic_tokens.dart';
import 'package:ouds_theme_white_label/raw/white_label_color_raw_tokens.dart';

class WhiteLabelColorBorderSemanticTokens
    extends OudsColorBorderSemanticTokens {
  const WhiteLabelColorBorderSemanticTokens({
    super.borderBrandPrimaryLight = WhiteLabelColorRawTokens.colorBlue600,
    super.borderDefaultLight = ColorRawTokens.colorOpacityBlack200,
    super.borderEmphasizedLight = ColorRawTokens.colorFunctionalBlack,
    super.borderFocusLight = ColorRawTokens.colorFunctionalBlack,
    super.borderFocusInsetLight = ColorRawTokens.colorFunctionalWhite,
    super.borderOnBrandPrimaryLight = ColorRawTokens.colorFunctionalBlack,
    super.borderOnBrandPrimaryDark = ColorRawTokens.colorFunctionalBlack,
    super.borderBrandPrimaryDark = WhiteLabelColorRawTokens.colorBlue500,
    super.borderDefaultDark = ColorRawTokens.colorOpacityWhite200,
    super.borderEmphasizedDark = ColorRawTokens.colorOpacityWhite920,
    super.borderFocusDark = ColorRawTokens.colorFunctionalLightGray160,
    super.borderFocusInsetDark = ColorRawTokens.colorFunctionalDarkGray880,
  });
}
