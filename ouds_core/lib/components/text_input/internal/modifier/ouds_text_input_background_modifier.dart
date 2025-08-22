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
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the state
class OudsTextInputBackgroundColorModifier {
  final BuildContext context;

  OudsTextInputBackgroundColorModifier(this.context);

  Color? getBackgroundColor(OudsTextInputControlState state, [bool isError = false, OudsTextInputStyle? style]) {
    final theme = OudsTheme.of(context);
    final error = isError == true;

    final defaultStyle = style == OudsTextInputStyle.defaultStyle;

    if (error) {
      // Error
      switch (state) {
        case OudsTextInputControlState.enabled:
          return defaultStyle ? theme.colorScheme(context).surfaceStatusNegativeMuted : null;
        case OudsTextInputControlState.disabled:
          throw UnimplementedError("Error status for Disabled state is not relevant");
        case OudsTextInputControlState.hovered:
          return theme.colorScheme(context).surfaceStatusNegativeMuted;
        case OudsTextInputControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return defaultStyle ? theme.colorScheme(context).surfaceStatusNegativeMuted : null;
        case OudsTextInputControlState.readOnly:
          throw UnimplementedError("Error status for Read only state is not relevant");
        case OudsTextInputControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return defaultStyle ? theme.colorScheme(context).actionSupportEnabled : null;
        case OudsTextInputControlState.disabled:
          return theme.colorScheme(context).actionSupportDisabled;
        case OudsTextInputControlState.hovered:
          return theme.colorScheme(context).actionSupportHover;
        case OudsTextInputControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return defaultStyle ? theme.colorScheme(context).actionSupportPressed : null;
        case OudsTextInputControlState.readOnly:
          return defaultStyle ? null : theme.colorScheme(context).actionSupportDisabled;
        case OudsTextInputControlState.loading:
          return theme.colorScheme(context).actionSupportLoading;
      }
    }
  }

  // todo (should create a new class for pin code or create a controller for both text input and pin code input components)
  Color? getPinCodeBackgroundColor(OudsTextInputControlState state, [bool isError = false, OudsTextInputStyle? style]) {
    final theme = OudsTheme.of(context);
    final error = isError == true;

    final defaultStyle = style == OudsTextInputStyle.defaultStyle;

    if (error) {
      // Error
      switch (state) {
        case OudsTextInputControlState.enabled:
        case OudsTextInputControlState.hovered:
        case OudsTextInputControlState.focused:
          return defaultStyle ? theme.colorScheme(context).surfaceStatusNegativeMuted : null;
        case OudsTextInputControlState.disabled:
          throw UnimplementedError("Error status for Disabled state is not relevant");
        case OudsTextInputControlState.pressed:
          throw UnimplementedError("Error status for pressed state is not relevant");
        case OudsTextInputControlState.readOnly:
          throw UnimplementedError("Error status for Read only state is not relevant");
        case OudsTextInputControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return defaultStyle ? theme.colorScheme(context).actionSupportEnabled : null;
        case OudsTextInputControlState.disabled:
          return theme.colorScheme(context).actionSupportDisabled;
        case OudsTextInputControlState.hovered:
          return theme.colorScheme(context).actionSupportHover;
        case OudsTextInputControlState.pressed:
          throw UnimplementedError("Error status for pressed state is not relevant");
        case OudsTextInputControlState.focused:
          return defaultStyle ? theme.colorScheme(context).actionSupportPressed : null;
        case OudsTextInputControlState.readOnly:
          return defaultStyle ? null : theme.colorScheme(context).actionSupportDisabled;
        case OudsTextInputControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    }
  }
}
