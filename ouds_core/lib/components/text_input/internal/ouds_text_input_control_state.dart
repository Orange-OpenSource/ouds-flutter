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

/// Enum representing the state of the control.
enum OudsTextInputControlState {
  enabled,
  hovered,
  pressed,
  disabled,
  focused,
  readOnly,
}

/// A class that determines the state of the OudsCheckbox/OudsRadioButton/OudsSwitch.
class OudsTextInputControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isReadOnly;
  final bool isFocused;

  OudsTextInputControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isReadOnly = false,
    this.isFocused = false,
  });

  /// Determines the current material state of the control.
  OudsTextInputControlState determineControlState() {
    if (!enabled) return OudsTextInputControlState.disabled;
    if (isPressed) return OudsTextInputControlState.pressed;
    if (isHovered) return OudsTextInputControlState.hovered;
    if (isFocused) return OudsTextInputControlState.focused;
    if (isReadOnly) return OudsTextInputControlState.readOnly;
    return OudsTextInputControlState.enabled;
  }
}
