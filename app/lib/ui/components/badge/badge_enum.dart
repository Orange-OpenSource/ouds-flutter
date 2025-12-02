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

enum BadgeEnumType {
  standard,
  icon,
  count;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_badge_type_label;
  }
}

extension CustomElementStyle on BadgeEnumType {
  String stringValue(BuildContext context) {
    switch (this) {
      case BadgeEnumType.standard:
        return context.l10n.app_components_badge_standardType_label;
      case BadgeEnumType.icon:
        return context.l10n.app_components_badge_iconType_label;
      case BadgeEnumType.count:
        return context.l10n.app_components_badge_countType_label;
    }
  }
}

enum BadgeEnumSize {
  xsmall,
  small,
  medium,
  large;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_size_label;
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
  neutral,
  accent,
  positive,
  info,
  warning,
  negative;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_status_label;
  }
}

extension CustomElementStatus on BadgeEnumStatus {
  String stringValue(BuildContext context) {
    switch (this) {
      case BadgeEnumStatus.neutral:
        return capitalizeEnumValue(BadgeEnumStatus.neutral);
      case BadgeEnumStatus.accent:
        return capitalizeEnumValue(BadgeEnumStatus.accent);
      case BadgeEnumStatus.positive:
        return capitalizeEnumValue(BadgeEnumStatus.positive);
      case BadgeEnumStatus.info:
        return capitalizeEnumValue(BadgeEnumStatus.info);
      case BadgeEnumStatus.warning:
        return capitalizeEnumValue(BadgeEnumStatus.warning);
      case BadgeEnumStatus.negative:
        return capitalizeEnumValue(BadgeEnumStatus.negative);
    }
  }
}
