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

/// @nodoc
library;

/// Enum representing the state of the control.
enum OudsFormFieldsControlState { enabled, hovered, pressed, disabled, focused, readOnly, loading }

/// A class that determines the state of the OudsTextInput.
class OudsFormFieldsControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;
  final bool isReadOnly;
  final bool isFocused;
  final bool isLoading;

  OudsFormFieldsControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
    this.isReadOnly = false,
    this.isFocused = false,
    this.isLoading = false,
  });

  /// Determines the current material state of the control.
  OudsFormFieldsControlState determineControlState() {
    if (!enabled) return OudsFormFieldsControlState.disabled;
    if (isPressed) return OudsFormFieldsControlState.pressed;
    if (isHovered) return OudsFormFieldsControlState.hovered;
    if (isFocused) return OudsFormFieldsControlState.focused;
    if (isReadOnly) return OudsFormFieldsControlState.readOnly;
    if (isLoading) return OudsFormFieldsControlState.loading;
    return OudsFormFieldsControlState.enabled;
  }
}
