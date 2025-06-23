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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_surface_semantic_tokens.dart';
import 'package:ouds_theme_white_label/raw/white_label_color_raw_tokens.dart';

class WhiteLabelColorSurfaceSemanticTokens extends OudsColorSurfaceSemanticTokens {
  const WhiteLabelColorSurfaceSemanticTokens({
    super.surfaceBrandPrimaryLight = WhiteLabelColorRawTokens.colorBlue500,
    super.surfaceBrandPrimaryDark = WhiteLabelColorRawTokens.colorBlue500,
    super.surfaceBrandSecondaryLight = const Color(0x00ff0000),
    super.surfaceBrandSecondaryDark = const Color(0x00ff0000),
    super.surfaceBrandTertiaryLight = const Color(0x00ff0000),
    super.surfaceBrandTertiaryDark = const Color(0x00ff0000),
    super.surfaceStatusNeutralMutedLight = ColorRawTokens.colorOpacityBlack40,
    super.surfaceStatusNeutralMutedDark = ColorRawTokens.colorOpacityWhite80,
    super.surfaceStatusNeutralEmphasizedLight = ColorRawTokens.colorOpacityBlack840,
    super.surfaceStatusNeutralEmphasizedDark = ColorRawTokens.colorOpacityWhite920,
    super.surfaceStatusPositiveMutedLight = ColorRawTokens.colorOpacityMalachite,
    super.surfaceStatusPositiveMutedDark = ColorRawTokens.colorFunctionalMalachite900,
    super.surfaceStatusPositiveEmphasizedLight = ColorRawTokens.colorFunctionalMalachite500,
    super.surfaceStatusPositiveEmphasizedDark = ColorRawTokens.colorFunctionalMalachite300,
    super.surfaceStatusInfoMutedLight = ColorRawTokens.colorOpacityDodgerBlue,
    super.surfaceStatusInfoMutedDark = ColorRawTokens.colorFunctionalDodgerBlue900,
    super.surfaceStatusInfoEmphasizedLight = ColorRawTokens.colorFunctionalDodgerBlue500,
    super.surfaceStatusInfoEmphasizedDark = ColorRawTokens.colorFunctionalDodgerBlue300,
    super.surfaceStatusWarningMutedLight = ColorRawTokens.colorOpacitySun,
    super.surfaceStatusWarningMutedDark = ColorRawTokens.colorFunctionalSun900,
    super.surfaceStatusWarningEmphasizedLight = ColorRawTokens.colorFunctionalSun500,
    super.surfaceStatusWarningEmphasizedDark = ColorRawTokens.colorFunctionalSun300,
    super.surfaceStatusNegativeMutedLight = ColorRawTokens.colorOpacityScarlet,
    super.surfaceStatusNegativeMutedDark = ColorRawTokens.colorFunctionalScarlet900,
    super.surfaceStatusNegativeEmphasizedLight = ColorRawTokens.colorFunctionalScarlet600,
    super.surfaceStatusNegativeEmphasizedDark = ColorRawTokens.colorFunctionalScarlet300,
    super.surfaceStatusAccentMutedLight = WhiteLabelColorRawTokens.colorWarmGray100,
    super.surfaceStatusAccentMutedDark = WhiteLabelColorRawTokens.colorWarmGray1000,
    super.surfaceStatusAccentEmphasizedLight = ColorRawTokens.colorFunctionalSun500,
    super.surfaceStatusAccentEmphasizedDark = ColorRawTokens.colorFunctionalSun300,
  });
}
