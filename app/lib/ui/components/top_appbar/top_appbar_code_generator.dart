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
import 'package:ouds_flutter_demo/ui/components/top_appbar/top_appbar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_appbar/top_appbar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_appbar/top_appbar_enum.dart';


class TopAppBarCodeGenerator {

  /// Generates the code for the title property based on the customization state
  static String title(TopAppBarCustomizationState customizationState) {
    return '''title: "${customizationState.titleText}"''';
  }

  /// Generates the code for the titleLineCount property if it exists and is not empty
  static String? titleLineCount(TopAppBarCustomizationState customizationState) {
    if(customizationState.titleLineCountText != null && customizationState.titleLineCountText!.isNotEmpty){
      return '''titleLineCount: ${customizationState.titleLineCountText}''';
    }
    return null;
  }

  /// Generates the code for expandedHeight if the value is not empty
  static String? expandedHeight(TopAppBarCustomizationState customizationState) {
    if(customizationState.expandedHeightText.isNotEmpty){
      return '''expandedHeight: ${customizationState.expandedHeightText}''';
    }
    return null;
  }

  /// Generates the code for centerTitle based on the size
  static String? centreTitle(TopAppBarCustomizationState customizationState) {
    return customizationState.selectedSize == TopAppBarSizeEnum.small
        ? '''centerTitle: ${customizationState.hasCentredAligned}'''
        : null;
  }

  /// Generates the code for the navigation icon based on the selected icon type
  static String navigationIcon(TopAppBarCustomizationState customizationState) {
    return '''navigationIcon: ${TopAppBarCustomizationUtils.getNavigationIcon(customizationState.selectedIconType)}''';
  }

  /// Generates code for a custom leading icon if the icon type is custom
  static String? customLeadingIcon(
      TopAppBarCustomizationState customizationState) {
    return customizationState.iconTypeState.selected ==
        NavigationIconTypeEnum.custom
        ? '''customLeadingIcon: "assets/tips-and-tricks.svg"''' : null;
  }

  /// Returns the code for the avatar icon asset
  static String avatarIcon() {
    return '''avatarIcon: "assets/il-top-app-bar-avatar.svg" ''';
  }

  /// Generates the avatar configuration code, combining avatar icon and monogram
  static String getAvatarConfigCode( TopAppBarCustomizationState customizationState){
    return  '''avatarConfig: OudsTopAppBarAvatarConfig(
    ${avatarIconCode(customizationState)},
    ${monogramText(customizationState)},
    )''';

  }

  /// Generates the code for app bar actions, including avatar and other actions
  static String getAppBarActionsCode(
      TopAppBarCustomizationState customizationState) {

    String? avatarCode = '''${customizationState.actionSelected > 1 ?
    '''OudsTopAppBarActionConfig(
    type: OudsTopAppBarActionType.avatar,
    ${getAvatarConfigCode(customizationState)},
    onActionPressed:(){}
    )
    ''' : ''}
    ''';

    final List<String> configs = [];

    // Clamp action count between min and max
    final int actionCount = customizationState.actionSelected.clamp(
      TopAppBarCustomizationUtils.minActionCount,
      TopAppBarCustomizationUtils.maxActionCount,
    );

    // Generate action configs for each action
    configs.addAll(List.generate(
      actionCount,
          (index) {
        final isLastItem = index == actionCount - 2;
        return  '''OudsTopAppBarActionConfig(
            type: OudsTopAppBarActionType.icon,
            badge : ${(customizationState.actionSelected == 1 || isLastItem)
                ? getActionBadgeCode(customizationState)
                : null},
            onActionPressed:(){}
        )''';
      },
    )
    );
    // If more than one action, replace the last with avatar code
    if(actionCount > 1) {
      configs.removeLast();
      configs.add(avatarCode);
    }
    // Join all configs into the actions list
    return  '''actions: [${configs.isNotEmpty ? configs.join(',\n') : ''}]''';}

  /// Returns the badge code based on the selected icon badge type
  static String? getActionBadgeCode(TopAppBarCustomizationState customizationState) {
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
  static String? avatarIconCode(TopAppBarCustomizationState customizationState){
    return 'image: ${customizationState.selectedActionAvatar == ActionAvatarEnum.image
        ? 'AppAssets.images.ilTopAppBarAvatar' : null}';
  }

  /// Returns the monogram text code if the avatar type is monogram
  static String? monogramText(TopAppBarCustomizationState customizationState) {
    return 'monogram: ${customizationState.selectedActionAvatar == ActionAvatarEnum.monogram
        ? '${customizationState.actionAvatarMonogramText}' : null}';
  }

  /// Main method to generate the full code for the TopAppBar based on the customization state
  static String updateCode(BuildContext context) {
    final TopAppBarCustomizationState? customizationState = TopAppBarCustomization
        .of(context);

    List<String> lines = [];

    if(titleLineCount(customizationState!) != null){
      lines.add(titleLineCount(customizationState)!);
    }
    if(expandedHeight(customizationState) != null){
      lines.add(expandedHeight(customizationState)!);
    }
    if(centreTitle(customizationState) != null){
      lines.add(centreTitle(customizationState)!);
    }
    if(customLeadingIcon(customizationState) != null){
      lines.add(customLeadingIcon(customizationState)!);
    }

    // Generate the full TopAppBar code
    return """OudsTopAppBar(
    ${title(customizationState)},
    ${navigationIcon(customizationState)},
    ${getAppBarActionsCode(customizationState)},
    ${lines.join(',\n')}
    )
    """;
  }

}
