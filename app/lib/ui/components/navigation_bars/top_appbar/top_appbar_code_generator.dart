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
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_enum.dart';


class TopAppBarCodeGenerator {
  // Static method to generate the code based on top appbar customization state
  static String updateCode(BuildContext context) {
    final TopAppBarCustomizationState? customizationState = TopAppBarCustomization
        .of(context);

    return """OudsTopAppBar(
    ${title(customizationState!)},
    ${centreTitle(customizationState)},
    ${size(customizationState)},
    ${navigationIcon(customizationState)},
    ${customLeadingIcon(customizationState)},
    ${avatarIcon()},
    ${getAppBarActionsCode(customizationState)},
    ${monogramText(customizationState)},
    ${backgroundColor(customizationState)}
    )
    """;
  }

  static String title(TopAppBarCustomizationState customizationState) {
    return 'title: "${customizationState.titleText}"';
  }

  static String centreTitle(TopAppBarCustomizationState customizationState) {
    return customizationState.selectedSize == TopAppBarSizeEnum.small
        ? 'centerTitle: ${customizationState.hasCentredAligned}'
        : "centerTitle: false";
  }

  static String size(TopAppBarCustomizationState customizationState) {
    return 'size: ${customizationState.selectedSize}';
  }

  static String navigationIcon(TopAppBarCustomizationState customizationState) {
    return 'navigationIcon: ${customizationState.selectedIconType}';
  }

  static String customLeadingIcon(
      TopAppBarCustomizationState customizationState) {
    return customizationState.iconTypeState.selected ==
        NavigationIconTypeEnum.custom
        ? 'customLeadingIcon: "assets/tips-and-tricks.svg"' : "";
  }

  static String avatarIcon() {
    return 'avatarIcon: "assets/il-top-app-bar-avatar.svg"';
  }

  static String getAppBarActionsCode(
      TopAppBarCustomizationState customizationState) {
    final count = TopAppBarCustomizationUtils.getActionBadgeCount(
        customizationState);

    final badgeConfig = '''
    OudsTopAppBarActionConfig(
    type: OudsTopAppBarActionType.icon,
    badge: ${TopAppBarCustomizationUtils.isActionBadge(customizationState)},
    count: ${count?.length == 1 ? "$count" : null},
    standard: ${TopAppBarCustomizationUtils.isBadgeStandard(customizationState)},
    onActionPressed: () {},
    )
    ''';

    final avatarConfig = '''
    OudsTopAppBarActionConfig(
    type: OudsTopAppBarActionType.avatar,
    onActionPressed: () {},
    )
    ''';

    return '''
    appBarActions: [
    $badgeConfig,
    $avatarConfig,
    ]
    ''';
  }

  static String monogramText(TopAppBarCustomizationState customizationState) {
    return 'monogramText: "${customizationState.actionAvatarMonogramText}"';
  }

  static String backgroundColor(
      TopAppBarCustomizationState customizationState) {
    return "backgroundColor: ${customizationState.hasBackgroundColor}";
  }
}
