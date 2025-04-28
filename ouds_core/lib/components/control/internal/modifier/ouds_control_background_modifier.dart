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
import 'package:ouds_core/components/control/internal/ouds_control_item_state.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

/// A class that provides the background color for the OudsCheckbox/OudsRadioButton/OudsSwitch based on its state.
class OudsControlBackgroundModifier {
  final BuildContext context;

  OudsControlBackgroundModifier(this.context);

  /// Gets the background color based on the control state.
  Color getBackgroundColor(state) {
    final controlItem = OudsTheme.of(context).componentsTokens.controlItem;
    switch (state) {
      case OudsControlState.hovered:
        return controlItem.colorBgHover;
      case OudsControlState.pressed:
        return controlItem.colorBgPressed;
      case OudsControlState.disabled:
        return Colors.transparent;
      case OudsControlState.enabled:
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

  /// Gets the background color based on the control state.
  Color getBackgroundItemColor(state) {
    final controlItem = OudsTheme.of(context).componentsTokens.controlItem;
    switch (state) {
      case OudsControlItemState.hovered:
        return controlItem.colorBgHover;
      case OudsControlItemState.pressed:
        return controlItem.colorBgPressed;
      case OudsControlItemState.disabled:
        return Colors.transparent;
      case OudsControlItemState.enabled:
        return Colors.transparent;
      case OudsControlItemState.readOnly:
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }
}
