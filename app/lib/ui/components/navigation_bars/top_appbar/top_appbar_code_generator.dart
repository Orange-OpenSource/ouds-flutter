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


  static String title(TopAppBarCustomizationState customizationState) {
    return '''title: "${customizationState.titleText}"''';
  }

  static String? centreTitle(TopAppBarCustomizationState customizationState) {
    return customizationState.selectedSize == TopAppBarSizeEnum.small
        ? '''centerTitle: ${customizationState.hasCentredAligned}'''
        : null;
  }

  static String navigationIcon(TopAppBarCustomizationState customizationState) {
    return '''navigationIcon: ${TopAppBarCustomizationUtils.getNavigationIcon(customizationState.selectedIconType)}''';
  }

  static String? customLeadingIcon(
      TopAppBarCustomizationState customizationState) {
    return customizationState.iconTypeState.selected ==
        NavigationIconTypeEnum.custom
        ? '''customLeadingIcon: "assets/tips-and-tricks.svg"''' : null;
  }

  static String avatarIcon() {
    return '''avatarIcon: "assets/il-top-app-bar-avatar.svg" ''';
  }

  static String getAppBarActionsCode(
      TopAppBarCustomizationState customizationState) {

    final avatarCode = '''OudsTopAppBarActionConfig(
          type: OudsTopAppBarActionType.avatar,
          avatarIcon: "AppAssets.images.ilTopAppBarAvatar",
          monogramText : "${customizationState.actionAvatarMonogramText}",
          onActionPressed: () {}
          )''';
    if(customizationState.selectedActionCount == ActionCountEnum.zero && customizationState.showAvatar == false) {
      return '''appBarActions: []''';
    }else if(customizationState.selectedActionCount == ActionCountEnum.zero && customizationState.showAvatar == true){
      return avatarCode;
    }
      final count = TopAppBarCustomizationUtils.getActionBadgeCount(
          customizationState);
    final List<String> configs = [];


    final  iconConfig = TopAppBarCustomizationUtils.isActionBadge(customizationState)
          ?'''OudsTopAppBarActionConfig(
          type: OudsTopAppBarActionType.icon,
          badge: ${TopAppBarCustomizationUtils.isActionBadge(customizationState)},
          count: ${count?.length == 1 ? "$count" : null},
          standard: ${TopAppBarCustomizationUtils.isBadgeStandard(customizationState)},
           onActionPressed: () {}
           )'''
          :
      '''OudsTopAppBarActionConfig(
      type: OudsTopAppBarActionType.icon,
      badge: ${TopAppBarCustomizationUtils.isActionBadge(customizationState)},
      onActionPressed: () {}
      )''';

      String? avatarConfig = customizationState.showAvatar
          ? avatarCode
          : null;

    if (customizationState.selectedActionCount == ActionCountEnum.one ) {
      configs.add(iconConfig);
    }else if( customizationState.selectedActionCount == ActionCountEnum.two ){
      configs.add(iconConfig);
      configs.add(iconConfig);
    }else{
      configs.add(iconConfig);
      configs.add(iconConfig);
      configs.add(iconConfig);
    }

      return avatarConfig != null
          ? '''appBarActions:[
          ${configs.join(',\n')},
          $avatarConfig
          ]'''
          : '''appBarActions:[
          ${configs.join(',\n')}
          ]''';
  }

  static String? monogramText(TopAppBarCustomizationState customizationState) {
    return 'monogramText: "${customizationState.actionAvatarMonogramText}"';
  }

  static String backgroundColor(
      TopAppBarCustomizationState customizationState) {
    return "backgroundColor: ${customizationState.hasBackgroundColor}";
  }

  static String showAvatar(
      TopAppBarCustomizationState customizationState) {
    return "showAvatar: ${customizationState.showAvatar}";
  }

  // Static method to generate the code based on top appbar customization state
  static String updateCode(BuildContext context) {
    final TopAppBarCustomizationState? customizationState = TopAppBarCustomization
        .of(context);

    List<String> lines = [];

    if(centreTitle(customizationState!) != null){
      lines.add(centreTitle(customizationState)!);
    }
    if(customLeadingIcon(customizationState) != null){
      lines.add(customLeadingIcon(customizationState)!);
    }

    final oudsTopAppBarName = customizationState.selectedSize == TopAppBarSizeEnum.medium
        ? "OudsSliverTopAppBar.medium"
        :  customizationState.selectedSize == TopAppBarSizeEnum.large
        ? "OudsSliverTopAppBar.large"
        : "OudsTopAppBar";


    return """$oudsTopAppBarName(
    ${title(customizationState)},
    ${backgroundColor(customizationState)},
    ${showAvatar(customizationState)},
    ${navigationIcon(customizationState)},
    ${lines.join(',\n')},
    ${getAppBarActionsCode(customizationState)}
    )
    """;
  }

}
