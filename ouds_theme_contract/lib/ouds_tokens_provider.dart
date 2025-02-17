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

import 'package:ouds_theme_contract/ouds_color_scheme.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_font_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_opacity_semantic_tokens.dart';

/// [OudsProvidersTokens] is a container class that holds the theme-related tokens for color, border, and font.
/// It provides access to different theme tokens like [OudsColorScheme], [OudsBorderSemanticTokens], and [OudsFontSemanticTokens] etc,
/// which are used to apply the appropriate styling across the application.
/// This class allows easy access to the semantic tokens for the theme, ensuring consistent design application.

class OudsProvidersTokens {
  final OudsColorScheme colorScheme;
  final OudsOpacitySemanticTokens opacityTokens;
  final OudsBorderSemanticTokens borderTokens;
  final OudsFontSemanticTokens fontTokens;

  OudsProvidersTokens({
    required this.colorScheme,
    required this.opacityTokens,
    required this.borderTokens,
    required this.fontTokens,
  });
}
