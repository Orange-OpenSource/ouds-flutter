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

import 'package:ouds_theme_contract/theme/scheme/color/ouds_color_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_space_scheme.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_elevation_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_font_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_opacity_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_size_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_space_semantic_tokens.dart';

/// [OudsProvidersTokens] is a container class that holds the theme-related tokens for color, border, and font.
/// It provides access to different theme tokens like [OudsColorScheme], [OudsBorderSemanticTokens], and [OudsFontSemanticTokens] etc,
/// which are used to apply the appropriate styling across the application.
/// This class allows easy access to the semantic tokens for the theme, ensuring consistent design application.

class OudsProvidersTokens {
  final OudsColorScheme colorScheme;
  final OudsOpacitySemanticTokens opacityTokens;
  final OudsBorderSemanticTokens borderTokens;
  final OudsElevationSemanticTokens elevationTokens;
  final OudsSpaceSemanticTokens spaceTokens;
  final OudsSpaceScheme spaceScheme;
  final OudsSizeSemanticTokens sizeTokens;
  final OudsFontSemanticTokens fontTokens;

  OudsProvidersTokens({
    required this.colorScheme,
    required this.opacityTokens,
    required this.borderTokens,
    required this.elevationTokens,
    required this.spaceTokens,
    required this.spaceScheme,
    required this.sizeTokens,
    required this.fontTokens,
  });
}
