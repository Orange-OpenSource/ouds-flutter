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

/// Enum representing the state of the control.
enum OudsPinCodeInputControlState { hovered, focused, enabled }

/// A class that determines the state of the OudsPinCodeInput.
class OudsPinCodeInputControlStateDeterminer {
  final bool isHovered;
  final bool isFocused;
  final bool isEnabled;

  OudsPinCodeInputControlStateDeterminer({
    this.isHovered = false,
    this.isFocused = false,
    this.isEnabled = true
  });

  /// Determines the current material state of the control.
  OudsPinCodeInputControlState determineControlState() {
    if (isHovered) return OudsPinCodeInputControlState.hovered;
    if (isFocused) return OudsPinCodeInputControlState.focused;
    return OudsPinCodeInputControlState.enabled;
  }
}
