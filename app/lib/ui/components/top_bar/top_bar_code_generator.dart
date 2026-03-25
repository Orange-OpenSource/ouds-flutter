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
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_enum.dart';

class TopBarCodeGenerator {
  /// Generates the code for centerTitle based on the size
  static String? getSize(TopBarCustomizationState customizationState) {
    return customizationState.selectedSize == TopBarSizeEnum.medium
        ? '''size: OudsTopBarSize.medium'''
        : customizationState.selectedSize == TopBarSizeEnum.large
        ? '''size: OudsTopBarSize.large'''
        : '''size: OudsTopBarSize.small''';
  }

  /// Generates the code for the title property based on the customization state
  static String title(TopBarCustomizationState customizationState) {
    return '''title: "${customizationState.titleText}"''';
  }
  /// Generates the code for the previous title property based on the customization state
  static String previousPageTitle(TopBarCustomizationState customizationState) {
    return '''previousPageTitle: "${customizationState.previousPageTitleText}"''';
  }

  /// Generates the code for the titleMaxLines property if it exists and is not empty
  static String? titleMaxLines(TopBarCustomizationState customizationState) {
    if (customizationState.selectedSize != TopBarSizeEnum.small) {
      return '''titleMaxLines: ${customizationState.maxLinesSelected}''';
    }
    return null;
  }

  /// Generates the code for expandedHeight if the value is not empty
  static String? expandedHeight(TopBarCustomizationState customizationState) {
    if (customizationState.selectedSize != TopBarSizeEnum.small &&
        customizationState.expandedHeightText.isNotEmpty) {
      return '''expandedHeight: ${customizationState.expandedHeightText}''';
    }
    return null;
  }

  /// Generates the code for centerTitle based on the size
  static String? centreTitle(TopBarCustomizationState customizationState) {
    return customizationState.selectedSize == TopBarSizeEnum.small
        ? '''centerTitle: ${customizationState.hasCentredAligned}'''
        : null;
  }

  /// Generates the code for the navigation icon based on the selected icon type
  static String leadingActions(TopBarCustomizationState state) {
    String actionConfigCode;
    switch (state.selectedIconType) {
      case NavigationIconTypeEnum.back:
        actionConfigCode = 'OudsTopBarActionConfig.back(onActionPressed: (){})';
        break;
      case NavigationIconTypeEnum.close:
        actionConfigCode = 'OudsTopBarActionConfig.close(onActionPressed: (){})';
        break;
      case NavigationIconTypeEnum.menu:
        actionConfigCode = 'OudsTopBarActionConfig.menu(onActionPressed: (){})';
        break;
      case NavigationIconTypeEnum.custom:
        actionConfigCode =
        '''OudsTopBarActionConfig.custom(customIcon: "assets/tips-and-tricks.svg", onActionPressed: (){})''';
        break;
      case NavigationIconTypeEnum.none:
        actionConfigCode =  '''OudsTopBarActionConfig.none()''';
        break;
    }
    return '''leadingActions: [
      $actionConfigCode
    ]''';
  }

  /// Generates the avatar configuration code, combining avatar icon and monogram
  static String getAvatarConfigCode(TopBarCustomizationState customizationState) {
    return '''avatarConfig: OudsTopAppBarAvatarConfig(
      ${avatarIconCode(customizationState)},
      ${monogramText(customizationState)},
    )''';
  }

  /// Generates the code for app bar actions, including avatar and other actions
  static String? getAppBarActionsCode(
      TopBarCustomizationState customizationState) {
    final List<String> configs = [];

    // Generate code for standard icon actions
    final int actionCount = customizationState.actionSelected;
    if (actionCount > 0) {
      configs.addAll(List.generate(
        actionCount,
            (index) {
          final isBadgeEligible =
              (actionCount == 1) || (index == actionCount - 1);
          return '''OudsTopBarActionConfig.icon(
              customIcon: "assets/functional-social-and-engagement-heart-empty.svg",
              badge: ${isBadgeEligible ? getActionBadgeCode(customizationState) : null},
              onActionPressed: (){}
            )''';
        },
      ));
    }

    // Generate code for the avatar action if enabled
    if (customizationState.showAvatar) {
      final avatarCode = '''OudsTopBarActionConfig.avatar(
        ${getAvatarConfigCode(customizationState)},
        onActionPressed: (){}
      )''';
      configs.add(avatarCode);
    }
    if (configs.isEmpty) {
      return null;
    }

    // Join all configs into the actions list
    return '''trailingActions: [
      ${configs.join(',\n      ')}
    ]''';
  }

