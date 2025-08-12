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

/// Enum representing the state of the tag control.
enum OudsTagControlState {
  enabled,
  hovered,
  pressed,
  disabled,
  focused,
}

/// A class that determines the state of the OudsTag
class OudsTagControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isFocused;

  OudsTagControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isFocused = false,
  });

  /// Determines the current material state of the control.
  OudsTagControlState determineControlState() {
    if (!enabled) return OudsTagControlState.disabled;
    if (isPressed) return OudsTagControlState.pressed;
    if (isHovered) return OudsTagControlState.hovered;
    if (isFocused) return OudsTagControlState.focused;
    return OudsTagControlState.enabled;
  }
}
