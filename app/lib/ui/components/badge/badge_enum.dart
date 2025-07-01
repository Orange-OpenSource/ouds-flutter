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

enum BadgeEnumType {
  standard,
  icon,
  number;

  static String enumName(BuildContext context) {
    return "Type";
  }
}

extension CustomElementStyle on BadgeEnumType {
  String stringValue(BuildContext context) {
    switch (this) {
      case BadgeEnumType.standard:
        return capitalizeEnumValue(BadgeEnumType.standard);
      case BadgeEnumType.icon:
        return capitalizeEnumValue(BadgeEnumType.icon);
      case BadgeEnumType.number:
        return capitalizeEnumValue(BadgeEnumType.number);
    }
  }
}

enum BadgeEnumSize {
  xsmall,
  small,
  medium,
  large;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_badge_Size_label;
  }
}

extension CustomElementSize on BadgeEnumSize {
  String stringValue(BuildContext context) {
    switch (this) {
      case BadgeEnumSize.xsmall:
        return capitalizeEnumValue(BadgeEnumSize.xsmall);
      case BadgeEnumSize.small:
        return capitalizeEnumValue(BadgeEnumSize.small);
      case BadgeEnumSize.medium:
        return capitalizeEnumValue(BadgeEnumSize.medium);
      case BadgeEnumSize.large:
        return capitalizeEnumValue(BadgeEnumSize.large);
    }
  }
}

enum BadgeEnumStatus {
  negative,
  accent,
  positive,
  info,
  warning,
  neutral,
  disabled;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_badge_Status_label;
  }
}

extension CustomElementStatus on BadgeEnumStatus {
  String stringValue(BuildContext context) {
    switch (this) {
      case BadgeEnumStatus.negative:
        return capitalizeEnumValue(BadgeEnumStatus.negative);
      case BadgeEnumStatus.accent:
        return capitalizeEnumValue(BadgeEnumStatus.accent);
      case BadgeEnumStatus.positive:
        return capitalizeEnumValue(BadgeEnumStatus.positive);
      case BadgeEnumStatus.info:
        return capitalizeEnumValue(BadgeEnumStatus.info);
      case BadgeEnumStatus.warning:
        return capitalizeEnumValue(BadgeEnumStatus.warning);
      case BadgeEnumStatus.neutral:
        return capitalizeEnumValue(BadgeEnumStatus.neutral);
      case BadgeEnumStatus.disabled:
        return capitalizeEnumValue(BadgeEnumStatus.disabled);
    }
  }
}

String capitalizeEnumValue(Enum enumValue) {
  String enumName = enumValue.toString().split('.').last; // Extracts the enum name
  return enumName[0].toUpperCase() + enumName.substring(1); // Capitalizes the first letter
}
