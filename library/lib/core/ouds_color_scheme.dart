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

// Define color constants for various colors used across the themes
const orange100 = Color(0xffff7900);
const orange200 = Color(0xfff16e00);
const white100 = Color(0xffffffff);
const black900 = Color(0xff000000);
const grey200 = Color(0xffEEEEEE);
const grey300 = Color(0xffDDDDDD);
const grey400 = Color(0xffCCCCCC);
const grey500 = Color(0xff999999);
const grey600 = Color(0xff666666);
const grey800 = Color(0xff333333);
const grey900 = Color(0xFF212121);
const negative100 = Color(0xffD53F15);
const Color negative200 = Color(0xFFB00020);
const obsGrey700 = Color(0xff595959);
const darkSurfaceDefault = Color(0xff121212);

/// Orange Light Theme Color Scheme
///
/// Defines a color scheme for the light theme, using shades of orange, black, and white for various elements of the UI.
const lightOrangeColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: orange200,
  onPrimary: black900,
  primaryContainer: Color(0xFFFFDBCA),
  onPrimaryContainer: Color(0xFF331200),
  secondary: black900,
  onSecondary: white100,
  secondaryContainer: grey800,
  onSecondaryContainer: white100,
  tertiary: grey600,
  onTertiary: white100,
  tertiaryContainer: grey200,
  onTertiaryContainer: black900,
  error: negative200,
  onError: white100,
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  outline: black900,
  surface: white100,
  onSurface: black900,
  onSurfaceVariant: black900,
  inverseSurface: Color(0xFF362F2C),
  onInverseSurface: white100,
  inversePrimary: Color(0xFFFFB68E),
  shadow: black900,
  surfaceTint: Color(0xFF9C4500),
  outlineVariant: Color(0xFFD7C2B9),
  scrim: grey900,
);

/// Orange Dark Theme Color Scheme
///
/// Defines a color scheme for the dark theme, using darker shades of orange, black, and grey for various UI elements.
const darkOrangeColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: orange100,
  onPrimary: black900,
  primaryContainer: Color(0xFF773300),
  onPrimaryContainer: Color(0xFFFFDBCA),
  secondary: white100,
  onSecondary: black900,
  secondaryContainer: grey400,
  onSecondaryContainer: black900,
  tertiary: grey400,
  onTertiary: black900,
  tertiaryContainer: grey900,
  onTertiaryContainer: white100,
  error: negative200,
  onError: white100,
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  outline: grey200,
  surface: black900,
  onSurface: grey200,
  surfaceVariant: black900,
  onSurfaceVariant: grey200,
  inverseSurface: grey200,
  onInverseSurface: black900,
  inversePrimary: Color(0xFF9C4500),
  shadow: white100,
  surfaceTint: Color(0xFFFFB68E),
  outlineVariant: Color(0xFF52443C),
  scrim: obsGrey700,
);

/// Inverse Light Theme Color Scheme
///
/// Defines a color scheme for the light inverse theme, which inverts certain colors (such as primary, secondary, and background).
/// It uses more muted tones, appropriate for light-themed applications with dark elements.
const lightInverseColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF9C4500),
  onPrimary: white100,
  primaryContainer: Color(0xFF332100),
  onPrimaryContainer: Color(0xFFFFDBCA),
  secondary: grey200,
  onSecondary: black900,
  secondaryContainer: grey400,
  onSecondaryContainer: black900,
  tertiary: grey600,
  onTertiary: white100,
  tertiaryContainer: grey800,
  onTertiaryContainer: black900,
  error: negative100,
  onError: white100,
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  outline: black900,
  surface: white100,
  onSurface: black900,
  onSurfaceVariant: black900,
  inverseSurface: Color(0xFF362F2C),
  onInverseSurface: white100,
  inversePrimary: Color(0xFFFFB68E),
  shadow: black900,
  surfaceTint: Color(0xFF9C4500),
  outlineVariant: Color(0xFFD7C2B9),
  scrim: grey900,
);

/// Inverse Dark Theme Color Scheme
///
/// Defines a color scheme for the dark inverse theme, which inverts certain colors while providing a dark mode with muted, darker tones
const darkInverseColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF9C4500),
  onPrimary: white100,
  primaryContainer: Color(0xFF773300),
  onPrimaryContainer: Color(0xFFFFDBCA),
  secondary: grey400,
  onSecondary: black900,
  secondaryContainer: grey800,
  onSecondaryContainer: black900,
  tertiary: grey600,
  onTertiary: white100,
  tertiaryContainer: grey900,
  onTertiaryContainer: black900,
  error: negative100,
  onError: white100,
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  outline: grey200,
  surface: black900,
  onSurface: grey200,
  surfaceVariant: black900,
  onSurfaceVariant: grey200,
  inverseSurface: grey200,
  onInverseSurface: black900,
  inversePrimary: Color(0xFFFFB68E),
  shadow: white100,
  surfaceTint: Color(0xFFFFB68E),
  outlineVariant: Color(0xFF52443C),
  scrim: obsGrey700,
);
