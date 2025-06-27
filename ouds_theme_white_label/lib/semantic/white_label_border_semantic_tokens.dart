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

import 'package:ouds_global_raw_tokens/border_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';

class WhiteLabelBorderSemanticTokens extends OudsBorderSemanticTokens {
  @override
  double get widthNone => BorderRawTokens.borderWidth0;
  @override
  double get widthDefault => BorderRawTokens.borderWidth25;
  @override
  double get widthThin => BorderRawTokens.borderWidth25;
  @override
  double get widthMedium => BorderRawTokens.borderWidth50;
  @override
  double get widthThick => BorderRawTokens.borderWidth75;
  @override
  double get widthThicker => BorderRawTokens.borderWidth100;
  @override
  double get widthFocus => BorderRawTokens.borderWidth125;
  @override
  double get widthFocusInset => BorderRawTokens.borderWidth50;
  @override
  double get radiusNone => BorderRawTokens.borderRadius0;
  @override
  double get radiusDefault => BorderRawTokens.borderRadius0;
  @override
  double get radiusSmall => BorderRawTokens.borderRadius75;
  @override
  double get radiusMedium => BorderRawTokens.borderRadius150;
  @override
  double get radiusLarge => BorderRawTokens.borderRadius300;
  @override
  double get radiusPill => BorderRawTokens.borderRadius9999;
  @override
  String get styleDefault => BorderRawTokens.borderStyleSolid;
  @override
  String get styleDrag => BorderRawTokens.borderStyleDashed;
}
