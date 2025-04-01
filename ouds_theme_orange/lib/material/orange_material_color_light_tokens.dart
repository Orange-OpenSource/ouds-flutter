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

/// [OrangeMaterialColorLightTokens] is a class that defines a light color scheme specifically for the OUDS design system.
/// This color scheme is tailored for the [Light] mode theme and includes colors for primary, secondary, tertiary roles,
/// background, surface, error states, outlines, and scrim colors. It is intended for use in the UI components
/// of the application when the [Light] theme is enabled, ensuring a consistent design aligned with the brand's visual identity.
///
/// The color values are retrieved from the [ColorRawTokens], which store raw color values for functional use.
/// This class provides a static method `colorScheme` that returns the fully constructed [Light] theme [ColorScheme],
/// which can be directly applied in Flutter's Material Design components when the [Light] mode is active.
class OrangeMaterialColorLightTokens {
  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.light,

        /// Colors for primary roles
        primary: ColorRawTokens.colorFunctionalBlack,
        onPrimary: ColorRawTokens.colorFunctionalLightGray160,
        primaryContainer: ColorRawTokens.colorFunctionalBlack,
        onPrimaryContainer: ColorRawTokens.colorFunctionalWhite,
        onPrimaryFixed: ColorRawTokens.colorFunctionalWhite,
        onPrimaryFixedVariant: ColorRawTokens.colorFunctionalWhite,
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
        surface: ColorRawTokens.colorFunctionalWhite,
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
