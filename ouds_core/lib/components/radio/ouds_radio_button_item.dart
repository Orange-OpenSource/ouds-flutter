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
import 'package:ouds_core/components/radio/ouds_radio_button.dart';

class OudsRadioButtonItem<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final String title;
  final String? additionalLabel;
  final String? helperTitle;
  final String? icon;
  final bool outlined;
  final bool reversed;
  final bool readOnly;
  final bool isError;
  final bool enabled;
  final bool divider;

  const OudsRadioButtonItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.additionalLabel,
    this.helperTitle,
    this.icon,
    this.outlined = false,
    this.reversed = false,
    this.readOnly = false,
    this.isError = false,
    this.enabled = true,
    this.divider = false,

  });

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {

    return Semantics(
      selected: _selected,
      readOnly: readOnly,
      child: OudsControlItem(
        text: title,
        additionalText: additionalLabel,
        helperText: helperTitle,
        icon: icon,
        error: isError,
        readOnly: readOnly,
        errorComponentName: "OudsRadioButtonItem",
        divider: divider,
        outlined: _selected == true ? outlined : false,
        reversed: reversed,
        onTap: onChanged != null
            ? () => onChanged!(value)
            : null,
        indicator: () => OudsRadioButton<T>(
          value: value,
          groupValue: groupValue,
          onChanged: !readOnly && onChanged != null ? onChanged : null,
          isError: isError,
        ),
      ),
    );
  }
}

