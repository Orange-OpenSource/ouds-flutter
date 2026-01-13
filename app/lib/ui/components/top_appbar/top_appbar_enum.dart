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

enum NavigationIconTypeEnum {
  none,
  back,
  close,
  menu,
  custom;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_navigationIcon_label;
  }
}

extension CustomElementStyle on NavigationIconTypeEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case NavigationIconTypeEnum.none:
        return capitalizeEnumValue(NavigationIconTypeEnum.none);
      case NavigationIconTypeEnum.back:
        return capitalizeEnumValue(NavigationIconTypeEnum.back);
      case NavigationIconTypeEnum.close:
        return capitalizeEnumValue(NavigationIconTypeEnum.close);
      case NavigationIconTypeEnum.menu:
        return capitalizeEnumValue(NavigationIconTypeEnum.menu);
      case NavigationIconTypeEnum.custom:
        return capitalizeEnumValue(NavigationIconTypeEnum.custom);
    }
  }
}

enum TopAppBarSizeEnum {
  small,
  medium,
  large;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_size_label;
  }
}

extension CustomElementSize on TopAppBarSizeEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case TopAppBarSizeEnum.small:
        return capitalizeEnumValue(TopAppBarSizeEnum.small);
      case TopAppBarSizeEnum.medium:
        return capitalizeEnumValue(TopAppBarSizeEnum.medium);
      case TopAppBarSizeEnum.large:
        return capitalizeEnumValue(TopAppBarSizeEnum.large);
    }
  }
}

enum ActionIconBadgeEnum {
  none,
  standard,
  count;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_actionIconBadge_label;
  }
}

extension CustomElementStatus on ActionIconBadgeEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case ActionIconBadgeEnum.none:
        return capitalizeEnumValue(ActionIconBadgeEnum.none);
      case ActionIconBadgeEnum.standard:
        return capitalizeEnumValue(ActionIconBadgeEnum.standard);
      case ActionIconBadgeEnum.count:
        return capitalizeEnumValue(ActionIconBadgeEnum.count);
         }
  }
}

enum ActionAvatarEnum {
  image,
  monogram;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_actionAvatar_label;
  }
}

extension CustomElementAvatar on ActionAvatarEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case ActionAvatarEnum.image:
        return capitalizeEnumValue(ActionAvatarEnum.image);
      case ActionAvatarEnum.monogram:
        return capitalizeEnumValue(ActionAvatarEnum.monogram);
    }
  }
}

enum ActionCountEnum {
  zero,
  one,
  two,
  three;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_actionCount_label;
  }
}
extension CustomElementActionCOunt on ActionCountEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case ActionCountEnum.zero:
        return "0";
      case ActionCountEnum.one:
        return "1";
      case ActionCountEnum.two:
        return "2";
      case ActionCountEnum.three:
        return "3";
    }
  }
}