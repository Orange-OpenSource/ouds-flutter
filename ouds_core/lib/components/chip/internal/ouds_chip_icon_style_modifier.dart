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

class OudsChipControlIconColorModifier {
  final BuildContext context;

  OudsChipControlIconColorModifier(this.context);

  /// Returns the icon color based on chip state and selection
  Color getIconColor(OudsChipControlState state, bool isHighContrast,[bool isSelected = false]) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    final highContrastColor = OudsTheme.of(context).colorScheme(context).contentDefault;

    // Assuming selected icon color == tick color
    switch (state) {
      case OudsChipControlState.enabled:
      // In order to reach the a11y AAA level, the selected icon chip is black
        return isSelected ? (isHighContrast
            ? highContrastColor
            : chipToken.colorContentSelectedEnabled) : chipToken.colorContentUnselectedEnabled;
      case OudsChipControlState.disabled:
        return isSelected ? chipToken.colorContentSelectedDisabled : chipToken.colorContentUnselectedDisabled;
      case OudsChipControlState.hovered:
        return isSelected ? chipToken.colorContentSelectedHover : chipToken.colorContentUnselectedHover;
      case OudsChipControlState.pressed:
        return isSelected ? chipToken.colorContentSelectedPressed : chipToken.colorContentUnselectedPressed;
      case OudsChipControlState.focused:
        return isSelected ? chipToken.colorContentSelectedFocus : chipToken.colorContentUnselectedFocus;
    }
  }

  /// Returns the tick color (always used when selected)
  Color getTickColor(OudsChipControlState state, bool isHighContrast) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    final highContrastColor = OudsTheme.of(context).colorScheme(context).contentDefault;

    switch (state) {
      case OudsChipControlState.enabled:
      // In order to reach the a11y AAA level, the tick icon chip is black
        return isHighContrast ? highContrastColor : chipToken.colorContentSelectedTickEnabled;
      case OudsChipControlState.disabled:
        return chipToken.colorContentSelectedDisabled;
      case OudsChipControlState.hovered:
        return chipToken.colorContentSelectedHover;
      case OudsChipControlState.pressed:
        return chipToken.colorContentSelectedPressed;
      case OudsChipControlState.focused:
        return chipToken.colorContentSelectedFocus;
    }
  }
}
