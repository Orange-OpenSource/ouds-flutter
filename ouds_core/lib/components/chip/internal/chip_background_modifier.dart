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

/// Used to apply the right background color associated to the state
class OudsChipControlBackgroundColorModifier {

  final BuildContext context;

  OudsChipControlBackgroundColorModifier(this.context);

  Color getBackgroundColor(OudsChipControlState state){

    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    switch (state) {
      case OudsChipControlState.enabled:
        return chipToken.colorBgUnselectedEnabled;
      case OudsChipControlState.disabled:
        return chipToken.colorBgUnselectedDisabled;
      case OudsChipControlState.hovered:
        return chipToken.colorBgUnselectedHover;
      case OudsChipControlState.pressed:
        return chipToken.colorBgUnselectedPressed;
      case OudsChipControlState.focused:
        return chipToken.colorBgUnselectedFocus;
      case OudsChipControlState.selected:
        return chipToken.colorBgSelectedEnabled;
    }
  }
}