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

import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_white_label/raw/white_label_color_raw_tokens.dart';

class WhiteLabelColorBgSemanticTokens extends OudsColorBgSemanticTokens {
  const WhiteLabelColorBgSemanticTokens({
    super.bgPrimaryLight = ColorRawTokens.colorFunctionalWhite,
    super.bgPrimaryDark = ColorRawTokens.colorFunctionalGrayDark880,
    super.bgSecondaryLight = ColorRawTokens.colorFunctionalGrayLight80,
    super.bgSecondaryDark = ColorRawTokens.colorFunctionalGrayDark800,
    super.bgTertiaryLight = WhiteLabelColorRawTokens.colorWarmGray100,
    super.bgTertiaryDark = WhiteLabelColorRawTokens.colorWarmGray1000,
    super.bgEmphasizedLight = ColorRawTokens.colorFunctionalGrayDark880,
    super.bgEmphasizedDark = ColorRawTokens.colorFunctionalGrayDark640,
  });
}
