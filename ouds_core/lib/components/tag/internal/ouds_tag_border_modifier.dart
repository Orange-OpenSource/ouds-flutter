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

/// A class that provides the border color for the OudsTagInput based on its state
class OudsTagInputControlBorderModifier {
  final BuildContext context;

  OudsTagInputControlBorderModifier(this.context);

  /// Gets the borderSide based on the tag state
  BoxBorder getBorder(OudsChipTagControlState state) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).chip;
    //todo modify when update tokenator
      switch (state) {
        case OudsChipTagControlState.enabled:
          return Border.all(color: tagToken.colorBorderUnselectedEnabled!, width: tagToken.borderWidthUnselected!);
        case OudsChipTagControlState.disabled:
          return Border.all(color: tagToken.colorBorderUnselectedDisabled!, width: tagToken.borderWidthUnselected!);
        case OudsChipTagControlState.hovered:
          return Border.all(color: tagToken.colorBorderUnselectedHover!, width: tagToken.borderWidthUnselectedInteraction!);
        case OudsChipTagControlState.pressed:
          return Border.all(color: tagToken.colorBorderUnselectedPressed!, width: tagToken.borderWidthUnselectedInteraction!);
        case OudsChipTagControlState.focused:
          return Border.all(color: tagToken.colorBorderUnselectedFocus!, width: tagToken.borderWidthUnselectedInteraction!);
      }
    }

}
