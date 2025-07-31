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
class OudsTagInputControlBackgroundColorModifier {
  final BuildContext context;

  OudsTagInputControlBackgroundColorModifier(this.context);

  Color? getBackgroundColor(OudsChipTagControlState state) {
    //todo modify when update tokenator
    final tagToken = OudsTheme.of(context).componentsTokens(context).chip;

    switch (state) {
      case OudsChipTagControlState.enabled:
        return tagToken.colorBgUnselectedEnabled;
      case OudsChipTagControlState.disabled:
        return tagToken.colorBgUnselectedDisabled;
      case OudsChipTagControlState.hovered:
        return tagToken.colorBgUnselectedHover;
      case OudsChipTagControlState.pressed:
        return tagToken.colorBgUnselectedPressed;
      case OudsChipTagControlState.focused:
        return tagToken.colorBgUnselectedFocus;
    }
  }
}
