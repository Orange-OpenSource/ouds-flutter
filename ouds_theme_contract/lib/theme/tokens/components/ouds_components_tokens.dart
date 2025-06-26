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
import 'package:ouds_theme_contract/theme/tokens/components/ouds_buttonMono_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_checkbox_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_controlItem_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_divider_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_radioButton_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_skeleton_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_switch_tokens.dart';

import 'ouds_chip_tokens.dart';

class OudsComponentsTokens {
  final OudsButtonTokens button;
  final OudsButtonMonoTokens buttonMono;
  final OudsCheckboxTokens checkbox;
  final OudsControlItemTokens controlItem;
  final OudsRadioButtonTokens radioButton;
  final OudsDividerTokens divider;
  final OudsSkeletonTokens skeleton;
  final OudsSwitchTokens switchButton;
  final OudsChipTokens chip;

  OudsComponentsTokens({
    required OudsProvidersTokens providersTokens,
    OudsButtonTokens? button,
    OudsButtonMonoTokens? buttonMono,
    OudsCheckboxTokens? checkbox,
    OudsControlItemTokens? controlItem,
    OudsRadioButtonTokens? radioButton,
    OudsDividerTokens? divider,
    OudsSkeletonTokens? skeleton,
    OudsSwitchTokens? switchButton,
    OudsChipTokens? chip,
  })  : button = button ?? OudsButtonTokens(providersTokens: providersTokens),
        buttonMono = buttonMono ?? OudsButtonMonoTokens(providersTokens: providersTokens),
        radioButton = radioButton ?? OudsRadioButtonTokens(providersTokens: providersTokens),
        checkbox = checkbox ?? OudsCheckboxTokens(providersTokens: providersTokens),
        controlItem = controlItem ?? OudsControlItemTokens(providersTokens: providersTokens),
        skeleton = skeleton ?? OudsSkeletonTokens(providersTokens: providersTokens),
        divider = divider ?? OudsDividerTokens(providersTokens: providersTokens),
        switchButton = switchButton ?? OudsSwitchTokens(providersTokens: providersTokens),
        chip = chip ?? OudsChipTokens(providersTokens: providersTokens);
}
