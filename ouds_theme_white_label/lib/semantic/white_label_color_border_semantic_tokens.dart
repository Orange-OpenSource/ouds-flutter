//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

// Generate manually using Orange tokens. This package will be soon removed and replaced by Sosh.

import 'package:flutter/material.dart';
import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_border_semantic_tokens.dart';
import 'package:ouds_theme_white_label/raw/white_label_color_raw_tokens.dart';

class WhiteLabelColorBorderSemanticTokens extends OudsColorBorderSemanticTokens {
  const WhiteLabelColorBorderSemanticTokens({
    super.borderDefaultLight = ColorRawTokens.colorOpacityBlack200,
    super.borderDefaultDark = ColorRawTokens.colorOpacityWhite200,
    super.borderMutedLight = ColorRawTokens.colorOpacityBlack80,
    super.borderMutedDark = ColorRawTokens.colorOpacityWhite80,
    super.borderEmphasizedLight = ColorRawTokens.colorFunctionalBlack,
    super.borderEmphasizedDark = ColorRawTokens.colorOpacityWhite920,
    super.borderFocusLight = ColorRawTokens.colorFunctionalBlack,
    super.borderFocusDark = ColorRawTokens.colorFunctionalGrayLight160,
    super.borderFocusInsetLight = ColorRawTokens.colorFunctionalWhite,
    super.borderFocusInsetDark = ColorRawTokens.colorFunctionalGrayDark880,
    super.borderBrandPrimaryLight = WhiteLabelColorRawTokens.colorBlue500,
    super.borderBrandPrimaryDark = WhiteLabelColorRawTokens.colorBlue500,
    super.borderBrandSecondaryLight = const Color(0x00ff0000),
    super.borderBrandSecondaryDark = const Color(0x00ff0000),
    super.borderBrandTertiaryLight = const Color(0x00ff0000),
    super.borderBrandTertiaryDark = const Color(0x00ff0000),
    super.borderStatusPositiveLight = const Color(0x00ff0000),
    super.borderStatusPositiveDark = const Color(0x00ff0000),
    super.borderStatusInfoLight = const Color(0x00ff0000),
    super.borderStatusInfoDark = const Color(0x00ff0000),
    super.borderStatusWarningLight = const Color(0x00ff0000),
    super.borderStatusWarningDark = const Color(0x00ff0000),
    super.borderStatusNegativeLight = const Color(0x00ff0000),
    super.borderStatusNegativeDark = const Color(0x00ff0000),
    super.borderStatusAccentLight = const Color(0x00ff0000),
    super.borderStatusAccentDark = const Color(0x00ff0000),
    super.borderOnBrandPrimaryLight = ColorRawTokens.colorFunctionalBlack,
    super.borderOnBrandPrimaryDark = ColorRawTokens.colorFunctionalBlack,
    super.borderOnBrandSecondaryLight = const Color(0x00ff0000),
    super.borderOnBrandSecondaryDark = const Color(0x00ff0000),
    super.borderOnBrandTertiaryLight = const Color(0x00ff0000),
    super.borderOnBrandTertiaryDark = const Color(0x00ff0000),
  });
}
