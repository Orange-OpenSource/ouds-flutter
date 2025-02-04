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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_content_semantic_tokens.dart';
import 'package:ouds_theme_orange/tokens/raw/orange_brand_color_raw_tokens.dart';

class OrangeColorContentSemanticTokens extends OudsColorContentSemanticTokens {
  const OrangeColorContentSemanticTokens({
    super.contentBrandPrimaryLight = ColorRawTokens.colorFunctionalDarkGray880,
    super.contentDefaultLight = ColorRawTokens.colorFunctionalWhite,
    super.contentDisabledLight = ColorRawTokens.colorFunctionalBlack,
    super.contentBrandPrimaryDark = OrangeBrandColorRawTokens.colorWarmGray100,
    super.contentDefaultDark = ColorRawTokens.colorFunctionalDarkGray640,
    super.contentDisabledDark = ColorRawTokens.colorFunctionalDarkGray880,
  });
}
