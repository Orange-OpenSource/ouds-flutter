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
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the tick color for the OudsCheckbox/OudsRadioButton/OudsSwitch based on its state and error status.
class OudsControlTextModifier {
  final BuildContext context;

  OudsControlTextModifier(this.context);

  /// Gets the text color based on the control state and error status.
  Color getTextColor(OudsControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    if (error) {
      switch (state) {
        case OudsControlState.enabled:
          return colorsScheme(context).actionNegativeEnabled; // Color for enabled state with error
        case OudsControlState.disabled:
          throw StateError("Color not allowed for disabled state when error is true"); // Handle disabled state
        case OudsControlState.hovered:
          return colorsScheme(context).actionNegativeHover; // Color for hovered state with error
        case OudsControlState.pressed:
          return colorsScheme(context).actionNegativePressed; // Color for pressed state with error
        case OudsControlState.focused:
          return colorsScheme(context).actionNegativeFocus; // Color for focused state with error
        case OudsControlState.readOnly:
          throw StateError("Color not allowed for readOnly state when error is true"); // Handle readOnly state
      }
    } else {
      switch (state) {
        case OudsControlState.enabled:
          return colorsScheme(context).contentDefault; // Color for selected state
        case OudsControlState.disabled:
          return colorsScheme(context).contentDisabled; // Color for disabled state
        case OudsControlState.hovered:
          return colorsScheme(context).contentDefault; // Color for hovered state
        case OudsControlState.pressed:
          return colorsScheme(context).contentDefault; // Color for pressed state
        case OudsControlState.focused:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsControlState.readOnly:
          return colorsScheme(context).contentDefault; // Color for readOnly state
      }
    }
  }

  /// Gets the helper text color based on the control state status.
  Color getHelperTextColor(OudsControlState state) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    switch (state) {
      case OudsControlState.enabled:
        return colorsScheme(context).contentMuted; // Color for selected state
      case OudsControlState.disabled:
        return colorsScheme(context).contentDisabled; // Color for disabled state
      case OudsControlState.hovered:
        return colorsScheme(context).contentMuted; // Color for hovered state
      case OudsControlState.pressed:
        return colorsScheme(context).contentMuted; // Color for pressed state
      case OudsControlState.focused:
        return colorsScheme(context).contentMuted; // Color for focused state
      case OudsControlState.readOnly:
        return colorsScheme(context).contentMuted; // Color for readOnly state
    }
  }

  /// Gets the additional text color based on the control state status.
  Color getAdditionalTextColor(OudsControlState state) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    switch (state) {
      case OudsControlState.enabled:
        return colorsScheme(context).contentDefault; // Color for selected state
      case OudsControlState.disabled:
        return colorsScheme(context).contentDisabled; // Color for disabled state
      case OudsControlState.hovered:
        return colorsScheme(context).contentDefault; // Color for hovered state
      case OudsControlState.pressed:
        return colorsScheme(context).contentDefault; // Color for pressed state
      case OudsControlState.focused:
        return colorsScheme(context).contentDefault; // Color for focused state
      case OudsControlState.readOnly:
        return colorsScheme(context).contentDefault; // Color for readOnly state
    }
  }
}
