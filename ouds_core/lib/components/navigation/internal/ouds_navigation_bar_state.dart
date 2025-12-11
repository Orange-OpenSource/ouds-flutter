/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

/// @nodoc
library;

/// Enum representing the state of the Navigation Bar control.
enum OudsNavigationBarControlState {
  enabled,
  hovered,
  pressed,
  focused,
}

/// A class that determines the state of the OudsLink
class OudsNavigationBarControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isFocused;

  OudsNavigationBarControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isFocused = false,
  });

  /// Determines the current material state of the control.
  OudsNavigationBarControlState determineControlState() {
    if (isPressed) return OudsNavigationBarControlState.pressed;
    if (isHovered) return OudsNavigationBarControlState.hovered;
    if (isFocused) return OudsNavigationBarControlState.focused;
    return OudsNavigationBarControlState.enabled;
  }
}
