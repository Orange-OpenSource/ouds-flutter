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
import 'package:ouds_flutter/theme-contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:ouds_flutter/theme-contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

/// Contract to create an OUDS-compliant theme.
///
/// Any values that are not defined will inherit from the default Orange theme.
abstract interface class OudsThemeContract {
  /// Theme display name.
  String get name;

  /// Color semantic tokens values used in the theme
  OudsColorSemanticTokens get colorTokens;

  OudsComponentsTokens get componentsTokens;

  /// Defines the configuration of the overall visual Theme for a MaterialApp or a widget subtree within the app
  ThemeData get themeData;
}
