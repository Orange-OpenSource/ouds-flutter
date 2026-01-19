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

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/top_appbar/top_appbar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_appbar/top_appbar_enum.dart';

/// Utility class to map tag customization options to corresponding OudsTopAppBar attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsTopAppBar] properties. It includes methods for determining the top appbar layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for top appbar customization and rendering.

class TopAppBarCustomizationUtils {

  /// Maps the top app bar size type enum to `OudsTopAppBarSize`.
  static OudsTopAppBarSize getSize(Object size) {
    switch (size) {
      case TopAppBarSizeEnum.medium:
        return OudsTopAppBarSize.medium;
      case TopAppBarSizeEnum.large:
        return OudsTopAppBarSize.large;
      default:
        return OudsTopAppBarSize.small;
    }
  }

  /// Determines the icon to display based on the selected layout.
  static OudsTopAppBarNavigationLeadingIcon? getNavigationIcon(Object icon) {
    switch (icon) {
      case NavigationIconTypeEnum.back:
        return OudsTopAppBarNavigationLeadingIcon.back;
      case NavigationIconTypeEnum.menu:
        return OudsTopAppBarNavigationLeadingIcon.menu;
      case NavigationIconTypeEnum.close:
        return OudsTopAppBarNavigationLeadingIcon.close;
      case NavigationIconTypeEnum.custom:
        return OudsTopAppBarNavigationLeadingIcon.custom;
      default:
        return OudsTopAppBarNavigationLeadingIcon.none;
    }
  }

  /// Maps the action icon badge type enum to `OudsTopAppBarActionIconBadge`.
  static OudsTopAppBarActionIconBadge getActionIconBadge(Object iconBadge) {
    switch (iconBadge) {
      case ActionIconBadgeEnum.standard:
        return OudsTopAppBarActionIconBadge.standard;
      case ActionIconBadgeEnum.count:
        return OudsTopAppBarActionIconBadge.count;
      default:
        return OudsTopAppBarActionIconBadge.none;
    }
  }

  /// Maps the action avatar type enum to `OudsTopAppBarActionAvatar`.
  static OudsTopAppBarActionAvatar getActionAvatar(Object actionAvatar) {
    return actionAvatar == ActionAvatarEnum.monogram
        ? OudsTopAppBarActionAvatar.monogram
        : OudsTopAppBarActionAvatar.image;
  }

  /// Retrieves the char to display based on the current customization state.
  static String? getMonogramText(
      TopAppBarCustomizationState customizationState) {
    return customizationState.selectedActionAvatar == ActionAvatarEnum.monogram
        ? customizationState.actionAvatarMonogramText
        : null;
  }

  /// Retrieves the action icon badge state based on the current customization state.
  static bool isActionBadge(TopAppBarCustomizationState customizationState) {
    return customizationState.selectedIconBadge != ActionIconBadgeEnum.none;
  }

  /// Retrieves the count to display based on the current customization state.
  static String? getActionBadgeCount(TopAppBarCustomizationState customizationState) {
    return customizationState.selectedIconBadge == ActionIconBadgeEnum.count
        ? "1"
        : customizationState.selectedIconBadge == ActionIconBadgeEnum.standard
        ? ""
        : null;
  }

  /// Retrieves if badge is standard based on the current customization state.
  static bool isBadgeStandard(TopAppBarCustomizationState customizationState) {
    return customizationState.selectedIconBadge == ActionIconBadgeEnum.standard;
  }


  /// Determines the icon to display based on the selected layout.
  static String? getLeadingSemanticLabel(BuildContext context,Object icon) {
      return icon == NavigationIconTypeEnum.custom
          ? context.l10n.app_components_common_icon_a11y
          : null;
  }

  /// Retrieves height of top app bar.
  static double? getExpandedHeaderValue(TopAppBarCustomizationState customizationState) {
    return customizationState.expandedHeightText != null &&  customizationState.expandedHeightText!.isNotEmpty
        ? double.parse(customizationState.expandedHeightText ?? "130.0")
        : 130.0;
  }

  /// Retrieves the title line count of top app bar.
  static int getTitleLineCountValue(TopAppBarCustomizationState customizationState) {
    return int.tryParse(customizationState.titleLineCountText ?? "1") ?? 1;
  }
}
