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

    if (isError) {
      switch (state) {
        case OudsTextInputControlState.enabled:
          //return Border.all(color: textInput.colorBorderSelectedEnabled, width: textInput.borderWidthSelected);
          return BorderSide(
            color: textInput.colorBorderEnabled,
            width: textInput.borderWidthDefault,
          );
        case OudsTextInputControlState.disabled:
          return BorderSide(color: textInput.colorBorderSelectedDisabled, width: textInput.borderWidthSelected);
        case OudsTextInputControlState.hovered:
          return BorderSide(color: textInput.colorBorderSelectedHover, width: textInput.borderWidthSelected);
        case OudsTextInputControlState.pressed:
          return BorderSide(color: textInput.colorBorderSelectedPressed, width: textInput.borderWidthSelected);
        case OudsTextInputControlState.focused:
          return BorderSide(color: textInput.colorBorderSelectedFocus, width: textInput.borderWidthSelected);
        case OudsTextInputControlState.readOnly:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return BorderSide(color: textInput.colorBorderUnselectedEnabled, width: textInput.borderWidthUnselected);
        case OudsTextInputControlState.disabled:
          return BorderSide(color: textInput.colorBorderUnselectedDisabled, width: textInput.borderWidthUnselected);
        case OudsTextInputControlState.hovered:
          return BorderSide(color: textInput.colorBorderUnselectedHover, width: textInput.borderWidthUnselectedInteraction);
        case OudsTextInputControlState.pressed:
          return BorderSide(color: textInput.colorBorderUnselectedPressed, width: textInput.borderWidthUnselectedInteraction);
        case OudsTextInputControlState.focused:
          return BorderSide(color: textInput.colorBorderUnselectedFocus, width: textInput.borderWidthUnselectedInteraction);
        case OudsTextInputControlState.readOnly:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }
  }
}
