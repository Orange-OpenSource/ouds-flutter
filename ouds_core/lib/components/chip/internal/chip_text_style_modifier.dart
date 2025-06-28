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

class OudsChipControlTextColorModifier {
  final BuildContext context;

  OudsChipControlTextColorModifier(this.context);

  Color getTextColor(OudsChipControlState state) {
    switch (state) {
      case OudsChipControlState.enabled:
        return _getEnabledTextColor(context);
      case OudsChipControlState.disabled:
        return _getDisabledTextColor(context);
      case OudsChipControlState.hovered:
        return _getHoverTextColor(context);
      case OudsChipControlState.pressed:
        return _getPressedTextColor(context);
      case OudsChipControlState.focused:
        return _getFocusTextColor(context);
    }
  }

  static Color _getEnabledTextColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedEnabled;
  }

  static Color _getDisabledTextColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedDisabled;
  }

  static Color _getHoverTextColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedHover;
  }

  static Color _getPressedTextColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedPressed;
  }

  static Color _getFocusTextColor(BuildContext context) {
    return OudsTheme.of(context).componentsTokens(context).chip.colorContentUnselectedFocus;
  }
}
