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

import 'package:ouds_theme_contract/theme/tokens/components/ouds_badge_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_buttonMono_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_checkbox_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_chip_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_controlItem_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_divider_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_pinCodeInput_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_radioButton_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_skeleton_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_switch_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_tagInput_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_tag_tokens.dart';

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
  final OudsBadgeTokens badge;
  final OudsTagTokens tag;
  final OudsTagInputTokens tagInput;
  final OudsPinCodeInputTokens pinCodeInput;

  const OudsComponentsTokens({
    required this.button,
    required this.buttonMono,
    required this.checkbox,
    required this.controlItem,
    required this.radioButton,
    required this.divider,
    required this.skeleton,
    required this.switchButton,
    required this.chip,
    required this.badge,
    required this.tag,
    required this.tagInput,
    required this.pinCodeInput
  });
}
