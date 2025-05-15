//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:ouds_core/components/utilities/ouds_switch_icon.dart';
import 'package:ouds_core/ouds_theme.dart';

/// OUDS OudsListSwitch.
///
/// The OudsListSwitch widget represents a switch list element that can be checked or unchecked.
/// It allows for handling the OudsListSwitch list state and triggering a callback when its state changes.
/// * [value] determines whether this switch is on or off.
/// * [onChanged] is called when the user toggles the switch on or off.
class OudsListSwitch extends StatelessWidget {
  /// Creates an OUDS Switch list.
  const OudsListSwitch({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.icon,
    this.enabled = true,
  });

  /// The primary content of the list tile.
  final String title;

  /// Determines whether this switch is on or off.
  final bool value;

  /// A callback function to handle changes in the checked state.
  final void Function(bool)? onChanged;

  /// The icon to use on the thumb of this switch.
  final bool? icon;

  /// Controls the enabled state of the switch. When false, this button will not be clickable.
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    String switchValue =
        value ? 'Checked' : 'Unchecked';

    OudsSwitchIcon oudsSwitchIcon = OudsSwitchIcon(context);

    return Semantics(
      label: title,
      value: switchValue,
      enabled: enabled,
      button: true,
      excludeSemantics: true,
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: OudsTheme.of(context).fontTokens.sizeBodyLargeMobile,
            fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
            letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingBodyLargeMobile,
          ),
        ),
        value: value,
        onChanged: enabled != false ? onChanged : null,
        thumbIcon: icon == true ? oudsSwitchIcon.thumbIcon : null,
      ),
    );
  }
}
