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
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_checkbox_tokens.dart';

/// A class that provides the border color for the OudsCheckbox/OudsRadioButton/OudsSwitch based on its state and error status.
class OudsControlBorderModifier {
  final BuildContext context;

  OudsControlBorderModifier(this.context);

  /// Gets the border color based on the checkbox state and error status.
  Color getBorderColor(OudsControlState state, bool error, bool selected) {
    final colorScheme = OudsTheme.of(context).colorScheme;
    if (error) {
      // Error
      switch (state) {
        case OudsControlState.enabled:
          return colorScheme(context).actionNegativeEnabled;
        case OudsControlState.disabled:
          throw StateError("Color not allowed for disabled state when error is true");
        case OudsControlState.hovered:
          return colorScheme(context).actionNegativeHover;
        case OudsControlState.pressed:
          return colorScheme(context).actionNegativePressed;
        case OudsControlState.focused:
          return colorScheme(context).actionNegativeFocus;
        case OudsControlState.readOnly:
          throw StateError("Color not allowed for readOnly state when error is true");
      }
    } else {
      // Normal
      //print(state);
      switch (state) {
        case OudsControlState.enabled:
          if (selected) {
            // In order to reach the a11y AAA level, the selected checkbox is black
            return (MediaQuery.highContrastOf(context)) ? colorScheme(context).contentDefault : colorScheme(context).actionSelected;
          } else {
            return colorScheme(context).actionEnabled;
          }
        case OudsControlState.disabled:
          return colorScheme(context).actionDisabled;
        case OudsControlState.hovered:
          return colorScheme(context).actionHover;
        case OudsControlState.pressed:
          // In order to reach the a11y AAA level, the pressed checkbox is black
          return (MediaQuery.highContrastOf(context)) ? colorScheme(context).contentDefault : colorScheme(context).actionSelected;
        case OudsControlState.focused:
          return colorScheme(context).actionFocus;
        case OudsControlState.readOnly:
          return colorScheme(context).actionDisabled;
      }
    }
  }

  /// Gets the border width based on the checkbox state.
  double getBorderWidth(OudsControlState state, bool selected, token) {
    switch (state) {
      case OudsControlState.enabled:
        return selected ? token.borderWidthSelected : token.borderWidthUnselected;
      case OudsControlState.disabled:
        return selected ? token.borderWidthSelected : token.borderWidthUnselected;
      case OudsControlState.hovered:
        return selected ? token.borderWidthSelectedHover : token.borderWidthUnselectedHover;
      case OudsControlState.pressed:
        return selected ? token.borderWidthSelectedPressed : token.borderWidthUnselectedPressed;
      case OudsControlState.focused:
        return selected ? token.borderWidthSelectedFocus : token.borderWidthUnselectedFocus;
      case OudsControlState.readOnly:
        return selected ? token.borderWidthSelected : token.borderWidthUnselected;
    }
  }

  /// Gets the border radius based on the checkbox.
  double getBorderRadius(OudsCheckboxTokens checkboxTokens) {
    return checkboxTokens.borderRadius;
  }
}
