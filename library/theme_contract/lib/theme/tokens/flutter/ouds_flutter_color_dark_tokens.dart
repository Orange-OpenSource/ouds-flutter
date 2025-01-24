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
import 'package:global_raw_tokens/color_raw_tokens.dart';

class OudsFlutterColorDarkTokens {
  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.dark,

        /// Colors for primary roles
        primary: ColorRawTokens.colorFunctionalLightGray160,
        onPrimary: ColorRawTokens.colorFunctionalBlack,
        primaryContainer: ColorRawTokens.colorFunctionalLightGray160,
        onPrimaryContainer: ColorRawTokens.colorFunctionalBlack,
        inversePrimary: ColorRawTokens.colorFunctionalBlack,

        /// Colors for secondary roles
        secondary: ColorRawTokens.colorFunctionalLightGray160,
        onSecondary: ColorRawTokens.colorFunctionalBlack,
        secondaryContainer: ColorRawTokens.colorFunctionalLightGray160,
        onSecondaryContainer: ColorRawTokens.colorFunctionalBlack,

        /// Tertiary colors
        tertiary: ColorRawTokens.colorFunctionalDarkGray880,
        onTertiary: ColorRawTokens.colorFunctionalLightGray160,
        tertiaryContainer: ColorRawTokens.colorFunctionalDarkGray880,
        onTertiaryContainer: ColorRawTokens.colorFunctionalLightGray160,

        /// Background and surface colors
        background: ColorRawTokens.colorFunctionalDarkGray880,
        onBackground: ColorRawTokens.colorFunctionalLightGray160,
        surface: ColorRawTokens.colorFunctionalDarkGray880,
        surfaceVariant: ColorRawTokens.colorFunctionalDarkGray880,
        surfaceTint: ColorRawTokens.colorFunctionalDarkGray880,
        onSurface: ColorRawTokens.colorFunctionalLightGray160,
        onSurfaceVariant: ColorRawTokens.colorOpacityWhite640,

        /// Additional surface roles
        surfaceBright: ColorRawTokens.colorFunctionalDarkGray640,
        surfaceDim: ColorRawTokens.colorFunctionalDarkGray880,
        inverseSurface: ColorRawTokens.colorFunctionalLightGray160,
        onInverseSurface: ColorRawTokens.colorFunctionalBlack,

        /// Error colors
        error: ColorRawTokens.colorFunctionalScarlet300,
        onError: ColorRawTokens.colorFunctionalBlack,
        errorContainer: ColorRawTokens.colorFunctionalScarlet900,
        onErrorContainer: ColorRawTokens.colorFunctionalLightGray160,

        /// Outline and scrim colors
        outline: ColorRawTokens.colorFunctionalLightGray160,
        outlineVariant: ColorRawTokens.colorOpacityWhite200,
        scrim: ColorRawTokens.colorFunctionalBlack,

        /// Surface containers
        surfaceContainer: ColorRawTokens.colorFunctionalLightGray80,
        surfaceContainerHigh: ColorRawTokens.colorFunctionalLightGray80,
        surfaceContainerHighest: ColorRawTokens.colorFunctionalLightGray80,
        surfaceContainerLow: ColorRawTokens.colorFunctionalDarkGray880,
        surfaceContainerLowest: ColorRawTokens.colorFunctionalDarkGray880,
      );
}
