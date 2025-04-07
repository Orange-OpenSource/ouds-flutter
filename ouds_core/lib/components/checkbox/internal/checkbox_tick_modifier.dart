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
import 'package:ouds_core/components/checkbox/internal/checkbox_state.dart';
import 'package:ouds_core/ouds_theme.dart';

/// A class that provides the tick color for the OudsCheckbox based on its state and error status.
class CheckboxTickModifier {
  final BuildContext context;

  CheckboxTickModifier(this.context);

  /// Gets the tick color based on the checkbox state and error status.
  Color getTickColor(OudsCheckboxMaterialState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorsScheme;

    if (error) {
      switch (state) {
        case OudsCheckboxMaterialState.enabled:
          return colorsScheme.actionNegativeEnabled; // Color for enabled state with error
        case OudsCheckboxMaterialState.disabled:
          throw StateError("Color not allowed for disabled state"); // Handle disabled state
        case OudsCheckboxMaterialState.hovered:
          return colorsScheme.actionNegativeHover; // Color for hovered state with error
        case OudsCheckboxMaterialState.pressed:
          return colorsScheme.actionNegativePressed; // Color for pressed state with error
        case OudsCheckboxMaterialState.focused:
          return colorsScheme.actionNegativeFocus; // Color for focused state with error
      }
    } else {
      switch (state) {
        case OudsCheckboxMaterialState.enabled:
          return colorsScheme.actionSelected; // Color for selected state
        case OudsCheckboxMaterialState.disabled:
          return colorsScheme.actionDisabled; // Color for disabled state
        case OudsCheckboxMaterialState.hovered:
          return colorsScheme.actionHover; // Color for hovered state
        case OudsCheckboxMaterialState.pressed:
          return colorsScheme.actionPressed; // Color for pressed state
        case OudsCheckboxMaterialState.focused:
          return colorsScheme.actionFocus; // Color for focused state
      }
    }
  }
}
