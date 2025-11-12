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

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/pin_code_input/internal/ouds_pin_code_input_control_state.dart';

/// A class that provides the border color for the OudsPinCodeInput based on its state and selection
class OudsPinCodeInputBorderModifier {
  final BuildContext context;

  OudsPinCodeInputBorderModifier(this.context);

  /// Gets the borderSide based on the pin code input state and whether it is selected
  Border getPinCodeBorder(OudsPinCodeInputControlState state, [bool isError = false, bool? isOutlined]) {
      switch (state) {
        case OudsPinCodeInputControlState.enabled:
          return Border(
            bottom: getPinCodeBorderSideByState(state,isError),
            top: !isOutlined! ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            left: !isOutlined ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            right: !isOutlined ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
          );
        case OudsPinCodeInputControlState.hovered:
          return Border(
            bottom: getPinCodeBorderSideByState(state,isError),
            top: !isOutlined! ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            left: !isOutlined ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            right: !isOutlined ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
          );
        case OudsPinCodeInputControlState.focused:
          return Border(
            bottom: getPinCodeBorderSideByState(state,isError),
            top: !isOutlined! ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            left: !isOutlined ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
            right: !isOutlined ? BorderSide.none : getPinCodeBorderSideByState(state,isError),
          );
      }
  }

  /// Returns a [BorderSide] based on the given [OudsPinCodeInputControlState].
  ///
  /// Uses [OudsTheme] to pick the border color and width for each state for PinCodeInput
  BorderSide getPinCodeBorderSideByState(OudsPinCodeInputControlState state, bool isError) {
    final textInputToken = OudsTheme.of(context).componentsTokens(context).textInput;
    final colorToken = OudsTheme.of(context).colorScheme(context);

    switch (state) {
      case OudsPinCodeInputControlState.enabled:
        return isError? BorderSide(color: colorToken.actionNegativeEnabled, width: textInputToken.borderWidthDefault)
            : BorderSide(color: textInputToken.colorBorderEnabled, width: textInputToken.borderWidthDefault);
      case OudsPinCodeInputControlState.hovered:
        return isError? BorderSide(color: colorToken.actionNegativeEnabled, width: textInputToken.borderWidthDefault)
            : BorderSide(color: textInputToken.colorBorderHover, width: textInputToken.borderWidthDefault);
      case OudsPinCodeInputControlState.focused:
        return isError? BorderSide(color: colorToken.actionNegativeEnabled, width: textInputToken.borderWidthDefault)
            : BorderSide(color: textInputToken.colorBorderFocus, width: textInputToken.borderWidthFocus);
    }
  }
}
