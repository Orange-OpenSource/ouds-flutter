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

/// Enum representing the different possible states of an Ouds button.
enum OudsButtonControlState {
  enabled, // The button is enabled and interactive.
  hovered, // The cursor is over the button.
  pressed, // The button is being pressed.
  disabled, // The button is disabled and non-interactive.
  loading,
}

/// This class used only for icon button.
/// Class that determines the current state of an Ouds button based on its properties.
class OudsButtonControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isLoading;

  /// Constructor to initialize the button state.
  /// [enabled] is required, [isHovered] and [isPressed] default to false.
  OudsButtonControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isLoading = false,
  });

  /// Method that determines the current state of the button based on its properties.
  /// Returns a value from the OudsButtonControlState enum.
  OudsButtonControlState determineControlState() {
    if (!enabled) return OudsButtonControlState.disabled;
    if (isPressed) return OudsButtonControlState.pressed;
    if (isHovered) return OudsButtonControlState.hovered;
    if (isLoading) return OudsButtonControlState.loading;
    return OudsButtonControlState.enabled;
  }
}
