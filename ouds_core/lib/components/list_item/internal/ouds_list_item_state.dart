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

/// Enum representing the interaction state of an [OudsListItem].
enum OudsListItemControlState { enabled, hovered, pressed, disabled, focused }

/// A class that determines the current state of an [OudsListItem].
class OudsListItemControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isFocused;

  OudsListItemControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isFocused = false,
  });

  /// Determines the current material state of the control.
  OudsListItemControlState determineControlState() {
    if (!enabled) return OudsListItemControlState.disabled;
    if (isPressed) return OudsListItemControlState.pressed;
    if (isHovered) return OudsListItemControlState.hovered;
    if (isFocused) return OudsListItemControlState.focused;
    return OudsListItemControlState.enabled;
  }
}
