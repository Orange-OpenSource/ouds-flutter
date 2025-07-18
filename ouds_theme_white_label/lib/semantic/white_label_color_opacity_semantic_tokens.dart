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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_opacity_semantic_tokens.dart';

class WhiteLabelColorOpacitySemanticTokens extends OudsColorOpacitySemanticTokens {
  const WhiteLabelColorOpacitySemanticTokens({
    super.opacityLowerDark = ColorRawTokens.colorOpacityWhite80,
    super.opacityLowerLight = ColorRawTokens.colorOpacityBlack80,
    super.opacityLowestDark = ColorRawTokens.colorOpacityWhite40,
    super.opacityLowestLight = ColorRawTokens.colorOpacityBlack40,
    super.opacityTransparentDark = ColorRawTokens.colorOpacityWhite0,
    super.opacityTransparentLight = ColorRawTokens.colorOpacityBlack0,
  });
}
