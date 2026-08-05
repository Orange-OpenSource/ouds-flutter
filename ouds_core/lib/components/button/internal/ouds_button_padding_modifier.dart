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
  ) {
    final theme = OudsTheme.of(context);
    switch (layout) {
      case OudsButtonLayout.iconOnly:
        return EdgeInsetsDirectional.all(
          theme.componentsTokens(context).button.spaceInsetIconOnlyDefault,
        );
      case OudsButtonLayout.iconAndText:
        return EdgeInsetsDirectional.only(
          top: theme.componentsTokens(context).button.spacePaddingBlockDefault,
          end: theme
              .componentsTokens(context)
              .button
              .spacePaddingInlineEndIconStartDefault,
          bottom: theme
              .componentsTokens(context)
              .button
              .spacePaddingBlockDefault,
          start: theme
              .componentsTokens(context)
              .button
              .spacePaddingInlineIconStartDefault,
        );
      case OudsButtonLayout.textOnly:
        return EdgeInsetsDirectional.symmetric(
          vertical: theme
              .componentsTokens(context)
              .button
              .spacePaddingBlockDefault,
          horizontal: theme
              .componentsTokens(context)
              .button
              .spacePaddingInlineIconNoneDefault,
        );
    }
  }
}
