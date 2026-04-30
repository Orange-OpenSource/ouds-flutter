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
import 'package:ouds_core/components/control/ouds_control_item.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the tick color for the OudsCheckbox/OudsRadioButton/OudsSwitch based on its state and error status.
class OudsControlIndicatorModifier {
  final BuildContext context;

  OudsControlIndicatorModifier(this.context);

  /// Returns the size of the indicator based on the control type.
  ///
  /// If the type is not `switchButton` and is `radio`, this function returns
  /// the size of the radio button indicator.
  /// Otherwise, it returns the size of the checkbox indicator.
  ///
  /// [type] : The control type, of type `OudsControlItemType`.
  /// [context] : The Flutter build context needed to access themes.
  ///
  /// Returns: The size of the indicator as a `double`.
  double getSizeIndicator(OudsControlItemType type, BuildContext context) {
    // Check if the type is not switchButton and is radio
    if (type != OudsControlItemType.switchButton && type == OudsControlItemType.radio) {
      // Return the size of the radio button indicator
      return OudsTheme.of(context).componentsTokens(context).controlItem.sizeControlIndicator;
    } else {
      // Return the size of the checkbox indicator
      return OudsTheme.of(context).componentsTokens(context).controlItem.sizeControlIndicator;
    }
  }
}
