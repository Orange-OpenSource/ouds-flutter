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

import 'package:flutter/material.dart';
import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';

class WhiteLabelMaterialColorLightTokens {
  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.light,

        /// Colors for primary roles
        primary: ColorRawTokens.colorFunctionalBlack,
        onPrimary: ColorRawTokens.colorFunctionalLightGray160,
        primaryContainer: ColorRawTokens.colorFunctionalBlack,
        onPrimaryContainer: ColorRawTokens.colorFunctionalWhite,
        inversePrimary: ColorRawTokens.colorFunctionalWhite,

        /// Colors for secondary roles
        secondary: ColorRawTokens.colorFunctionalBlack,
        onSecondary: ColorRawTokens.colorFunctionalLightGray160,
        secondaryContainer: ColorRawTokens.colorFunctionalBlack,
        onSecondaryContainer: ColorRawTokens.colorFunctionalWhite,

        /// Tertiary colors
        tertiary: ColorRawTokens.colorFunctionalWhite,
        onTertiary: ColorRawTokens.colorFunctionalBlack,
        tertiaryContainer: ColorRawTokens.colorFunctionalWhite,
        onTertiaryContainer: ColorRawTokens.colorFunctionalBlack,

        /// Background and surface colors
        background: ColorRawTokens.colorFunctionalWhite,
        onBackground: ColorRawTokens.colorFunctionalBlack,
        surface: ColorRawTokens.colorFunctionalWhite,
        surfaceVariant: ColorRawTokens.colorFunctionalWhite,
        surfaceTint: ColorRawTokens.colorFunctionalWhite,
        onSurface: ColorRawTokens.colorFunctionalBlack,
        onSurfaceVariant: ColorRawTokens.colorOpacityBlack680,

        /// Additional surface roles
        surfaceBright: ColorRawTokens.colorFunctionalWhite,
        surfaceDim: ColorRawTokens.colorFunctionalLightGray80,
        inverseSurface: ColorRawTokens.colorFunctionalDarkGray720,
        onInverseSurface: ColorRawTokens.colorFunctionalWhite,

        /// Error colors
        error: ColorRawTokens.colorFunctionalScarlet600,
        onError: ColorRawTokens.colorFunctionalWhite,
        errorContainer: ColorRawTokens.colorFunctionalScarlet100,
        onErrorContainer: ColorRawTokens.colorFunctionalBlack,

        /// Outline and scrim colors
        outline: ColorRawTokens.colorFunctionalBlack,
        outlineVariant: ColorRawTokens.colorOpacityBlack200,
        scrim: ColorRawTokens.colorFunctionalBlack,

        /// Surface containers
        surfaceContainer: ColorRawTokens.colorFunctionalLightGray80,
        surfaceContainerHigh: ColorRawTokens.colorFunctionalLightGray80,
        surfaceContainerHighest: ColorRawTokens.colorFunctionalLightGray80,
        surfaceContainerLow: ColorRawTokens.colorFunctionalWhite,
        surfaceContainerLowest: ColorRawTokens.colorFunctionalWhite,
      );
}
