
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
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/toolbar_top_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

/// Utility class to map tag customization options to corresponding OudsTopAppBar attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsTopBar] properties. It includes methods for determining the top bar_top layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for top bar_top customization and rendering.

class TopBarCustomizationUtils {

  /// Minimum number of actions allowed for the Material style BarTop component.
  static const int minActionCount = 0;
  /// Maximum number of actions allowed for the Material style BarTop component.
  static const int maxActionCount = 3;
  /// Maximum title line count for Material style BarTop in medium and large sizes.
  static const int maxLinesCount = 4;

  /// Generates a list of consecutive action count values from [minActionCount]
  /// to [maxActionCount] (inclusive).
  static final actionCountOptions = List<int>.generate(
    maxActionCount - (minActionCount - 1),
        (index) => minActionCount + index,
  );

  /// Generates a list of consecutive item count values from one to [maxLinesCount] .
  static final maxLinesOptions = List<int>.generate(
    maxLinesCount,
        (index) => index + 1,
  );

  /// Builds a list of actions for the app bar based on the provided context,
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
    int actionCount = minActionCount,
  }) {
    if(Theme.of(context).platform == TargetPlatform.iOS){
      return buildCupertinoActionsList(
        context: context,
        themeController: themeController,
        customizationState: customizationState,
        isLeadingActions: isLeadingActions,
      );
    }
    //android leading action support only one action (icon)
    if(isLeadingActions){
      return [
        TopBarCustomizationUtils
            .getNavigationIcon(context,
            themeController!,
            customizationState.selectedIconType as Object)
      ];
    }
    final safeActionCount = actionCount.clamp(minActionCount, maxActionCount);
    List<OudsTopBarActionConfig> actions = [];
    actions = List.generate(
      safeActionCount,
          (index) {
        final isLastItem = index == safeActionCount - 1;
        return _getActionConfig(context, customizationState, isLastItem);
      },
    );
    actions.add(_getAvatarActionConfig(context, customizationState));

    return  actions;
  }

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

    return  OudsTopBarActionConfig(
      type: isLeadingAction
          ? ToolbarTopCustomizationUtils.getLeadingActionType(customizationState!.selectedLeadingActionType)
          : ToolbarTopCustomizationUtils.getTrailingActionType(customizationState!.selectedTrailingActionType),
      actionLabel: "Label",
      customIcon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!),
      onActionPressed: (){},
    );
  }

  /// Maps the top app bar size type enum to `OudsBarTopSize`.
  static OudsTopBarSize getSize(Object size) {
    switch (size) {
      case TopBarSizeEnum.medium:
        return OudsTopBarSize.medium;
      case TopBarSizeEnum.large:
        return OudsTopBarSize.large;
      default:
        return OudsTopBarSize.small;
    }
  }

  /// Determines the icon to display based on the selected layout.
  static OudsTopBarActionConfig getNavigationIcon(
      BuildContext context,
      ThemeController themeController,
      Object icon) {

    return OudsTopBarActionConfig(
        type: getType(icon),
        contentDescription: getLeadingSemanticLabel(context,icon),
        customLeadingIcon: AppAssets.icons.assistanceTipsAndTricks(themeController)
    );
  }

  static OudsTopBarActionType getType(Object type){
    switch (type) {
      case NavigationIconTypeEnum.back:
        return OudsTopBarActionType.back;
      case NavigationIconTypeEnum.menu:
        return OudsTopBarActionType.menu;
      case NavigationIconTypeEnum.close:
        return OudsTopBarActionType.close;
      case NavigationIconTypeEnum.custom:
        return OudsTopBarActionType.custom;
      default:
        return OudsTopBarActionType.none;
    }
  }

  /// Maps the action avatar type enum to `OudsTopAppBarActionAvatar`.
  static OudsTopAppBarActionAvatar getActionAvatar(Object actionAvatar) {
    return actionAvatar == ActionAvatarEnum.monogram
        ? OudsTopAppBarActionAvatar.monogram
        : OudsTopAppBarActionAvatar.image;
  }

  /// Retrieves the char to display based on the current customization state.
  static String? getMonogramText(
      TopBarCustomizationState customizationState) {
    return customizationState.selectedActionAvatar == ActionAvatarEnum.monogram
        ? customizationState.actionAvatarMonogramText
        : "A";
  }

  /// Retrieves the count to display based on the current customization state.
  static OudsTopAppBarActionBadge? getActionBadge(TopBarCustomizationState customizationState) {
    return customizationState.selectedIconBadge == ActionIconBadgeEnum.count
        ? OudsTopAppBarActionBadge(count: "1", contentDescription: 'one unread notification')
        : customizationState.selectedIconBadge == ActionIconBadgeEnum.dot
        ? OudsTopAppBarActionBadge(contentDescription: 'Notification')
        : null;
  }

  /// Determines the icon to display based on the selected layout.
  static String? getLeadingSemanticLabel(BuildContext context,Object icon) {
    return icon == NavigationIconTypeEnum.custom
        ? context.l10n.app_components_common_icon_a11y
        : null;
  }

  /// Calculates the expanded header height based on the customization state.
  static double getExpandedHeaderValue(TopBarCustomizationState customizationState) {
    // Determine the default header height based on the selected size
    double headerValue = customizationState.selectedSize == TopBarSizeEnum.medium
        ? OudsTopAppBar.getPreferredSize(size:OudsTopBarSize.medium).height
        : customizationState.selectedSize == TopBarSizeEnum.large
        ? OudsTopAppBar.getPreferredSize(size: OudsTopBarSize.large).height
        : OudsTopAppBar.getPreferredSize().height;

    // Initialize cleanedInput with a default value
    String cleanedInput = "112";
    // If the expandedHeightText is not empty, clean it by removing non-numeric characters
    if(customizationState.expandedHeightText.isNotEmpty){
      cleanedInput = customizationState.expandedHeightText.replaceAll(RegExp(r'[^0-9.]'), '');
    }
    // If the selected size is small, return the default header height
    if(customizationState.selectedSize == TopBarSizeEnum.small){
      return headerValue;
    }
    // If size is medium and expandedHeightText is provided and greater than default, return it
    else  if(customizationState.selectedSize == TopBarSizeEnum.medium
        && customizationState.expandedHeightText.isNotEmpty
        && double.parse(cleanedInput) > headerValue){
      return double.parse(cleanedInput);
    }
    // If size is large and expandedHeightText is provided and greater than default, return it
    else  if(customizationState.selectedSize == TopBarSizeEnum.large
        && customizationState.expandedHeightText.isNotEmpty
        && double.parse(cleanedInput) > headerValue){
      return double.parse(cleanedInput);
    }
    // Otherwise, return the default header height
    else {
      return headerValue;
    }
  }

  /// Retrieves the title line count of TopAppBar.
  static int getTitleLineCountValue(TopBarCustomizationState customizationState) {
    return customizationState.maxLinesSelected;
  }

  /// Retrieves the configuration for a simple icon action .
  static OudsTopBarActionConfig _getActionConfig(
      BuildContext context,
      TopBarCustomizationState? customizationState,
      bool isLastItem
      ){

    return OudsTopBarActionConfig(
        type: OudsTopBarActionType.icon,
        contentDescription: context.l10n.app_components_common_action_a11y,
        badge : (customizationState!.actionSelected == 1 || isLastItem)
            ? TopBarCustomizationUtils.getActionBadge(customizationState)
            : null,
        onActionPressed: () {}
    );
  }

  /// Retrieves an avatar action configuration for the TopAppBar.
  /// The content of the avatar can either be an image or a single letter monogram.
  static OudsTopBarActionConfig _getAvatarActionConfig(
      BuildContext context,
      TopBarCustomizationState customizationState){

    return OudsTopBarActionConfig(
        type: OudsTopBarActionType.avatar,
        avatarConfig: OudsTopAppBarAvatarConfig(
          image: customizationState.selectedActionAvatar == ActionAvatarEnum.image
              ? AppAssets.images.ilTopAppBarAvatar : null,
          monogram : customizationState.selectedActionAvatar == ActionAvatarEnum.monogram
              ? customizationState.actionAvatarMonogramText : null,
        ),
        contentDescription: context.l10n.app_components_common_action_a11y,
        onActionPressed: () {}
    );
  }

  /// Returns the helper text for the expanded height based on the selected size of the top app bar.
  ///
  /// The method checks the current size selected in the [state] and returns the corresponding localized label.
  /// If the size is 'medium', it returns the medium helper text height label.
  /// If the size is 'large', it returns the large helper text height label.
  /// For any other size, it returns an empty string.
  ///
  static String getExpandedHeightHelperText(
      BuildContext context,
      TopBarCustomizationState state){

    if(state.selectedSize == TopBarSizeEnum.medium){
      return context.l10n.app_components_topAppBar_mediumHelperTextHeight_label;
    }
    else if(state.selectedSize == TopBarSizeEnum.large){
      return context.l10n.app_components_topAppBar_largeHelperTextHeight_label;
    }
    else{
      return "";
    }

  }

  /// Validates the expanded height input based on the selected [TopBarSizeEnum].
  ///
  /// Sanitizes the input string by removing non-numeric characters before parsing.
  /// Returns an error message if the height is below Material Design thresholds:
  /// - At least 112 for [TopBarSizeEnum.medium]
  /// - At least 152 for [TopBarSizeEnum.large]
  /// Returns null if the input is valid or empty.
  static String? getExpandedHeightErrorText(
      BuildContext context,
      TopBarCustomizationState state,
      ){

    if(state.expandedHeightText.isNotEmpty){
      int height = int.parse(state.expandedHeightText.replaceAll(RegExp(r'[^0-9]'), ''));

      if(state.selectedSize == TopBarSizeEnum.medium
          && (height < 112)){
        return context.l10n.app_components_topAppBar_mediumErrorMessage_label;
      }

      else if( state.selectedSize == TopBarSizeEnum.large && (height < 152)){
        return context.l10n.app_components_topAppBar_largeErrorMessage_label;
      }
    }

    return null;

  }

  /// Returns the helper text related to the title's [FieldType.maxLines] constraint.
  ///
  /// The helper text is only displayed if the [TopBarSizeEnum] is not 'small',
  /// as smaller bars typically have a fixed layout where line count customization
  /// might be restricted or irrelevant.
  ///
  /// Returns an empty string if the current [state.selectedSize] is small.
  static String getTitleMaxLinesHelperText(
      BuildContext context,
      TopBarCustomizationState state){

    if(state.selectedSize != TopBarSizeEnum.small){
      return context.l10n.app_components_topAppBar_titleMaxLineHelperText_label;
    }
    else{
      return "";
    }

  }

  /// Returns the list of max lines options to disable based on the selected TopAppBar size
  static List<int>? getMaxLiensDisabledOptions(TopBarCustomizationState state){
    final list = TopBarCustomizationUtils.maxLinesOptions.toList();
    final lastTwoValues = list.sublist(list.length - 2);

    return state.selectedSize == TopBarSizeEnum.small
        ? TopBarCustomizationUtils.maxLinesOptions.toList()
        : state.selectedSize == TopBarSizeEnum.medium
        ? lastTwoValues
        : null;
  }

  /// Returns the expanded height as a string based on the selected size and max lines
  static String setExpandedHeight(TopBarCustomizationState state){
    return state.selectedSize == TopBarSizeEnum.medium
        && state.maxLinesSelected == 2
        ? "128"
        : state.selectedSize == TopBarSizeEnum.medium
        && state.maxLinesSelected == 1
        ? "112"
        : state.selectedSize == TopBarSizeEnum.large
        ?  "152"
        : "";
  }
}
