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

///
/// [OUDS Switch Design Guidelines](https://unified-design-system.orange.com/472794e18/p/18acc0-switch)
///
/// The **Switch item variant** can function as a simple input with a label, or it can be combined with optional elements such as helper text,
/// additional  a divider, an outlined, or an icon, allowing it to suit various use cases.
///
/// The OUDS Switch item layout contains an [OudsSwitch]. By clicking on a Switch item, the user changes the selected state of its switch.
///
/// If you want to use a standalone switch please use [OudsSwitch].
///
/// Parameters:
/// - [value] The value represented by this switch. Used to determine selection.
/// - [onChanged] Callback triggered when the user selects this switch. If `null`, the switch is disabled and non-interactive.
/// - [isError] Indicates whether the switch is in an error state.
/// - [title]: The main label of the switch item.
/// - [helperTitle]: Optional text displayed below the label.
/// - [icon]: Optional icon displayed in the item. By default, it has a trailing position. If [reversed] is set to `true`, it is displayed as a leading element.
/// - [reversed]: When `false`, the switch has a leading position and the optional [icon] has a trailing position. Otherwise, it is reversed.
/// - [readOnly]: Controls the read only state of the switch item. When `true` the item's switch is disabled but the texts, the icon and the outlined remain in
///   enabled color. Note that if it is set to `true` and [enabled] is set to `false`, the switch item will be displayed in disabled state.
/// - [enabled]: Controls the enabled state of the switch item. When `false`, the switch, the texts and the optional icon are disabled, and the item
///   will not be clickable
/// - [divider]: Controls the display of a divider at the bottom of the switch item.
///
///
/// ## You can use [OudsSwitchItem] like this :
///
/// ### State enabled :
///
/// The default active state where the switch is functional and selectable.
/// It may show an unselected or selected style, with a label and helper text visible.
///
/// ```dart
///  OudsSwitchButtonItem(
///     value: true,
///     onChanged: (bool? value) {
///       /// Handle switch change state.
///     },
///    title: 'Label',
///     helperTitle: null,
///     reversed: false,
///     readOnly: false,
///     icon: null,
///     isError: false,
///     divider: true,
///     );
/// ```
///

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
        componentName: "OudsSwitchButtonItem",
        divider: divider,
        reversed: reversed,
        onTap: onChanged != null
            ? () {
                bool? newValue;
                newValue = !(value ?? false);
                onChanged!(newValue);
              }
            : null,
        indicator: () => OudsSwitch(
          value: value,
          onChanged: !readOnly && onChanged != null ? onChanged : null,
        ),
      ),
    );
  }
}
