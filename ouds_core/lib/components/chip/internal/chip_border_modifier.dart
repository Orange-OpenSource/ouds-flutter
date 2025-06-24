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
import 'package:ouds_core/components/control/internal/ouds_chip_control_state.dart';


/// A class that provides the border color for the OudsChip based on its state
class OudsChipControlBorderModifier {
  final BuildContext context;

  OudsChipControlBorderModifier(this.context);

  /// Gets the borderSide based on the indicator state
  BoxBorder getBorder(OudsChipControlState state) {
      switch (state) {
        case OudsChipControlState.enabled:
          return _getEnabledBorderColor(context);
        case OudsChipControlState.disabled:
          return _getDisabledBorderColor(context);
        case OudsChipControlState.hovered:
          return _getHoverBorderColor(context);
        case OudsChipControlState.pressed:
          return _getPressedBorderColor(context);
        case OudsChipControlState.focused:
          return _getFocusBorderColor(context);
      }

  }

  static BoxBorder _getEnabledBorderColor(BuildContext context) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    return Border.all(
        color: chipToken.colorBorderUnselected,
        width: chipToken.borderWidthUnselected
    );

  }

  static BoxBorder _getHoverBorderColor(BuildContext context) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    return Border.all(
        color: chipToken.colorBorderHover,
        width: chipToken.borderWidthUnselectedInteraction
    );
  }

  static BoxBorder _getPressedBorderColor(BuildContext context) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    return Border.all(
        color: chipToken.colorBorderPressed,
        width: chipToken.borderWidthUnselectedInteraction
    );

  }

  static BoxBorder _getDisabledBorderColor(BuildContext context) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    return Border.all(
        color: chipToken.colorBorderDisabled,
        width: chipToken.borderWidthUnselected
    );

  }

  static BoxBorder _getFocusBorderColor(BuildContext context) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    return Border.all(
        color: chipToken.colorBorderFocus,
        width: chipToken.borderWidthUnselectedInteraction
    );

  }
}
