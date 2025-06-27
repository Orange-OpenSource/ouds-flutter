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
import 'package:ouds_theme_contract/ouds_theme.dart';

import '../../control/internal/ouds_chip_control_state.dart';

/// Used to apply the right background color associated to the state
class OudsChipControlBackgroundColorModifier {

  final BuildContext context;

  OudsChipControlBackgroundColorModifier(this.context);

  Color getBackgroundColor(OudsChipControlState state){
    switch (state) {
      case OudsChipControlState.enabled:
        return _getEnabledBgColor(context);
      case OudsChipControlState.disabled:
        return _getDisabledBgColor(context);
      case OudsChipControlState.hovered:
        return _getHoverBgColor(context);
      case OudsChipControlState.pressed:
        return _getPressedBgColor(context);
      case OudsChipControlState.focused:
        return _getFocusBgColor(context);
      case OudsChipControlState.selected:
        return _getSelectedBgColor(context);
    }
  }

  static Color _getEnabledBgColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorBgUnselectedEnabled;
  }

  static Color _getDisabledBgColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorBgUnselectedDisabled;
  }
  static Color _getHoverBgColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorBgUnselectedHover;
  }

  static Color _getPressedBgColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorBgUnselectedPressed;
  }

  static Color _getFocusBgColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorBgUnselectedFocus;
  }

  static Color _getSelectedBgColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorBgSelectedEnabled;
  }

}