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

/// Used to apply the right background color associated to the state
class OudsTextInputBackgroundColorModifier {
  final BuildContext context;

  OudsTextInputBackgroundColorModifier(this.context);

  Color? getBackgroundColor(OudsTextInputControlState state, [bool isError = false]) {
    final theme = OudsTheme.of(context);
    final error = isError == true;

    if (error) {
      // Error
      switch (state) {
        case OudsTextInputControlState.enabled:
          return theme.colorScheme(context).surfaceStatusNegativeMuted;
        case OudsTextInputControlState.disabled:
          // TODO: Handle this case.
          throw UnimplementedError("Error status for Disabled state is not relevant");
        case OudsTextInputControlState.hovered:
          return theme.colorScheme(context).surfaceStatusNegativeMuted;
        case OudsTextInputControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return theme.colorScheme(context).surfaceStatusNegativeMuted;
        case OudsTextInputControlState.readOnly:
          // TODO: Handle this case.
          throw UnimplementedError("Error status for Read only state is not relevant");
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return theme.colorScheme(context).actionSupportEnabled;
        case OudsTextInputControlState.disabled:
          return theme.colorScheme(context).actionSupportDisabled;
        case OudsTextInputControlState.hovered:
          return theme.colorScheme(context).actionSupportHover;
        case OudsTextInputControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return theme.colorScheme(context).actionSupportPressed;
        case OudsTextInputControlState.readOnly:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }
  }
}
