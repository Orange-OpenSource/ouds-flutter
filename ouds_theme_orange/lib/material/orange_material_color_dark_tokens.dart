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

/// [OrangeMaterialColorDarkTokens] is a class that defines a dark color scheme specifically for the OUDS design system.
/// This color scheme is tailored for the [Dark] mode theme and includes colors for primary, secondary, tertiary roles,
/// background, surface, error states, outlines, and scrim colors. It is intended for use in the UI components
/// of the application when the [Dark] theme is enabled, ensuring a consistent design aligned with the brand's visual identity.
///
/// The color values are retrieved from the [ColorRawTokens], which store raw color values for functional use.
/// This class provides a static method `colorScheme` that returns the fully constructed [Dark] theme [ColorScheme],
/// which can be directly applied in Flutter's Material Design components when the [Dark] mode is active.
class OrangeMaterialColorDarkTokens {
  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.dark,

        /// Colors for primary roles
        primary: ColorRawTokens.colorFunctionalLightGray160,
        onPrimary: ColorRawTokens.colorFunctionalBlack,
        primaryContainer: ColorRawTokens.colorFunctionalLightGray160,
        onPrimaryContainer: ColorRawTokens.colorFunctionalBlack,
        onPrimaryFixed: ColorRawTokens.colorFunctionalWhite,
        onPrimaryFixedVariant: ColorRawTokens.colorFunctionalWhite,
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
        surface: ColorRawTokens.colorFunctionalDarkGray880,
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
        surfaceContainer: ColorRawTokens.colorFunctionalDarkGray800,
        surfaceContainerHigh: ColorRawTokens.colorFunctionalLightGray80,
        surfaceContainerHighest: ColorRawTokens.colorFunctionalLightGray80,
        surfaceContainerLow: ColorRawTokens.colorFunctionalDarkGray880,
        surfaceContainerLowest: ColorRawTokens.colorFunctionalDarkGray880,
      );
}
