
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
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_enum.dart';


/// Utility class to map tag customization options to corresponding OudsToolbarTop attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsToolbarTop] properties. It includes methods for determining the top bar_top layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for top bar_top customization and rendering.

class ToolbarTopCustomizationUtils {

  /// Minimum number of actions allowed for the Cupertino style of OudsTopBar component.
  static const int minActionCount = 1;
  /// Maximum number of actions allowed for the Cupertino style of  OudsTopBar component.
  static const int maxActionCount = 3;

  /// Determines the action type to display based on the selected layout.
  static OudsTopBarActionType getLeadingActionType(ToolbarTopActionTypeEnum actionType) {
    switch (actionType) {
      case ToolbarTopActionTypeEnum.none:
        return OudsTopBarActionType.none;
      case ToolbarTopActionTypeEnum.text:
        return OudsTopBarActionType.text;
      case ToolbarTopActionTypeEnum.icon:
        return OudsTopBarActionType.icon;
      case ToolbarTopActionTypeEnum.back:
        return OudsTopBarActionType.back;
    }
  }

  /// Determines the action type to display based on the selected layout.
  static OudsTopBarActionType getTrailingActionType(ToolbarTopActionTypeEnum actionType) {
    switch (actionType) {
      case ToolbarTopActionTypeEnum.none:
        return OudsTopBarActionType.none;
      case ToolbarTopActionTypeEnum.text:
        return OudsTopBarActionType.text;
      case ToolbarTopActionTypeEnum.icon:
        return OudsTopBarActionType.icon;
      case ToolbarTopActionTypeEnum.back:
        throw UnimplementedError(
            "back is used only for leading action on android!"
        );
    }
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

  /// Determines semantic label based on the selected action type.
  static String? getSemanticLabel(BuildContext context, Object icon) {
    return icon == ToolbarTopActionTypeEnum.icon
        ? context.l10n.app_components_common_action_a11y
        : null;
  }

}