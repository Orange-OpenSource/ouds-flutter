
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

/// This enum is used for defining the type of navigation action in Material AppBars.
enum NavigationIconTypeEnum {
  none, //No icon displayed.
  back,
  close,
  menu,
  custom; // Custom icon provided by the user.

  /// Returns a capitalized string representation of the enum value.
  String stringValue() {
    return capitalizeEnumValue(this);
  }

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_navigationIcon_label;
  }
}

/// Enum representing sizes of the TopAppBar.
enum TopBarSizeEnum {
  small,
  medium,
  large;

  /// Returns a capitalized string representation of the enum value.
  String stringValue(BuildContext context) {
    return capitalizeEnumValue(this);
  }

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_size_label;
  }
}

/// This enum is used for configuring badge types on action icons in Material AppBars.
enum ActionIconBadgeEnum {
  none,
  dot,
  count;

  /// Returns a capitalized string representation of the enum value.
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

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_actionIconBadge_label;
  }
}

/// This enum is used for defining the type of action avatars in Material AppBars.
enum ActionAvatarEnum {
  image, // Avatar as an image.
  monogram; // Avatar as a monogram.

  /// Returns a capitalized string representation of the enum value.
  String stringValue(BuildContext context) {
    return capitalizeEnumValue(this);
  }

  static String enumName(BuildContext context) {
    return context.l10n.app_components_topAppBar_actionAvatar_label;
  }
}

/// This enum is used for configuring the toolbar actions for Cupertino.
enum ToolbarTopActionTypeEnum {
  none,
  back, // only leading
  icon,
  text;

  /// Returns a capitalized string representation of the enum value.
  String stringValue(BuildContext context) {
    return capitalizeEnumValue(this);
  }

  static String enumName(BuildContext context) {
    return context.l10n.app_components_toolbarTop_leadingActionType_label;
  }
}
