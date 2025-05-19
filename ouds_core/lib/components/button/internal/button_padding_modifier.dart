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
  static EdgeInsetsDirectional getPadding(BuildContext context, OudsButtonLayout layout) {
    final theme = OudsTheme.of(context);
    switch (layout) {
      case OudsButtonLayout.iconOnly:
        return EdgeInsetsDirectional.all(theme.componentsTokens(context).button.spaceInsetIconOnly);
      case OudsButtonLayout.iconAndText:
        return EdgeInsetsDirectional.only(
          top: theme.componentsTokens(context).button.spacePaddingBlock,
          end: theme.componentsTokens(context).button.spacePaddingInlineEndIconStart,
          bottom: theme.componentsTokens(context).button.spacePaddingBlock,
          start: theme.componentsTokens(context).button.spacePaddingInlineIconStart,
        );
      case OudsButtonLayout.textOnly:
        return EdgeInsetsDirectional.only(
          top: theme.componentsTokens(context).button.spacePaddingBlock,
          end: theme.componentsTokens(context).button.spacePaddingInlineIconNone,
          bottom: theme.componentsTokens(context).button.spacePaddingBlock,
          start: theme.componentsTokens(context).button.spacePaddingInlineIconNone,
        );
    }
  }
}
