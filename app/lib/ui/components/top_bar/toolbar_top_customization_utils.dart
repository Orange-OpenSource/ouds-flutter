
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
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';


/// Utility class to map tag customization options to corresponding OudsToolbarTop attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsToolbarTop] properties. It includes methods for determining the top bar_top layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for TopAppBar customization and rendering.

class ToolbarTopCustomizationUtils {

  /// Minimum number of actions allowed for the Cupertino style of OudsTopBar component.
  static const int minActionCount = 1;
  /// Maximum number of actions allowed for the Cupertino style of  OudsTopBar component.
  static const int maxActionCount = 3;

  /// Generates a list of consecutive item count values from [minActionCount]
  /// to [maxActionCount] (inclusive).
  static final cupertinoActionCountOptions = List<int>.generate(
    maxActionCount - (minActionCount - 1),
        (index) => minActionCount + index,
  );

  static List<int> getLimitedActionsCount(BuildContext context){
    int maxActionsIndex = maxActionCount + 1;
    return cupertinoActionCountOptions.take(maxActionsIndex).toList();
  }

  static List<int?>? getDisabledLeadingActionCountOptions(
      TopBarCustomizationState? customizationState) {
    //disable all options if selected type is none
    if (customizationState?.selectedLeadingActionType ==
        ToolbarTopActionTypeEnum.none) {
      return List<int>.generate(maxActionCount+1, (i) => i);
    }
    //if selected type is different to back  no option to disable
    if (customizationState?.selectedLeadingActionType !=
        ToolbarTopActionTypeEnum.back ) {
      return null;
    }
    //disable all options > 1 if selected type is back
    return List<int>.generate(maxActionCount+1, (i) => i)
        .where((value) => value > 1)
        .toList();
  }

  static List<int?>? getDisabledTrailingActionCountOptions(
      TopBarCustomizationState? customizationState) {
    //disable all options if selected type is none
    if (customizationState?.selectedTrailingActionType ==
        ToolbarTopActionTypeEnum.none) {
      return List<int>.generate(maxActionCount+1, (i) => i);
    }
    return null;
  }

  /// Builds a list of actions for the toolbar top based on the provided context,
  /// themeController, customization state, and desired action count.
  ///
  /// The generated list contains a number of actions specified by [actionCount],
  /// constrained within the limits defined by [minActionCount] and [maxActionCount].
  /// If the action count is greater than 1, the last action is replaced with an avatar.
  ///
  static List<OudsTopBarActionConfig> buildCupertinoActionsList({
    required BuildContext context,
    ThemeController? themeController,
    required TopBarCustomizationState customizationState,
    required bool isLeadingActions,
  }){
    final safeActionCount = isLeadingActions
        ? customizationState.selectedLeadingActionCount.clamp(minActionCount, maxActionCount)
        : customizationState.selectedTrailingActionCount.clamp(minActionCount, maxActionCount);

    return List.generate(
      safeActionCount,
          (index) {
        return _getCupertinoActionConfig(context, customizationState,themeController,isLeadingActions);
      },
    );
  }

  static OudsTopBarActionConfig _getCupertinoActionConfig(
      BuildContext context,
      TopBarCustomizationState? customizationState,
      ThemeController? themeController,
      bool isLeadingAction
      ){

    // Handle null state gracefully to avoid runtime errors.
    if (customizationState == null || themeController == null) {
      return OudsTopBarActionConfig.none();
    }

    // Determine which enum to use based on whether it's a leading or trailing action.
    final actionType = isLeadingAction
        ? customizationState.selectedLeadingActionType
        : customizationState.selectedTrailingActionType;

    // Use a switch statement to call the correct factory constructor.
    switch (actionType) {
      case ToolbarTopActionTypeEnum.text:
        return OudsTopBarActionConfig.text(
          actionLabel: context.l10n.app_components_common_label_label, // Provide only the relevant parameter.
          onActionPressed: customizationState.hasEnabled == true ? () {} : null,
        );

      case ToolbarTopActionTypeEnum.icon:
        return OudsTopBarActionConfig.icon(
          // Provide a relevant icon.
          icon: AppAssets.icons.assistanceTipsAndTricks(themeController),
          contentDescription: context.l10n.app_components_common_action_a11y,
          onActionPressed: customizationState.hasEnabled == true ? () {} : null,
        );
      case ToolbarTopActionTypeEnum.back:
      // The .back() factory handles its own icon and behavior.
        return OudsTopBarActionConfig.back(
          previousPageTitle: customizationState.previousPageTitleText,
          onActionPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        );

      case ToolbarTopActionTypeEnum.none:
        return OudsTopBarActionConfig.none();
    }
  }
}