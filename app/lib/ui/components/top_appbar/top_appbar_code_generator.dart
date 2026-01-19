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


  static String title(TopAppBarCustomizationState customizationState) {
    return '''title: "${customizationState.titleText}"''';
  }

  static String? titleLineCount(TopAppBarCustomizationState customizationState) {
    if(customizationState.titleLineCountText != null && customizationState.titleLineCountText!.isNotEmpty){
      return '''titleLineCount: ${customizationState.titleLineCountText}''';
    }
    return null;
  }

  static String? expandedHeight(TopAppBarCustomizationState customizationState) {
    if(customizationState.expandedHeightText != null && customizationState.expandedHeightText!.isNotEmpty){
      return '''expandedHeight: ${customizationState.expandedHeightText}''';
    }
    return null;
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
          monogramText : "$monogramText",
          onActionPressed: () {}
          )''';
    if(customizationState.selectedActionCount == ActionCountEnum.zero ){
      return '''appBarActions: [
      $avatarCode
      ]''';
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

      return  '''appBarActions:[
          ${configs.join(',\n')},
          $avatarCode
          ]''';
  }

  static String? monogramText(TopAppBarCustomizationState customizationState) {
    return 'monogramText: "${customizationState.actionAvatarMonogramText}"';
  }

  static String backgroundColor(
      TopAppBarCustomizationState customizationState) {
    return "backgroundColor: ${customizationState.hasBackgroundColor}";
  }

  // Static method to generate the code based on top appbar customization state
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

    final oudsTopAppBarName = customizationState.selectedSize == TopAppBarSizeEnum.medium
        ? "OudsSliverTopAppBar.medium"
        :  customizationState.selectedSize == TopAppBarSizeEnum.large
        ? "OudsSliverTopAppBar.large"
        : "OudsTopAppBar";


    return """$oudsTopAppBarName(
    ${title(customizationState)},
    ${backgroundColor(customizationState)},
    ${navigationIcon(customizationState)},
    ${getAppBarActionsCode(customizationState)}
    ${lines.join(',\n')}
    )
    """;
  }

}
