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
library;

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/chip/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsChipControlTextColorModifier {
  final BuildContext context;

  OudsChipControlTextColorModifier(this.context);

  /// Returns the text color based on chip state and selection
  Color? getTextColor(OudsChipControlState state, bool isHighContrast, [bool isSelected = false]) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    final highContrastColor = OudsTheme.of(context).colorScheme(context).contentDefault;

    if (isSelected) {
      switch (state) {
        case OudsChipControlState.enabled:
        // In order to reach the a11y AAA level, the text of selected chip is black
          return isHighContrast? highContrastColor : chipToken.colorContentSelectedEnabled;
        case OudsChipControlState.disabled:
          return chipToken.colorContentSelectedDisabled;
        case OudsChipControlState.hovered:
          return chipToken.colorContentSelectedHover;
        case OudsChipControlState.pressed:
          return chipToken.colorContentSelectedPressed;
        case OudsChipControlState.focused:
          return chipToken.colorContentSelectedFocus;
      }
    } else {
      switch (state) {
        case OudsChipControlState.enabled:
        // In order to reach the a11y AAA level, the text of chip is black
          return isHighContrast ? highContrastColor : chipToken.colorContentUnselectedEnabled;
        case OudsChipControlState.disabled:
          return chipToken.colorContentUnselectedDisabled;
        case OudsChipControlState.hovered:
          return chipToken.colorContentUnselectedHover;
        case OudsChipControlState.pressed:
          return chipToken.colorContentUnselectedPressed;
        case OudsChipControlState.focused:
          return chipToken.colorContentUnselectedFocus;
      }
    }
  }
}
