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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_action_semantic_tokens.dart';
import 'package:ouds_theme_white_label/raw/white_label_color_raw_tokens.dart';

class WhiteLabelColorActionSemanticTokens extends OudsColorActionSemanticTokens {
  const WhiteLabelColorActionSemanticTokens({
    super.actionEnabledLight = ColorRawTokens.colorFunctionalBlack,
    super.actionEnabledDark = ColorRawTokens.colorFunctionalGrayLight160,
    super.actionHoverLight = ColorRawTokens.colorOpacityBlack680,
    super.actionHoverDark = ColorRawTokens.colorOpacityWhite640,
    super.actionPressedLight = WhiteLabelColorRawTokens.colorBlue500,
    super.actionPressedDark = WhiteLabelColorRawTokens.colorBlue500,
    super.actionLoadingLight = WhiteLabelColorRawTokens.colorBlue500,
    super.actionLoadingDark = WhiteLabelColorRawTokens.colorBlue500,
    super.actionDisabledLight = ColorRawTokens.colorOpacityBlack200,
    super.actionDisabledDark = ColorRawTokens.colorOpacityWhite200,
    super.actionFocusLight = ColorRawTokens.colorOpacityBlack680,
    super.actionFocusDark = ColorRawTokens.colorOpacityWhite640,
    super.actionSelectedLight = WhiteLabelColorRawTokens.colorBlue500,
    super.actionSelectedDark = WhiteLabelColorRawTokens.colorBlue500,
    super.actionVisitedLight = WhiteLabelColorRawTokens.colorDecorativeAmethyst600,
    super.actionVisitedDark = WhiteLabelColorRawTokens.colorDecorativeAmethyst400,
    super.actionHighlightedLight = ColorRawTokens.colorFunctionalBlack,
    super.actionHighlightedDark = ColorRawTokens.colorFunctionalGrayLight160,
    super.actionSupportEnabledLight = ColorRawTokens.colorOpacityBlack40,
    super.actionSupportEnabledDark = ColorRawTokens.colorOpacityWhite40,
    super.actionSupportHoverLight = ColorRawTokens.colorOpacityBlack80,
    super.actionSupportHoverDark = ColorRawTokens.colorOpacityWhite80,
    super.actionSupportPressedLight = ColorRawTokens.colorOpacityBlack120,
    super.actionSupportPressedDark = ColorRawTokens.colorOpacityWhite120,
    super.actionSupportLoadingLight = ColorRawTokens.colorOpacityBlack120,
    super.actionSupportLoadingDark = ColorRawTokens.colorOpacityWhite120,
    super.actionSupportFocusLight = ColorRawTokens.colorOpacityBlack80,
    super.actionSupportFocusDark = ColorRawTokens.colorOpacityWhite80,
    super.actionNegativeEnabledLight = ColorRawTokens.colorFunctionalScarlet600,
    super.actionNegativeEnabledDark = ColorRawTokens.colorFunctionalScarlet300,
    super.actionNegativeHoverLight = ColorRawTokens.colorFunctionalScarlet700,
    super.actionNegativeHoverDark = ColorRawTokens.colorFunctionalScarlet200,
    super.actionNegativePressedLight = ColorRawTokens.colorFunctionalScarlet800,
    super.actionNegativePressedDark = ColorRawTokens.colorFunctionalScarlet100,
    super.actionNegativeLoadingLight = ColorRawTokens.colorFunctionalScarlet800,
    super.actionNegativeLoadingDark = ColorRawTokens.colorFunctionalScarlet100,
    super.actionNegativeFocusLight = ColorRawTokens.colorFunctionalScarlet700,
    super.actionNegativeFocusDark = ColorRawTokens.colorFunctionalScarlet200,
  });
}
