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

enum BadgeEnumSize {
  xsmall,
  small,
  medium,
  large;

  static String enumName(BuildContext context) {
    return "Size";
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
    return "Status";
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
