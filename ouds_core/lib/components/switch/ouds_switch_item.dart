/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:flutter/material.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';
import 'package:ouds_core/components/switch/ouds_switch.dart';

class OudsSwitchButtonItem extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String title;
  final String? helperTitle;
  final String? icon;
  final bool reversed;
  final bool readOnly;
  final bool isError;
  final bool enabled;
  final bool divider;

  const OudsSwitchButtonItem({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.helperTitle,
    this.icon,
    this.reversed = false,
    this.readOnly = false,
    this.isError = false,
    this.enabled = true,
    this.divider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      readOnly: readOnly,
      child: OudsControlItem(
        text: title,
        helperText: helperTitle,
        icon: icon,
        error: isError,
        readOnly: readOnly,
        errorComponentName: "OudsSwitchButtonItem",
        divider: divider,
        reversed: reversed,
        onTap: onChanged != null ? () => onChanged!(value) : null,
        indicator: () => OudsSwitch(
          value: value,
          onChanged: !readOnly && onChanged != null ? onChanged : null,
        ),
      ),
    );
  }
}
