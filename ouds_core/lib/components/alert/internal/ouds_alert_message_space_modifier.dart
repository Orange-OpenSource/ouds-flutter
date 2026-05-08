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
import 'package:ouds_core/components/alert/ouds_alert_message.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A utility class to calculate spacing within an [OudsAlertMessage].
///
/// This is an internal helper and is not intended for public use.
class OudsAlertMessageSpaceModifier {
  /// Calculates the vertical space gap for the main content row of an alert.
  ///
  /// Returns the `spaceRowGap` from the theme's alert tokens if the [actionLink]
  /// is non-null, has text, and is positioned at the bottom. Otherwise, returns `null`.
  static double? getRowSpaceGarp(
    BuildContext context,
    OudsAlertMessageActionLayout? actionLink,
  ) {
    final alertTokens = OudsTheme.of(context).componentsTokens(context).alert;

    if (actionLink != null &&
        actionLink.text.isNotEmpty &&
        actionLink.layout == OudsAlertMessageActionLayoutEnum.bottom) {
      return alertTokens.spaceRowGap;
    }
    return null;
  }
}
