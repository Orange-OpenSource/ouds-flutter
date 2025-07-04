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

import 'package:ouds_global_raw_tokens/elevation_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_elevation_semantic_tokens.dart';

class WhiteLabelElevationSemanticTokens extends OudsElevationSemanticTokens {
  @override
  double get drag => ElevationRawTokens.elevation4;
  @override
  double get none => ElevationRawTokens.elevation0;
  @override
  double get overlayDefault => ElevationRawTokens.elevation2;
  @override
  double get overlayEmphasized => ElevationRawTokens.elevation5;
  @override
  double get raised => ElevationRawTokens.elevation1;
  @override
  double get stickyDefault => ElevationRawTokens.elevation3;
  @override
  double get stickyEmphasized => ElevationRawTokens.elevation3;
  @override
  double get stickyNavigationScrolled => ElevationRawTokens.elevation3;
}
