
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

class OudsToolbarTopTextStyleModifier {


  TextStyle getTextActionStyle(BuildContext context, VoidCallback? onActionPressed) {
    final enabledColorToken = OudsTheme.of(context).colorScheme(context).actionSelected;
    final disabledColorToken = OudsTheme.of(context).colorScheme(context).contentDisabled;

    return TextStyle(
      color: onActionPressed != null ? enabledColorToken : disabledColorToken,
      fontFamily: OudsTheme.of(context).fontFamily,
    );
  }
}