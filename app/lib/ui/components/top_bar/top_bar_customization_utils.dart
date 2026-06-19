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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/toolbar_top_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_appbar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';

/// Utility class for building and managing OudsTopBar actions and sizes.
class TopBarCustomizationUtils {
  /// Builds a list of actions for the top bar based on the provided context,
  /// customization state, and desired action count.
  ///
  /// The generated list contains a number of actions specified by [actionCount],
  /// constrained within the limits defined by [minActionCount] and [maxActionCount].
  /// If the action count is greater than 1, the last action is replaced with an avatar.
  ///
  static List<OudsTopBarActionConfig> buildActions({
    required BuildContext context,
    required TopBarCustomizationState customizationState,
    required bool isLeadingActions,
    ThemeController? themeController,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return ToolbarTopCustomizationUtils.buildCupertinoActionsList(
        context: context,
        themeController: themeController,
        customizationState: customizationState,
        isLeadingActions: isLeadingActions,
      );
    }
    //android leading action support only one action (icon)
    if (isLeadingActions) {
      return [
        TopAppBarCustomizationUtils.getNavigationIcon(
          context,
          themeController!,
          customizationState.selectedIconType,
        ),
      ];
    }

    return TopAppBarCustomizationUtils.getMaterialActions(
      context: context,
      themeController: themeController!,
      customizationState: customizationState,
      actionCount: customizationState.actionSelected,
    );
  }

  /// Maps the top app bar size type enum to `OudsBarTopSize`.
  static OudsTopBarSize getSize(TopBarSizeEnum size) {
    switch (size) {
      case TopBarSizeEnum.medium:
        return OudsTopBarSize.medium;
      case TopBarSizeEnum.large:
        return OudsTopBarSize.large;
      default:
        return OudsTopBarSize.small;
    }
  }

  /// Retrieves the count to display based on the current customization state.
  static OudsTopBarActionBadge? getActionBadge(
    TopBarCustomizationState customizationState,
  ) {
    return customizationState.selectedIconBadge == ActionIconBadgeEnum.count
        ? OudsTopBarActionBadge(
            count: "1",
            contentDescription: 'one unread notification',
          )
        : customizationState.selectedIconBadge == ActionIconBadgeEnum.dot
        ? OudsTopBarActionBadge(contentDescription: 'Notification')
        : null;
  }
}
