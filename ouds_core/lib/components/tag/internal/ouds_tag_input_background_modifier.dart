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
import 'package:ouds_core/components/tag/internal/ouds_tag_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the state
class OudsTagInputControlBackgroundColorModifier {
  final BuildContext context;

  OudsTagInputControlBackgroundColorModifier(this.context);

  Color? getBackgroundColor(OudsTagControlState state) {
    //todo modify when update tokenator
    final tagToken = OudsTheme.of(context).componentsTokens(context).chip;

    switch (state) {
      case OudsTagControlState.enabled:
        return tagToken.colorBgUnselectedEnabled;
      case OudsTagControlState.disabled:
        return tagToken.colorBgUnselectedDisabled;
      case OudsTagControlState.hovered:
        return tagToken.colorBgUnselectedHover;
      case OudsTagControlState.pressed:
        return tagToken.colorBgUnselectedPressed;
      case OudsTagControlState.focused:
        return tagToken.colorBgUnselectedFocus;
    }
  }
}
