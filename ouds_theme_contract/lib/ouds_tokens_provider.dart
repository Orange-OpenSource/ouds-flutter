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

class OudsProvidersTokens {
  final OudsColorScheme colorScheme;
  final OudsBorderSemanticTokens borderTokens;
  final OudsFontSemanticTokens fontTokens;

  OudsProvidersTokens({
    required this.colorScheme,
    required this.borderTokens,
    required this.fontTokens,
  });
}
