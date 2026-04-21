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
import 'package:ouds_core/components/switch/ouds_switch_item.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// A widget that displays the content of the theme settings dialog.
///
/// This widget provides switches to control theme-related settings, such as
/// enabling or disabling rounded corners for buttons and text inputs.
class ThemeSettingsDialogContent extends StatelessWidget {
  const ThemeSettingsDialogContent({
    super.key,
    required this.buttonRoundedConfig,
    required this.textInputRoundedConfig,
    required this.onButtonRoundedChanged,
    required this.onTextInputRoundedChanged,
  });

  final bool buttonRoundedConfig;
  final bool textInputRoundedConfig;
  final ValueChanged<bool> onButtonRoundedChanged;
  final ValueChanged<bool> onTextInputRoundedChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        OudsSwitchButtonItem(
          title: context.l10n.app_themeSettingsDialog_roundedCornerButtons_label,
          value: buttonRoundedConfig,
          onChanged: onButtonRoundedChanged,
        ),
        OudsSwitchButtonItem(
          title: context.l10n.app_themeSettingsDialog_roundedCornerTextInputs_label,
          value: textInputRoundedConfig,
          onChanged: onTextInputRoundedChanged,
        ),
      ],
    );
  }
}