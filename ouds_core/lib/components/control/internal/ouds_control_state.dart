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
enum OudsControlState {
  enabled,
  hovered,
  pressed,
  disabled,
  focused,
  readOnly,
}

/// A class that determines the state of the OudsCheckbox/OudsRadioButton/OudsSwitch.
class OudsControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isReadOnly;

  OudsControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isReadOnly = false,
  });

  /// Determines the current material state of the control.
  OudsControlState determineControlState() {
    if (!enabled) return OudsControlState.disabled;
    if (isPressed) return OudsControlState.pressed;
    if (isHovered) return OudsControlState.hovered;
    if (isReadOnly) return OudsControlState.readOnly;
    return OudsControlState.enabled;
  }
}
