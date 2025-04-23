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

import 'package:flutter/widgets.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

/// A class that provides the border color for the OudsCheckbox/OudsRadioButton/OudsSwitch based on its state and error status.
class OudsControlBorderModifier {
  final BuildContext context;

  OudsControlBorderModifier(this.context);

  /// Gets the border color based on the checkbox state and error status.
  Color getBorderColor(OudsControlState state, bool error, value) {
    final colorScheme = OudsTheme.of(context).colorsScheme;
    if (error) {
      // Error
      switch (state) {
        case OudsControlState.enabled:
          return colorScheme.actionNegativeEnabled;
        case OudsControlState.disabled:
          throw StateError("Not allowed, exception thrown at the beginning of OudsCheckbox");
        case OudsControlState.hovered:
          return colorScheme.actionNegativeHover;
        case OudsControlState.pressed:
          return colorScheme.actionNegativePressed;
        case OudsControlState.focused:
          return colorScheme.actionNegativeFocus;
      }
    } else {
      // Normal
      switch (state) {
        case OudsControlState.enabled:
          return value ? colorScheme.actionSelected : colorScheme.actionEnabled;
        case OudsControlState.disabled:
          return colorScheme.actionDisabled;
        case OudsControlState.hovered:
          return colorScheme.actionHover;
        case OudsControlState.pressed:
          return colorScheme.actionSelected;
        case OudsControlState.focused:
          return colorScheme.actionFocus;
      }
    }
  }

  /// Gets the border width based on the checkbox state.
  double getBorderWidth(OudsControlState state, value, token) {
    switch (state) {
      case OudsControlState.enabled:
        return value ? token.borderWidthSelected : token.borderWidthUnselected;
      case OudsControlState.disabled:
        return value ? token.borderWidthSelected : token.borderWidthUnselected;
      case OudsControlState.hovered:
        return value ? token.borderWidthSelectedHover : token.borderWidthUnselectedHover;
      case OudsControlState.pressed:
        return value ? token.borderWidthSelectedPressed : token.borderWidthUnselectedPressed;
      case OudsControlState.focused:
        return value ? token.borderWidthSelectedFocus : token.borderWidthUnselectedFocus;
    }
  }
}
