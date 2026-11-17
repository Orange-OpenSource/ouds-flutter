/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 *
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 *
 * // Software description: Flutter library of reusable graphical components
 *
 */

/// @nodoc
library;

/// Represents the interaction state of an [OudsListItem] or [OudsSmallListItem].
///
/// Exposed to custom content builders (`labelContent`, `belowTextContent`,
/// `bottomContent`, leading/trailing `Content` slots) so they can adapt their
/// appearance to the current interaction state.
enum OudsListItemControlState {
  /// Default interactive state.
  enabled,

  /// A pointer is hovering over the item.
  hovered,

  /// The item is being pressed.
  pressed,

  /// The item is disabled (`enable = false`).
  disabled,

  /// The item has keyboard focus.
  focused,
}

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
