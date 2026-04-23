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
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply a border with color, radius
class OudsAlertMessageBorderModifier {
  /// Static method to get the border radius for an alert message based on the border parameter.
  /// Returns a [BorderRadius] object with the appropriate radius value.
  static BorderRadius getBorderRadius(BuildContext context) {
    final alertTokens = OudsTheme.of(context).componentsTokens(context).alert;
    final alertMessageRounded =
        OudsThemeConfigModel.of(context)?.alertMessage?.rounded ?? false;
    print("alertMessageRounded : $alertMessageRounded");
    switch (alertMessageRounded) {
      case true:
        return BorderRadius.circular(alertTokens.borderRadiusRounded);
      case false:
        return BorderRadius.circular(alertTokens.borderRadiusDefault);
    }
  }
}
