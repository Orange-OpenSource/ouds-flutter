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

enum OudsCheckboxMaterialState {
  enabled,
  hovered,
  pressed,
  focused,
  disabled,
}

/// A class that determines the state of the OudsCheckbox.
class CheckboxStateDeterminer {
  final bool enabled;
  final bool isPressed;
  final bool isHovered;

  CheckboxStateDeterminer({
    required this.enabled,
    required this.isPressed,
    required this.isHovered,
  });

  /// Determines the current material state of the checkbox.
  OudsCheckboxMaterialState determineCheckboxState() {
    if (!enabled) {
      return OudsCheckboxMaterialState.disabled;
    } else if (isPressed) {
      return OudsCheckboxMaterialState.pressed;
    } else if (isHovered) {
      return OudsCheckboxMaterialState.hovered;
    } else {
      return OudsCheckboxMaterialState.enabled;
    }
  }
}
