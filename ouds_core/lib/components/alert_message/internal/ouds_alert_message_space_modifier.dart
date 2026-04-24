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
import 'package:ouds_core/components/alert_message/ouds_alert_message.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsAlertMessageSpaceModifier {
  static double? getRowSpaceGarp(
    BuildContext context,
    OudsAlertMessageActionLink? actionLink,
  ) {
    final alertTokens = OudsTheme.of(context).componentsTokens(context).alert;

    if (actionLink != null &&
        actionLink.text.isNotEmpty &&
        actionLink.position == OudsAlertMessageActionLinkPosition.bottom) {
      return alertTokens.spaceRowGap;
    }
  }
}
