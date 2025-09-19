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
library ouds_internal;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the border color for the OudsPinCodeInput based on its state and selection
class OudsPinCodeInputBorderModifier {
  final BuildContext context;

  OudsPinCodeInputBorderModifier(this.context);

  /// Gets the borderSide based on the pin code input state and whether it is selected
  Border getPinCodeBorder(OudsTextInputControlState state, [bool isError = false, OudsTextInputStyle? style]) {
    final defaultStyle = style == OudsTextInputStyle.defaultStyle;
      switch (state) {
        case OudsTextInputControlState.enabled:
          return Border(
            bottom: getPinCodeBorderSideByState(state,isError),
            top: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            left: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            right: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
          );
        case OudsTextInputControlState.disabled:
          return Border(
            bottom: getPinCodeBorderSideByState(state,isError),
            top: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            left: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            right: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
          );
        case OudsTextInputControlState.hovered:
          return Border(
            bottom: getPinCodeBorderSideByState(state,isError),
            top: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            left: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            right: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
          );
        case OudsTextInputControlState.focused:
          return Border(
            bottom: getPinCodeBorderSideByState(state,isError),
            top: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            left: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            right: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
          );
        case OudsTextInputControlState.readOnly:
          return Border(
            bottom: getPinCodeBorderSideByState(state,isError),
            top: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            left: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            right: defaultStyle ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
          );
        case OudsTextInputControlState.pressed:
          throw UnimplementedError(
              "Error status for pressed state is not relevant");
        case OudsTextInputControlState.loading:
          throw UnimplementedError(
              "Error status for loading state is not relevant");
      }
  }

  /// Returns a [BorderSide] based on the given [OudsTextInputControlState].
  ///
  /// Uses [OudsTheme] to pick the border color and width for each state for PinCodeInput
  BorderSide getPinCodeBorderSideByState(OudsTextInputControlState state, bool isError) {
    final textInputToken = OudsTheme.of(context).componentsTokens(context).textInput;
    final colorToken = OudsTheme.of(context).colorScheme(context);

    switch (state) {
      case OudsTextInputControlState.enabled:
        return isError? BorderSide(color: colorToken.actionNegativeEnabled, width: textInputToken.borderWidthDefault)
            : BorderSide(color: textInputToken.colorBorderEnabled, width: textInputToken.borderWidthDefault);
      case OudsTextInputControlState.disabled:
        return isError?  throw UnimplementedError("Error status for disabled state is not relevant")
            :BorderSide(color: colorToken.actionDisabled, width: textInputToken.borderWidthDefault);
      case OudsTextInputControlState.hovered:
        return isError? BorderSide(color: colorToken.actionNegativeEnabled, width: textInputToken.borderWidthDefault)
            : BorderSide(color: textInputToken.colorBorderHover, width: textInputToken.borderWidthDefault);
      case OudsTextInputControlState.focused:
        return isError? BorderSide(color: colorToken.actionNegativeEnabled, width: textInputToken.borderWidthDefault)
            : BorderSide(color: textInputToken.colorBorderFocus, width: textInputToken.borderWidthFocus);
      case OudsTextInputControlState.readOnly:
        return isError?  throw UnimplementedError("Error status for readOnly state is not relevant")
            :BorderSide(color: colorToken.borderMuted, width: textInputToken.borderWidthDefault);
      case OudsTextInputControlState.pressed:
        throw UnimplementedError("Error status for pressed state is not relevant");
      case OudsTextInputControlState.loading:
        throw UnimplementedError("Error status for loading state is not relevant");
    }
  }

}
