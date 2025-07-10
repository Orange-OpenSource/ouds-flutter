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

/// Enum representing the state of the chip control.
enum OudsChipControlState {
  enabled,
  hovered,
  pressed,
  disabled,
  focused,
  selected
}

/// A class that determines the state of the OudsChip
class OudsChipControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isFocused;
  final bool isSelected;

  OudsChipControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isFocused = false,
    this.isSelected = false,

  });

  /// Determines the current material state of the control.
  OudsChipControlState determineControlState() {
    if (!enabled) return OudsChipControlState.disabled;
    if (isPressed) return OudsChipControlState.pressed;
    if (isHovered) return OudsChipControlState.hovered;
    if (isFocused) return OudsChipControlState.focused;
    if (isSelected) return OudsChipControlState.selected;
    return OudsChipControlState.enabled;
  }
}
