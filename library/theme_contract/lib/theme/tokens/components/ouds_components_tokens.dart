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

import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_skeleton_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

class OudsComponentsTokens {
  final OudsButtonTokens button;
  final OudsSkeletonTokens skeleton;

  OudsComponentsTokens({
    required OudsColorSemanticTokens colorTokens,
    OudsButtonTokens? button,
    this.skeleton = const OudsSkeletonTokens(),
  }) : button = button ?? OudsButtonTokens(colorTokens: colorTokens);
}
