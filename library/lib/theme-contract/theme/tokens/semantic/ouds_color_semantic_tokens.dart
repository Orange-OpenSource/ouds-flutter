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

import 'package:ouds_flutter/theme-contract/theme/tokens/semantic/ouds_color_action_semantic_tokens.dart';
import 'package:ouds_flutter/theme-contract/theme/tokens/semantic/ouds_color_bg_semantic_tokens.dart';

class OudsColorSemanticTokens {
  final OudsColorActionSemanticTokens actionColorTokens;
  final OudsColorBgSemanticTokens backgroundColorTokens;

  const OudsColorSemanticTokens({
    this.actionColorTokens = const OudsColorActionSemanticTokens(),
    this.backgroundColorTokens = const OudsColorBgSemanticTokens(),
  });
}
