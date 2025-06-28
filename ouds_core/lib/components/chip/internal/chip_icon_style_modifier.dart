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

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/control/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsChipControlIconColorModifier {
  final BuildContext context;

  OudsChipControlIconColorModifier(this.context);

  Color getIconColor(OudsChipControlState state) {
    switch (state) {
      case OudsChipControlState.enabled:
        return _getEnabledIconColor(context);
      case OudsChipControlState.disabled:
        return _getDisabledIconColor(context);
      case OudsChipControlState.hovered:
        return _getHoverIconColor(context);
      case OudsChipControlState.pressed:
        return _getPressedIconColor(context);
      case OudsChipControlState.focused:
        return _getFocusIconColor(context);
    }
  }

  static Color _getEnabledIconColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedEnabled;
  }

  static Color _getDisabledIconColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedDisabled;
  }

  static Color _getHoverIconColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedHover;
  }

  static Color _getPressedIconColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedPressed;
  }

  static Color _getFocusIconColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedFocus;
  }
}
