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

import 'package:ouds_theme_contract/ouds_tokens_provider.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_checkbox_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_controlItem_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_skeleton_tokens.dart';

class OudsComponentsTokens {
  final OudsButtonTokens button;
  final OudsCheckboxTokens checkbox;
  final OudsControlItemTokens controlItem;
  final OudsSkeletonTokens skeleton;

  OudsComponentsTokens({
    required OudsProvidersTokens providersTokens,
    OudsButtonTokens? button,
    OudsCheckboxTokens? checkbox,
    OudsControlItemTokens? controlItem,
    OudsSkeletonTokens? skeleton,
  })  : button = button ?? OudsButtonTokens(providersTokens: providersTokens),
        checkbox = checkbox ?? OudsCheckboxTokens(providersTokens: providersTokens),
        controlItem = controlItem ?? OudsControlItemTokens(providersTokens: providersTokens),
        skeleton = skeleton ?? OudsSkeletonTokens(providersTokens: providersTokens);
}
