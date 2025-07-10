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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_overlay_semantic_tokens.dart';

class WhiteLabelColorOverlaySemanticTokens extends OudsColorOverlaySemanticTokens {
  const WhiteLabelColorOverlaySemanticTokens({
    super.overlayDefaultLight = ColorRawTokens.colorFunctionalWhite,
    super.overlayDefaultDark = ColorRawTokens.colorOpacityWhite80,
    super.overlayEmphasizedLight = ColorRawTokens.colorFunctionalGrayDark720,
    super.overlayEmphasizedDark = ColorRawTokens.colorFunctionalGrayLight160,
    super.overlayDragLight = ColorRawTokens.colorOpacityBlack40,
    super.overlayDragDark = ColorRawTokens.colorOpacityWhite200,
    super.overlayModalLight = ColorRawTokens.colorFunctionalWhite,
    super.overlayModalDark = ColorRawTokens.colorFunctionalGrayDark640,
  });
}
