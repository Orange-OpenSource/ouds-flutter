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

// <a href="https://unified-design-system.orange.com/" class="external" target="_blank">**OUDS Switch design guidelines**</a>
/**
 * Switches allow the user to toggle between two states, typically "on" and "off". It is represented as a slider that changes its position or color to indicate
 * the current state. Switches are used to enable or disable features, options, or settings in an intuitive and visual manner.
 *
 * The **standalone switch variant** can be used when the switch selector control is nested within another component and an alternative label is provided.
 *
 * @see [OudsSwitchItem] If you want to use a switch with an associated label and other optional elements.
 *
 * @param checked Controls checked state of the switch.
 * @param onCheckedChange Callback invoked on switch click. If `null`, then this is passive and relies entirely on a higher-level component to control
 * the checked state.
 * @param modifier [Modifier] applied to the layout of the switch.
 * @param enabled Controls the enabled state of the switch. When `false`, this switch will not be clickable.
 * @param interactionSource Optional hoisted [MutableInteractionSource] for observing and emitting [Interaction]s for this switch. Note that if `null`
 * is provided, interactions will still happen internally.
 *
 * @sample com.orange.ouds.core.component.samples.OudsSwitchSample
 */

class OudsSwitch extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool>? onCheckedChange;
  final bool enabled;
  final Widget? modifier; // Flutter doesn't have Modifier, so replace with general widget if needed
  final FocusNode? focusNode;

  const OudsSwitch({
    super.key,
    required this.checked,
    this.onCheckedChange,
    this.enabled = true,
    this.modifier,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: checked,
      onChanged: enabled ? onCheckedChange : null,
      focusNode: focusNode,
    );
  }
}
