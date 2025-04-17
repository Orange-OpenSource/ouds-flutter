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
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

/// A class that provides the tick color for the OudsCheckbox/OudsRadioButton/OudsSwitch based on its state and error status.
class OudsControlTickModifier {
  final BuildContext context;

  OudsControlTickModifier(this.context);

  /// Gets the tick color based on the control state and error status.
  Color getTickColor(OudsControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorsScheme;

    if (error) {
      switch (state) {
        case OudsControlState.enabled:
          return colorsScheme.actionNegativeEnabled; // Color for enabled state with error
        case OudsControlState.disabled:
          throw StateError("Color not allowed for disabled state"); // Handle disabled state
        case OudsControlState.hovered:
          return colorsScheme.actionNegativeHover; // Color for hovered state with error
        case OudsControlState.pressed:
          return colorsScheme.actionNegativePressed; // Color for pressed state with error
        case OudsControlState.focused:
          return colorsScheme.actionNegativeFocus; // Color for focused state with error
      }
    } else {
      switch (state) {
        case OudsControlState.enabled:
          return colorsScheme.actionSelected; // Color for selected state
        case OudsControlState.disabled:
          return colorsScheme.actionDisabled; // Color for disabled state
        case OudsControlState.hovered:
          return colorsScheme.actionHover; // Color for hovered state
        case OudsControlState.pressed:
          return colorsScheme.actionPressed; // Color for pressed state
        case OudsControlState.focused:
          return colorsScheme.actionFocus; // Color for focused state
      }
    }
  }
}
