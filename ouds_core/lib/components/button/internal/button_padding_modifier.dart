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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/ouds_theme.dart';

class ButtonPaddingModifier {
  static EdgeInsets getPadding(BuildContext context, OudsButtonLayout layout) {
    final theme = OudsTheme.of(context);
    switch (layout) {
      case OudsButtonLayout.iconOnly:
        return EdgeInsets.all(theme.componentsTokens.button.spaceInsetIconOnly);
      case OudsButtonLayout.iconAndText:
        return EdgeInsets.only(
          top: theme.componentsTokens.button.spacePaddingBlock,
          right: theme.componentsTokens.button.spacePaddingInlineEndIconStart,
          bottom: theme.componentsTokens.button.spacePaddingBlock,
          left: theme.componentsTokens.button.spacePaddingInlineIconStart,
        );
      case OudsButtonLayout.textOnly:
        return EdgeInsets.only(
          top: theme.componentsTokens.button.spacePaddingBlock,
          right: theme.componentsTokens.button.spacePaddingInlineIconNone,
          bottom: theme.componentsTokens.button.spacePaddingBlock,
          left: theme.componentsTokens.button.spacePaddingInlineIconNone,
        );
    }
  }
}
