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

enum TopCupertinoNavigationBarActionTypeEnum {
  none,
  back, // only leading
  icon,
  text;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_cupertinoNavigationBar_leadingActionType_label;
  }
}

extension CustomElementLeadingActionType on TopCupertinoNavigationBarActionTypeEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case TopCupertinoNavigationBarActionTypeEnum.none:
        return capitalizeEnumValue(TopCupertinoNavigationBarActionTypeEnum.none);
      case TopCupertinoNavigationBarActionTypeEnum.back:
        return capitalizeEnumValue(TopCupertinoNavigationBarActionTypeEnum.back);
      case TopCupertinoNavigationBarActionTypeEnum.icon:
        return capitalizeEnumValue(TopCupertinoNavigationBarActionTypeEnum.icon);
      case TopCupertinoNavigationBarActionTypeEnum.text:
        return capitalizeEnumValue(TopCupertinoNavigationBarActionTypeEnum.text);
    }
  }
}

enum TopCupertinoTrailingBarActionTypeEnum {
  none,
  icon,
  text;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_cupertinoNavigationBar_trailingActionType_label;
  }
}

extension CustomElementTrailingActionType on TopCupertinoTrailingBarActionTypeEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case TopCupertinoTrailingBarActionTypeEnum.none:
        return capitalizeEnumValue(TopCupertinoNavigationBarActionTypeEnum.none);
      case TopCupertinoTrailingBarActionTypeEnum.icon:
        return capitalizeEnumValue(TopCupertinoNavigationBarActionTypeEnum.icon);
      case TopCupertinoTrailingBarActionTypeEnum.text:
        return capitalizeEnumValue(TopCupertinoNavigationBarActionTypeEnum.text);
    }
  }
}

enum TopCupertinoNavigationBarStyleEnum {
  defaultStyle,
  large;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_style_label;
  }
}

extension CustomElementSize on TopCupertinoNavigationBarStyleEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case TopCupertinoNavigationBarStyleEnum.defaultStyle:
        return capitalizeEnumValue(
            TopCupertinoNavigationBarStyleEnum.defaultStyle);
      case TopCupertinoNavigationBarStyleEnum.large:
        return capitalizeEnumValue(TopCupertinoNavigationBarStyleEnum.large);
    }
  }
}
