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

/// Enum representing the state of the control item.
enum OudsControlItemState {
  enabled,
  hovered,
  pressed,
  disabled,
  focused,
  readOnly,
}

/// A class that determines the state of the item.
class OudsControlItemStateDeterminer {
  final bool enabled;
  final bool isPressed;
  final bool isHovered;
  final bool isReadOnly;

  OudsControlItemStateDeterminer({
    required this.enabled,
    required this.isPressed,
    required this.isHovered,
    required this.isReadOnly,
  });

  /// Determines the current material state of the control item.
  OudsControlItemState determineControlItemState() {
    if (!enabled) return OudsControlItemState.disabled;
    if (isReadOnly) return OudsControlItemState.readOnly;
    if (isPressed) return OudsControlItemState.pressed;
    if (isHovered) return OudsControlItemState.hovered;
    return OudsControlItemState.enabled;
  }
}
