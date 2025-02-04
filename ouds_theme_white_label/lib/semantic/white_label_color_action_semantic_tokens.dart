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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_action_semantic_tokens.dart';
import 'package:ouds_theme_white_label/raw/white_label_color_raw_tokens.dart';

class WhiteLabelColorActionSemanticTokens
    extends OudsColorActionSemanticTokens {
  const WhiteLabelColorActionSemanticTokens({
    super.actionDisabledLight = ColorRawTokens.colorOpacityBlack200,
    super.actionEnabledLight = ColorRawTokens.colorFunctionalBlack,
    super.actionFocusLight = ColorRawTokens.colorOpacityBlack680,
    super.actionHighlightedLight = ColorRawTokens.colorFunctionalBlack,
    super.actionHoverLight = ColorRawTokens.colorOpacityBlack680,
    super.actionLoadingLight = WhiteLabelColorRawTokens.colorBlue600,
    super.actionDisabledDark = ColorRawTokens.colorOpacityWhite200,
  });
}
