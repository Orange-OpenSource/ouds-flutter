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
import 'package:ouds_core/components/tag/internal/ouds_tag_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the border color for the OudsInputTag based on its state
class OudsInputTagControlBorderModifier {
  final BuildContext context;

  OudsInputTagControlBorderModifier(this.context);

  /// Gets the borderSide based on the tag state
  BoxBorder getBorder(OudsTagControlState state) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).inputTag;

    switch (state) {
      case OudsTagControlState.enabled:
        return Border.all(color: tagToken.colorBorderEnabled, width: tagToken.borderWidthDefault);
      case OudsTagControlState.disabled:
        return Border.all(color: OudsTheme.of(context).colorScheme(context).actionDisabled, width: tagToken.borderWidthDefault);
      case OudsTagControlState.hovered:
        return Border.all(color: tagToken.colorBorderHover, width: tagToken.borderWidthDefaultInteraction);
      case OudsTagControlState.pressed:
        return Border.all(color: tagToken.colorBorderPressed, width: tagToken.borderWidthDefaultInteraction);
      case OudsTagControlState.focused:
        return Border.all(color: tagToken.colorBorderFocus, width: OudsTheme.of(context).borderTokens.widthFocusInset);
    }
  }
}
