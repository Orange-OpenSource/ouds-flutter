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
import 'package:ouds_core/components/form_input/internal/ouds_form_input_control_state.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_enum.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the state
class OudsFormFieldsBackgroundColorModifier {
  final BuildContext context;

  OudsFormFieldsBackgroundColorModifier(this.context);

  Color? getBackgroundColor(OudsFormFieldsControlState state, [bool isError = false, OudsFormFieldsStyle? style]) {
    final theme = OudsTheme.of(context);
    final error = isError == true;

    final defaultStyle = style == OudsFormFieldsStyle.defaultStyle;

    if (error) {
      // Error
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return defaultStyle ? theme.colorScheme(context).surfaceStatusNegativeMuted : null;
        case OudsFormFieldsControlState.disabled:
          throw UnimplementedError("Error status for Disabled state is not relevant");
        case OudsFormFieldsControlState.hovered:
          return theme.colorScheme(context).surfaceStatusNegativeMuted;
        case OudsFormFieldsControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsFormFieldsControlState.focused:
          return defaultStyle ? theme.colorScheme(context).surfaceStatusNegativeMuted : null;
        case OudsFormFieldsControlState.readOnly:
          throw UnimplementedError("Error status for Read only state is not relevant");
        case OudsFormFieldsControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return defaultStyle ? theme.colorScheme(context).actionSupportEnabled : null;
        case OudsFormFieldsControlState.disabled:
          return theme.colorScheme(context).actionSupportDisabled;
        case OudsFormFieldsControlState.hovered:
          return theme.colorScheme(context).actionSupportHover;
        case OudsFormFieldsControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsFormFieldsControlState.focused:
          return defaultStyle ? theme.colorScheme(context).actionSupportPressed : null;
        case OudsFormFieldsControlState.readOnly:
          return defaultStyle ? null : theme.colorScheme(context).actionSupportDisabled;
        case OudsFormFieldsControlState.loading:
          return theme.colorScheme(context).actionSupportLoading;
      }
    }
  }
}
