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
import 'package:ouds_core/components/tag/internal/ouds_tag_status_modifier.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/tag/ouds_tag_icon_status.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTagStyleModifier {
  final BuildContext context;

  OudsTagStyleModifier(this.context);

  TextStyle buildTagTextStyle(
      {
    required OudsTagAppearance appearance,
        OudsTagStatus? status,
        OudsTagIconStatus? tagIconStatus,
    required OudsTagSize size,
         bool isLoading = false,
        bool isEnabled = false
  }) {
    return size == OudsTagSize.defaultSize
        ? OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context).copyWith(
              color: OudsTagStatusModifier(context).getStatusTextColor(status, tagIconStatus, appearance,isLoading, isEnabled),
            )
        : OudsTheme.of(context).typographyTokens.typeLabelModerateSmall(context).copyWith(
              color: OudsTagStatusModifier(context).getStatusTextColor(status, tagIconStatus, appearance,isLoading, isEnabled),
            );
  }

  /// Returns the text color based on tag state for tag input
  Color? getTextColor(OudsTagControlState state) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).inputTag;

    switch (state) {
      case OudsTagControlState.enabled:
        return tagToken.colorContentEnabled;
      case OudsTagControlState.disabled:
        return OudsTheme.of(context).colorScheme(context).actionDisabled;
      case OudsTagControlState.hovered:
        return tagToken.colorContentHover;
      case OudsTagControlState.pressed:
        return tagToken.colorContentPressed;
      case OudsTagControlState.focused:
        return tagToken.colorContentFocus;
    }
  }
}
