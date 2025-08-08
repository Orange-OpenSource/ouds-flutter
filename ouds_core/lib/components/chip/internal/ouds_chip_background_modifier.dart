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
import 'package:ouds_core/components/chip/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the state
class OudsChipControlBackgroundColorModifier {
  final BuildContext context;

  OudsChipControlBackgroundColorModifier(this.context);

  Color? getBackgroundColor(OudsChipControlState state, [bool isSelected = false]) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    final selected = isSelected == true;

    switch (state) {
      case OudsChipControlState.enabled:
        return selected ? chipToken.colorBgSelectedEnabled : chipToken.colorBgUnselectedEnabled;
      case OudsChipControlState.disabled:
        return selected ? chipToken.colorBgSelectedDisabled : chipToken.colorBgUnselectedDisabled;
      case OudsChipControlState.hovered:
        return selected ? chipToken.colorBgSelectedHover : chipToken.colorBgUnselectedHover;
      case OudsChipControlState.pressed:
        return selected ? chipToken.colorBgSelectedPressed : chipToken.colorBgUnselectedPressed;
      case OudsChipControlState.focused:
        return selected ? chipToken.colorBgSelectedFocus : chipToken.colorBgUnselectedFocus;
    }
  }
}
