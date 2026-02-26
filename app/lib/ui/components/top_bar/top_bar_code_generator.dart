
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
import 'package:ouds_flutter_demo/ui/components/top_bar/toolbar_top_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_appbar_customization_utils.dart';
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

  /// Generates the code for the titleMaxLines property if it exists and is not empty
  static String? titleMaxLines(TopBarCustomizationState customizationState) {
    if(customizationState.selectedSize != TopBarSizeEnum.small){
      return '''titleMaxLines: ${customizationState.maxLinesSelected}''';
    }
    return null;
  }

  /// Generates the code for expandedHeight if the value is not empty
  static String? expandedHeight(TopBarCustomizationState customizationState) {
    if(customizationState.selectedSize != TopBarSizeEnum.small
        && customizationState.expandedHeightText.isNotEmpty){
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
    final type = TopAppBarCustomizationUtils.getType(state.selectedIconType as Object);
    return '''leadingActions: [ 
    OudsTopBarActionConfig(
        type: $type,
        ${customLeadingIcon(state)}
    )
    ]''';
  }

  /// Generates code for a custom leading icon if the icon type is custom
  static String? customLeadingIcon(
      TopBarCustomizationState customizationState) {
    return customizationState.iconTypeState.selected ==
        NavigationIconTypeEnum.custom
        ? '''customLeadingIcon: "assets/tips-and-tricks.svg"''' : null;
  }

  /// Returns the code for the avatar icon asset
  static String avatarIcon() {
    return '''avatarIcon: "assets/il-top-app-bar-avatar.svg" ''';
  }

  /// Generates the avatar configuration code, combining avatar icon and monogram
  static String getAvatarConfigCode( TopBarCustomizationState customizationState){
    return  '''avatarConfig: OudsTopAppBarAvatarConfig(
    ${avatarIconCode(customizationState)},
    ${monogramText(customizationState)},
    )''';

  }

  /// Generates the code for app bar actions, including avatar and other actions
  static String getAppBarActionsCode(
      TopBarCustomizationState customizationState) {

    String? avatarCode = '''${customizationState.showAvatar ?
    '''OudsTopBarActionConfig(
    type: OudsTopBarActionType.avatar,
    ${getAvatarConfigCode(customizationState)},
    onActionPressed:(){}
    )''' : ''}
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
        return  '''OudsTopBarActionConfig(
            type: OudsTopBarActionType.icon,
            badge : ${(customizationState.actionSelected == 1 || isLastItem)
            ? getActionBadgeCode(customizationState)
            : null},
            onActionPressed:(){}
        )''';
      },
    )
    );
    // If more than one action, replace the last with avatar code
    if(avatarCode.isNotEmpty) {
      configs.add(avatarCode);
    }
    // Join all configs into the actions list
    return  '''trailingActions: [
    ${configs.isNotEmpty ? configs.join(',\n') : ''}]''';}

  /// Returns the badge code based on the selected icon badge type
  static String? getActionBadgeCode(TopBarCustomizationState customizationState) {
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
  static String? avatarIconCode(TopBarCustomizationState customizationState){
    return 'image: ${customizationState.selectedActionAvatar == ActionAvatarEnum.image
        ? 'AppAssets.images.ilTopAppBarAvatar' : null}';
  }

  /// Returns the monogram text code if the avatar type is monogram
  static String? monogramText(TopBarCustomizationState customizationState) {
    return 'monogram: ${customizationState.selectedActionAvatar == ActionAvatarEnum.monogram
        ? "'${customizationState.actionAvatarMonogramText}'" : null}';
  }

  /// Returns the monogram text code if the avatar type is monogram
  static String? showAvatar(TopBarCustomizationState customizationState) {
    return 'showAvatar: ${customizationState.showAvatar}';
  }

  // Main method to generate the full code for the TopAppBar based on the customization state
  static String updateCode(BuildContext context) {
    final TopBarCustomizationState? customizationState = TopBarCustomization
        .of(context);

    if (Theme.of(context).platform == TargetPlatform.iOS){
      return """OudsTopBar(
    ${getSize(customizationState!)},
    ${title(customizationState)},
    ${actionsCode(customizationState,true)},
    ${actionsCode(customizationState,false)},
    )""";
    }

    // else material code generator
    List<String> lines = [];

    if(titleMaxLines(customizationState!) != null){
      lines.add(titleMaxLines(customizationState)!);
    }
    if(expandedHeight(customizationState) != null){
      lines.add(expandedHeight(customizationState)!);
    }
    if(centreTitle(customizationState) != null){
      lines.add(centreTitle(customizationState)!);
    }
    return """OudsTopBar(
    ${getSize(customizationState)},
    ${title(customizationState)},
    ${leadingActions(customizationState)},
    ${getAppBarActionsCode(customizationState)},
    ${lines.join(',\n')},
    ${showAvatar(customizationState)}
    )""";
  }

  /// Returns the Dart code snippet that defines the action `type` for a toolbar action configuration.
  static String typeCode(TopBarCustomizationState state, isLeadingActions){

    return '''type: ${isLeadingActions
        ? ToolbarTopCustomizationUtils.getLeadingActionType(state.selectedLeadingActionType)
        : ToolbarTopCustomizationUtils.getTrailingActionType(state.selectedTrailingActionType)}''';
  }

  static String? actionLabelCode(TopBarCustomizationState state){
    return state.selectedLeadingActionType == ToolbarTopActionTypeEnum.back
        || state.selectedLeadingActionType == ToolbarTopActionTypeEnum.text
        || state.selectedTrailingActionType == ToolbarTopActionTypeEnum.text
        ? '''actionLabel: "Label"'''
        :  null;
  }

  /// Generates the code for toolbar top actions
  static String actionsCode(
      TopBarCustomizationState customizationState,
      bool isLeadingActions) {

    // Clamp action count between min and max
    final safeActionCount = isLeadingActions
        ? customizationState.selectedLeadingActionCount.clamp(
        ToolbarTopCustomizationUtils.minActionCount, ToolbarTopCustomizationUtils.maxActionCount)
        : customizationState.selectedTrailingActionCount.clamp(
        ToolbarTopCustomizationUtils.minActionCount, ToolbarTopCustomizationUtils.maxActionCount);

    final List<String> configs = [];

    // Generate action configs for each action
    configs.addAll(List.generate(
      safeActionCount,
          (index) {
        return  '''OudsTopBarActionConfig(
       ${typeCode(customizationState, isLeadingActions)},
       ${actionLabelCode(customizationState)},
       customIcon: "assets/functional-social-and-engagement-heart-empty.svg",
       onActionPressed: (){},
       )''';
      },
    )
    );
    // Join all configs into the actions list
    return  '''${isLeadingActions ? 'leadingActions' : 'trailingActions'}: [
    ${configs.isNotEmpty ? configs.join(',\n') : ''}]''';
  }
}
