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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsButtonPaddingModifier {
  static EdgeInsetsDirectional getPadding(
    BuildContext context,
    OudsButtonLayout layout,
    OudsNavigationButtonLayout? navigationLayout,
    OudsButtonComponent componentType,
  ) {
    final buttonTokens = OudsTheme.of(context).componentsTokens(context).button;
    final isNavigationButton =
        componentType == OudsButtonComponent.navigationButton;
    final isNextLayout =
        isNavigationButton &&
        navigationLayout == OudsNavigationButtonLayout.next;
    final isPreviousLayout =
        isNavigationButton &&
        navigationLayout == OudsNavigationButtonLayout.previous;
    switch (layout) {
      case OudsButtonLayout.iconOnly:
        return EdgeInsetsDirectional.all(
          buttonTokens.spaceInsetIconOnlyDefault,
        );
      case OudsButtonLayout.iconAndText:
        return EdgeInsetsDirectional.only(
          top: buttonTokens.spacePaddingBlockDefault,
          end:
              isNextLayout //case navigation button with next layout
              ? buttonTokens.spacePaddingInlineChevronEndDefault
              : //case navigation button with previous layout or normal button
                buttonTokens.spacePaddingInlineEndIconStartDefault,
          bottom: buttonTokens.spacePaddingBlockDefault,
          start:
              isNextLayout // case navigation button with next layout
              ? buttonTokens.spacePaddingInlineStartIconEndDefault
              : isPreviousLayout // case navigation button with previous layout
              ? buttonTokens.spacePaddingInlineChevronStartDefault
              : //normal button
                buttonTokens.spacePaddingInlineIconStartDefault,
        );
      case OudsButtonLayout.textOnly:
        return EdgeInsetsDirectional.symmetric(
          vertical: buttonTokens.spacePaddingBlockDefault,
          horizontal: buttonTokens.spacePaddingInlineIconNoneDefault,
        );
    }
  }
}
