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
import 'package:ouds_core/components/navigation_bars/cupertino_navigation_bar/ouds_cupertino_navigation_bar.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/cupertino_navigation_bar/top_cupertino_navigation_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/cupertino_navigation_bar/top_cupertino_navigation_bar_enum.dart';

/// Utility class to map tag customization options to corresponding OudsTopAppBar attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsCupertinoNavigationBar] properties. It includes methods for determining the top appbar layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for top appbar customization and rendering.

class TopCupertinoNavigationBarCustomizationUtils {
  /// Maps the layout enum to `OudsCupertinoNavigationBarStyle`.
  static OudsCupertinoNavigationBarStyle getStyle(Object style) {
    switch (style) {
      case TopCupertinoNavigationBarStyleEnum.large:
        return OudsCupertinoNavigationBarStyle.large;
      default:
        return OudsCupertinoNavigationBarStyle.defaultStyle;
    }
  }

  /// Determines the action type to display based on the selected config.
  static OudsCupertinoNavigationBarActionType getActionType(Object icon) {
    switch (icon) {
      case TopCupertinoNavigationBarActionTypeEnum.none:
      case TopCupertinoTrailingBarActionTypeEnum.none:
        return OudsCupertinoNavigationBarActionType.none;
      case TopCupertinoNavigationBarActionTypeEnum.text:
      case TopCupertinoTrailingBarActionTypeEnum.text:
        return OudsCupertinoNavigationBarActionType.text;
      case TopCupertinoNavigationBarActionTypeEnum.icon:
      case TopCupertinoTrailingBarActionTypeEnum.icon:
        return OudsCupertinoNavigationBarActionType.icon;
      default:
        return OudsCupertinoNavigationBarActionType.back;
    }
  }

  static List<ActionCountEnum?>? getDisabledActionCountOptions(
      TopCupertinoNavigationBarCustomizationState? customizationState) {
    return customizationState?.selectedActionType ==
        TopCupertinoNavigationBarActionTypeEnum.text ?
    [ActionCountEnum.four, ActionCountEnum.five, ActionCountEnum.sex] : null;
  }

  /// Determines semantic label based on the selected action type.
  static String? getSemanticLabel(BuildContext context, Object icon) {
    return icon == TopCupertinoNavigationBarActionTypeEnum.icon
        ? context.l10n.app_components_common_action_a11y
        : null;
  }
}
