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

enum ActionLinkPositionEnum {
  bottom,
  topEnd;

  static String enumName(BuildContext context) {
    return context
        .l10n
        .app_components_alert_alertMessage_actionLinkPosition_tech;
  }
}

extension CustomElementAppearance on ActionLinkPositionEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case ActionLinkPositionEnum.bottom:
        return capitalizeEnumValue(ActionLinkPositionEnum.bottom);
      case ActionLinkPositionEnum.topEnd:
        return capitalizeEnumValue(ActionLinkPositionEnum.topEnd);
    }
  }
}
