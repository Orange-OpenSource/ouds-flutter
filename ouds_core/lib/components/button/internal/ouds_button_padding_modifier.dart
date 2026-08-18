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
import 'package:ouds_core/components/button/internal/ouds_button_utils.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsButtonPaddingModifier {
  static EdgeInsetsDirectional getPadding(
    BuildContext context,
    OudsButtonLayout layout,
    OudsNavigationButtonLayout? navigationLayout,
    OudsButtonComponent componentType, {
    OudsButtonSize size = OudsButtonSize.defaultSize,
  }) {
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
        return EdgeInsetsDirectional.all(buttonTokens.spaceInsetIconOnly(size));
      case OudsButtonLayout.iconAndText:
        return EdgeInsetsDirectional.only(
          top: buttonTokens.spacePaddingBlock(size),
          end:
              isNextLayout //case navigation button with next layout
              ? buttonTokens.spacePaddingInlineChevronEnd(size)
              : //case navigation button with previous layout or normal button
                buttonTokens.spacePaddingInlineEndIconStart(size),
          bottom: buttonTokens.spacePaddingBlock(size),
          start:
              isNextLayout // case navigation button with next layout
              ? buttonTokens.spacePaddingInlineStartIconEnd(size)
              : isPreviousLayout // case navigation button with previous layout
              ? buttonTokens.spacePaddingInlineChevronStart(size)
              : //normal button
                buttonTokens.spacePaddingInlineIconStart(size),
        );
      case OudsButtonLayout.textOnly:
        return EdgeInsetsDirectional.symmetric(
          vertical: buttonTokens.spacePaddingBlock(size),
          horizontal: buttonTokens.spacePaddingInlineIconNone(size),
        );
    }
  }
}
