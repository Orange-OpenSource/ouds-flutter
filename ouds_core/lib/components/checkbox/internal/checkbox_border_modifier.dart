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
import 'package:ouds_core/components/checkbox/internal/checkbox_state.dart';
import 'package:ouds_core/ouds_theme.dart';

/// A class that provides the border color for the OudsCheckbox based on its state and error status.
class CheckboxBorderModifier {
  final BuildContext context;

  CheckboxBorderModifier(this.context);

  /// Gets the border color based on the checkbox state and error status.
  Color getBorderColor(OudsCheckboxMaterialState state, bool error, value) {
    final colorScheme = OudsTheme.of(context).colorsScheme;
    if (error) {
      // Error
      switch (state) {
        case OudsCheckboxMaterialState.enabled:
          return colorScheme.actionNegativeEnabled;
        case OudsCheckboxMaterialState.disabled:
          throw StateError("Not allowed, exception thrown at the beginning of OudsCheckbox");
        case OudsCheckboxMaterialState.hovered:
          return colorScheme.actionNegativeHover;
        case OudsCheckboxMaterialState.pressed:
          return colorScheme.actionNegativePressed;
        case OudsCheckboxMaterialState.focused:
          return colorScheme.actionNegativeFocus;
      }
    } else {
      // Normal
      switch (state) {
        case OudsCheckboxMaterialState.enabled:
          return value ? colorScheme.actionSelected : colorScheme.actionEnabled;
        case OudsCheckboxMaterialState.disabled:
          return colorScheme.actionDisabled;
        case OudsCheckboxMaterialState.hovered:
          return colorScheme.actionHover;
        case OudsCheckboxMaterialState.pressed:
          return colorScheme.actionSelected;
        case OudsCheckboxMaterialState.focused:
          return colorScheme.actionFocus;
      }
    }
  }

  /// Gets the border width based on the checkbox state.
  double getBorderWidth(OudsCheckboxMaterialState state, value) {
    final checkbox = OudsTheme.of(context).componentsTokens.checkbox;

    switch (state) {
      case OudsCheckboxMaterialState.enabled:
        return value ? checkbox.borderWidthSelected : checkbox.borderWidthUnselected;
      case OudsCheckboxMaterialState.disabled:
        return value ? checkbox.borderWidthSelected : checkbox.borderWidthUnselected;
      case OudsCheckboxMaterialState.hovered:
        return value ? checkbox.borderWidthSelectedHover : checkbox.borderWidthUnselectedHover;
      case OudsCheckboxMaterialState.pressed:
        return value ? checkbox.borderWidthSelectedPressed : checkbox.borderWidthUnselectedPressed;
      case OudsCheckboxMaterialState.focused:
        return value ? checkbox.borderWidthSelectedFocus : checkbox.borderWidthUnselectedFocus;
    }
  }
}
