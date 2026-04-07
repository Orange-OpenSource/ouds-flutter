
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

import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A utility class that provides text styling for the `OudsToolbarTop` component.
///
/// This class centralizes the logic for determining the text style of actions
/// based on their enabled or disabled state.
class OudsToolbarTopTextStyleModifier {

  final BuildContext context;

  OudsToolbarTopTextStyleModifier(this.context);

  /// Returns the [TextStyle] for a text-based action in the toolbar.
  TextStyle getTextActionStyle(VoidCallback? onActionPressed, bool isPressed) {
    final enabledColorToken = OudsTheme.of(context).componentsTokens(context)
        .button.colorContentMinimalEnabled;
    final disabledColorToken = OudsTheme.of(context).componentsTokens(context)
        .button.colorContentMinimalDisabled;
    final pressedColor = OudsTheme.of(context).colorScheme(context).actionPressed;

    return OudsTheme.of(context).typographyTokens.typeLabelModerateMedium(context).copyWith(
      color: (onActionPressed != null && !isPressed) ? enabledColorToken : (onActionPressed != null && isPressed) ? pressedColor : disabledColorToken,

    );
  }
}