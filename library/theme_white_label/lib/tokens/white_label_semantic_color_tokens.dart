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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_white_label/tokens/white_label_raw_color_tokens.dart';

OudsColorSemanticTokens get whiteLabelSemanticColorTokens {
  return const OudsColorSemanticTokens(
    backgroundColorTokens: OudsColorBgSemanticTokens(
      bgPrimaryLight: Color(0xFF8DB3E0),
      bgPrimaryDark: Color(0xFF6E8DFA),
      bgSecondaryLight: WhiteLabelRawColorTokens.secondary40,
      bgSecondaryDark: WhiteLabelRawColorTokens.secondary80,
    ),
  );
}
