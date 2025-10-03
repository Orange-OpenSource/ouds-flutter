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
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/link/internal/ouds_link_control_state.dart';

class OudsLinkTextStyleModifier {

  final BuildContext context;

  OudsLinkTextStyleModifier(this.context);

  /// Returns the text Style  based on the size of link
   TextStyle buildLinkTextStyle(
    BuildContext context, {
    required OudsLinkSize size,
  }) {
   return size == OudsLinkSize.defaultSize
       ? OudsTheme.of(context).typographyTokens.typeLabelStrongLarge(context)
       : OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context);

  }

  /// Returns the text color based on link state
  TextDecoration? getTextDecorationStatus(OudsLinkControlState state,OudsLinkLayout layout) {
    if (layout == OudsLinkLayout.textOnly) {
      return TextDecoration.underline;
    } else {
      switch (state) {
        case OudsLinkControlState.enabled:
          return null;
        case OudsLinkControlState.hovered:
        case OudsLinkControlState.focused:
        case OudsLinkControlState.pressed:
        case OudsLinkControlState.disabled:
          return TextDecoration.underline;
      }
    }
  }
}
