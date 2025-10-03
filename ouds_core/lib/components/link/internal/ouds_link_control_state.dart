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

/// Enum representing the state of the Link control.
enum OudsLinkControlState {
  enabled,
  hovered,
  pressed,
  disabled,
  focused,
}

/// A class that determines the state of the OudsLink
class OudsLinkControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isFocused;

  OudsLinkControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isFocused = false,
  });

  /// Determines the current material state of the control.
  OudsLinkControlState determineControlState() {
    if (!enabled) return OudsLinkControlState.disabled;
    if (isPressed) return OudsLinkControlState.pressed;
    if (isHovered) return OudsLinkControlState.hovered;
    if (isFocused) return OudsLinkControlState.focused;
    return OudsLinkControlState.enabled;
  }
}
