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

/// Enum representing the state of the chip/tag input control.
enum OudsChipTagControlState {
  enabled,
  hovered,
  pressed,
  disabled,
  focused,
}

/// A class that determines the state of the OudsChip OudsTagInput
class OudsChipTagControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isFocused;

  OudsChipTagControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isFocused = false,
  });

  /// Determines the current material state of the control.
  OudsChipTagControlState determineControlState() {
    if (!enabled) return OudsChipTagControlState.disabled;
    if (isPressed) return OudsChipTagControlState.pressed;
    if (isHovered) return OudsChipTagControlState.hovered;
    if (isFocused) return OudsChipTagControlState.focused;
    return OudsChipTagControlState.enabled;
  }
}
