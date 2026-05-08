/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/global_enum.dart';

/// Position of an action link inside an alert message.
///
/// Used to place the actionable link either below the alert content
/// (typically for narrow layouts / multi-line text) or at the top-end
/// corner of the alert
enum ActionLayoutEnum {
  /// The link is displayed at the bottom of the alert message.
  bottom,

  /// The link is displayed at the top-end corner of the alert message.
  trailing,

  /// No link to display
  none;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_alert_alertMessage_actionLayout_tech;
  }
}

/// Extension providing user-facing string representations for [ActionLayoutEnum].
extension CustomElementAppearance on ActionLayoutEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case ActionLayoutEnum.bottom:
        return capitalizeEnumValue(ActionLayoutEnum.bottom);
      case ActionLayoutEnum.trailing:
        return capitalizeEnumValue(ActionLayoutEnum.trailing);
      case ActionLayoutEnum.none:
        return capitalizeEnumValue(ActionLayoutEnum.none);
    }
  }
}
