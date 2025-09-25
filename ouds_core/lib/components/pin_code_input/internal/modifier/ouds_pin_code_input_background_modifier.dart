//
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
import 'package:flutter/material.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/pin_code_input/internal/ouds_pin_code_input_control_state.dart';

/// Used to apply the right background color associated to the state
class OudsPinCodeInputBackgroundColorModifier {
  final BuildContext context;

  OudsPinCodeInputBackgroundColorModifier(this.context);

  Color? getPinCodeBackgroundColor(OudsPinCodeInputControlState state, [bool isError = false, OudsTextInputStyle? style]) {
    final theme = OudsTheme.of(context);
    final error = isError == true;

    final defaultStyle = style == OudsTextInputStyle.defaultStyle;

    if (error) {
      // Error
      switch (state) {
        case OudsPinCodeInputControlState.enabled:
        case OudsPinCodeInputControlState.hovered:
        case OudsPinCodeInputControlState.focused:
          return defaultStyle ? theme.colorScheme(context).surfaceStatusNegativeMuted : null;
      }
    } else {
      switch (state) {
        case OudsPinCodeInputControlState.enabled:
          return defaultStyle ? theme.colorScheme(context).actionSupportEnabled : null;
        case OudsPinCodeInputControlState.hovered:
          return theme.colorScheme(context).actionSupportHover;
        case OudsPinCodeInputControlState.focused:
          return defaultStyle ? theme.colorScheme(context).actionSupportPressed : null;

      }
    }
  }
}
