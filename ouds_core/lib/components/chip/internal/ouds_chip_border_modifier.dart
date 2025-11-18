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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/chip/internal/ouds_chip_control_state.dart';
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the border color for the OudsChip based on its state and selection
class OudsChipControlBorderModifier {
  final BuildContext context;

  OudsChipControlBorderModifier(this.context);

  /// Gets the borderSide based on the chip state and whether it is selected
  Border? getBorder(OudsChipControlState state, [bool isSelected = false]) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    if (isSelected) {
      switch (state) {
        case OudsChipControlState.enabled:
          return OudsBorder().borderAll(color: chipToken.colorBorderSelectedEnabled, width: chipToken.borderWidthSelected);
        case OudsChipControlState.disabled:
          return OudsBorder().borderAll(color: chipToken.colorBorderSelectedDisabled, width: chipToken.borderWidthSelected);
        case OudsChipControlState.hovered:
          return OudsBorder().borderAll(color: chipToken.colorBorderSelectedHover, width: chipToken.borderWidthSelected);
        case OudsChipControlState.pressed:
          return OudsBorder().borderAll(color: chipToken.colorBorderSelectedPressed, width: chipToken.borderWidthSelected);
        case OudsChipControlState.focused:
          return OudsBorder().borderAll(color: chipToken.colorBorderSelectedFocus, width: chipToken.borderWidthSelected);
      }
    } else {
      switch (state) {
        case OudsChipControlState.enabled:
          return OudsBorder().borderAll(color: chipToken.colorBorderUnselectedEnabled, width: chipToken.borderWidthUnselected);
        case OudsChipControlState.disabled:
          return OudsBorder().borderAll(color: chipToken.colorBorderUnselectedDisabled, width: chipToken.borderWidthUnselected);
        case OudsChipControlState.hovered:
          return OudsBorder().borderAll(color: chipToken.colorBorderUnselectedHover, width: chipToken.borderWidthUnselectedInteraction);
        case OudsChipControlState.pressed:
          return OudsBorder().borderAll(color: chipToken.colorBorderUnselectedPressed, width: chipToken.borderWidthUnselectedInteraction);
        case OudsChipControlState.focused:
          return OudsBorder().borderAll(color: chipToken.colorBorderUnselectedFocus, width: chipToken.borderWidthUnselectedInteraction);
      }
    }
  }
}
