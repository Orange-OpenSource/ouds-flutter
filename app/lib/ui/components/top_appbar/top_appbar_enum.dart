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

/// Enum representing different types of navigation icons in the top app bar.
enum NavigationIconTypeEnum {
  none, //No icon displayed.
  back,
  close,
  menu,
  custom; // Custom icon provided by the user.

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_navigationIcon_label;
  }
}
/// Extension providing string representations for NavigationIconTypeEnum.
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

/// Enum representing sizes of the top app bar.
enum TopAppBarSizeEnum {
  small,
  medium,
  large;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_size_label;
  }
}

/// Extension providing string representations for TopAppBarSizeEnum.
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

/// Enum representing different badge types for action icons.
enum ActionIconBadgeEnum {
  none,
  dot,
  count;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_actionIconBadge_label;
  }
}

/// Extension providing string representations for ActionIconBadgeEnum.
extension CustomElementStatus on ActionIconBadgeEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case ActionIconBadgeEnum.none:
        return context.l10n.app_components_common_none_label;
      case ActionIconBadgeEnum.dot:
        return context.l10n.app_components_common_dot_label;
      case ActionIconBadgeEnum.count:
        return context.l10n.app_components_badge_countType_label;
    }
  }
}

/// Enum representing types of action avatars.
enum ActionAvatarEnum {
  image, // Avatar as an image.
  monogram; // Avatar as a monogram.

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_actionAvatar_label;
  }
}

/// Extension providing string representations for ActionAvatarEnum.
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