  /// Returns the badge code based on the selected icon badge type
  static String? getActionBadgeCode(
      TopBarCustomizationState customizationState) {
    return customizationState.selectedIconBadge == ActionIconBadgeEnum.count
        ? '''OudsTopAppBarActionBadge(
          count: "1",
          contentDescription: 'one unread notification'
        )'''
        : customizationState.selectedIconBadge == ActionIconBadgeEnum.dot
        ? '''OudsTopAppBarActionBadge(
          contentDescription: 'Notification'
        )'''
        : null;
  }

  /// Returns the code for avatar icon image asset based on the selected avatar type
  static String? avatarIconCode(TopBarCustomizationState customizationState) {
    return 'image: ${customizationState.selectedActionAvatar == ActionAvatarEnum.image ? '"assets/avatar"' : null}';
  }

  /// Returns the monogram text code if the avatar type is monogram
  static String? monogramText(TopBarCustomizationState customizationState) {
    return 'monogram: ${customizationState.selectedActionAvatar == ActionAvatarEnum.monogram ? "'${customizationState.actionAvatarMonogramText}'" : null}';
  }

  /// Returns the monogram text code if the avatar type is monogram
  static String? showAvatar(TopBarCustomizationState customizationState) {
    return 'showAvatar: ${customizationState.showAvatar}';
  }

  // Main method to generate the full code for the TopAppBar based on the customization state
  static String updateCode(BuildContext context) {
    final TopBarCustomizationState? customizationState =
    TopBarCustomization.of(context);

    if (customizationState == null) {
      return '// Waiting for customization state...';
    }

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final List<String> params = [
        getSize(customizationState),
        title(customizationState),
        actionsCode(customizationState, true),
        actionsCode(customizationState, false),
      ].where((e) => e != null).cast<String>().toList();
      return """OudsTopBar(
      ${params.join(',\n')}
    )""";
    }

    // else material code generator
    final materialConfigCode = _generateMaterialConfigCode(customizationState);

    final List<String> params = [
      getSize(customizationState),
      title(customizationState),
      leadingActions(customizationState),
      getAppBarActionsCode(customizationState),
      materialConfigCode,
    ].where((e) => e != null && e.toString().trim().isNotEmpty)
        .cast<String>()
        .toList();

    return """OudsTopBar(
      ${params.join(',\n      ')}
    )""";
  }

  /// Generates the code for the materialConfig parameter.
  static String? _generateMaterialConfigCode(
      TopBarCustomizationState customizationState) {
    final List<String> configLines = [
      titleMaxLines(customizationState),
      expandedHeight(customizationState),
      centreTitle(customizationState),
      showAvatar(customizationState),
    ].where((line) => line != null).cast<String>().toList();

    if (configLines.isEmpty) {
      return null;
    }

    return '''
    materialConfig: OudsTopAppBarConfig(
      ${configLines.join(',\n      ')},
    )''';
  }

  /// Generates the code for toolbar top actions
  static String? actionsCode(
      TopBarCustomizationState customizationState, bool isLeadingActions) {
    final actionType = isLeadingActions
        ? customizationState.selectedLeadingActionType
        : customizationState.selectedTrailingActionType;

    final safeActionCount = isLeadingActions
        ? customizationState.selectedLeadingActionCount
        : customizationState.selectedTrailingActionCount;

    if (safeActionCount == 0 || actionType == ToolbarTopActionTypeEnum.none) {
      return null;
    }

    String actionConfigCode;
    switch (actionType) {
      case ToolbarTopActionTypeEnum.text:
        actionConfigCode =
        '''OudsTopBarActionConfig.text(actionLabel: "Label", onActionPressed: (){})''';
        break;
      case ToolbarTopActionTypeEnum.icon:
        actionConfigCode =
        '''OudsTopBarActionConfig.icon(
        customIcon: "assets/functional-social-and-engagement-heart-empty.svg",
         onActionPressed: (){})''';
        break;
      case ToolbarTopActionTypeEnum.back:
        actionConfigCode = """OudsTopBarActionConfig.back(
        ${previousPageTitle(customizationState)},
         onActionPressed: (){})""";
        break;
      case ToolbarTopActionTypeEnum.none:
        actionConfigCode = '';
        break;
    }

    final List<String> configs =
    List.generate(safeActionCount, (index) => actionConfigCode);

    return '''${isLeadingActions ? 'leadingActions' : 'trailingActions'}: [
      ${configs.join(',\n      ')}
    ]''';
  }
}