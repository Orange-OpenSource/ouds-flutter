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

import 'package:ouds_theme_contract/theme/tokens/components/ouds_accordion_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_alert_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_badge_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_bar_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_bulletList_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_buttonMono_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_checkbox_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_chip_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_controlItem_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_divider_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_icon_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_inputTag_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_linkMono_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_link_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_listItem_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_pinCodeInput_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_progressIndicatorMono_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_progressIndicator_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_radioButton_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_skeleton_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_switch_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_tag_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_textArea_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_textInput_tokens.dart';

class OudsComponentsTokens {
  final OudsAccordionTokens accordion;
  final OudsAlertTokens alert;
  final OudsBadgeTokens badge;
  final OudsBarTokens bar;
  final OudsBulletListTokens bulletList;
  final OudsButtonTokens button;
  final OudsButtonMonoTokens buttonMono;
  final OudsCheckboxTokens checkbox;
  final OudsChipTokens chip;
  @Deprecated(
    "This component is deprecated and will be replaced by control list item in a future version.",
  )
  final OudsControlItemTokens controlItem;
  final OudsDividerTokens divider;
  final OudsIconTokens icon;
  final OudsInputTagTokens inputTag;
  final OudsLinkTokens link;
  final OudsLinkMonoTokens linkMono;
  final OudsListItemTokens listItem;
  final OudsPinCodeInputTokens pinCodeInput;
  final OudsProgressIndicatorTokens progressIndicator;
  final OudsProgressIndicatorMonoTokens progressIndicatorMono;
  final OudsRadioButtonTokens radioButton;
  final OudsSkeletonTokens skeleton;
  final OudsSwitchTokens switchButton;
  final OudsTagTokens tag;
  final OudsTextAreaTokens textArea;
  final OudsTextInputTokens textInput;

  const OudsComponentsTokens({
    required this.accordion,
    required this.alert,
    required this.badge,
    required this.bar,
    required this.bulletList,
    required this.button,
    required this.buttonMono,
    required this.checkbox,
    required this.chip,
    required this.controlItem,
    required this.divider,
    required this.icon,
    required this.inputTag,
    required this.link,
    required this.linkMono,
    required this.listItem,
    required this.pinCodeInput,
    required this.progressIndicator,
    required this.progressIndicatorMono,
    required this.radioButton,
    required this.skeleton,
    required this.switchButton,
    required this.tag,
    required this.textArea,
    required this.textInput,
  });
}
