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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the border color for the OudsChip based on its state and selection
class OudsTextInputBorderModifier {
  final BuildContext context;

  OudsTextInputBorderModifier(this.context);

  /// Gets the borderSide based on the chip state and whether it is selected
  BorderSide getBorder(OudsTextInputControlState state, [bool isError = false]) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    if (isError) {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault);
        case OudsTextInputControlState.disabled:
          throw UnimplementedError("Error status for Disabled state is not relevant");
        case OudsTextInputControlState.hovered:
          return BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault);
        case OudsTextInputControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthDefault);
        case OudsTextInputControlState.readOnly:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return BorderSide(color: textInput.colorBorderEnabled, width: textInput.borderWidthDefault);
        case OudsTextInputControlState.disabled:
          return BorderSide(color: theme.colorScheme(context).actionDisabled, width: textInput.borderWidthDefault);
        case OudsTextInputControlState.hovered:
          return BorderSide(color: textInput.colorBorderHover, width: textInput.borderWidthDefault);
        case OudsTextInputControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return BorderSide(color: textInput.colorBorderFocus, width: textInput.borderWidthDefault);
        case OudsTextInputControlState.readOnly:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.loading:
          return BorderSide(color: textInput.colorBorderLoading, width: textInput.borderWidthDefault);
      }
    }
  }
}
