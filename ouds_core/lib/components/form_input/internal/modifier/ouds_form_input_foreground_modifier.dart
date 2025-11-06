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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right foreground color associated to the state
class OudsFormFieldsForegroundColorModifier {
  final BuildContext context;

  OudsFormFieldsForegroundColorModifier(this.context);

  Color getForegroundColor(OudsFormFieldsControlState state) {
    final theme = OudsTheme.of(context);

    switch (state) {
      case OudsFormFieldsControlState.enabled:
        return theme.colorScheme(context).actionNegativeEnabled;
      case OudsFormFieldsControlState.disabled:
        throw UnimplementedError("Error status for Disabled state is not relevant");
      case OudsFormFieldsControlState.hovered:
        return theme.colorScheme(context).actionNegativeHover;
      case OudsFormFieldsControlState.pressed:
        throw UnimplementedError();
      case OudsFormFieldsControlState.focused:
        return theme.colorScheme(context).actionNegativePressed;
      case OudsFormFieldsControlState.readOnly:
        throw UnimplementedError("Error status for Read only state is not relevant");
      case OudsFormFieldsControlState.loading:
        throw UnimplementedError("Error status for Loading state is not relevant");
    }
  }

  Color getIconColor(OudsFormFieldsControlState state) {
    final theme = OudsTheme.of(context);

    switch (state) {
      case OudsFormFieldsControlState.enabled:
        return theme.colorScheme(context).contentMuted;
      case OudsFormFieldsControlState.disabled:
        return theme.colorScheme(context).actionDisabled;
      case OudsFormFieldsControlState.hovered:
        return theme.colorScheme(context).contentMuted;
      case OudsFormFieldsControlState.pressed:
        throw UnimplementedError();
      case OudsFormFieldsControlState.focused:
        return theme.colorScheme(context).contentMuted;
      case OudsFormFieldsControlState.readOnly:
        return theme.colorScheme(context).contentMuted;
      case OudsFormFieldsControlState.loading:
        return theme.colorScheme(context).contentMuted;
    }
  }
}
