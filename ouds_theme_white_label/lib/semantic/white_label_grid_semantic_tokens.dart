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

import 'package:ouds_global_raw_tokens/grid_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_grid_semantic_tokens.dart';

class WhiteLabelGridSemanticTokens extends OudsGridSemanticTokens {
  @override
  double get compactColumnGap => GridRawTokens.gridColumnGap100;
  @override
  double get compactMargin => GridRawTokens.gridMargin300;
  @override
  int get compactMaxWidth => GridRawTokens.gridMaxWidthCompact;
  @override
  int get compactMinWidth => GridRawTokens.gridMinWidthCompact;
  @override
  double get extraCompactColumnGap => GridRawTokens.gridColumnGap100;
  @override
  double get extraCompactMargin => GridRawTokens.gridMargin100;
  @override
  int get extraCompactMaxWidth => GridRawTokens.gridMaxWidthExtraCompact;
  @override
  int get extraCompactMinWidth => GridRawTokens.gridMinWidthExtraCompact;
  @override
  double get mediumColumnGap => GridRawTokens.gridColumnGap400;
  @override
  double get mediumMargin => GridRawTokens.gridMargin500;
  @override
  int get mediumMaxWidth => GridRawTokens.gridMaxWidthMedium;
  @override
  int get mediumMinWidth => GridRawTokens.gridMinWidthMedium;
}
