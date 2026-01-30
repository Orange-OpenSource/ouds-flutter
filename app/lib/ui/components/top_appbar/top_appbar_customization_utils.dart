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
import 'package:ouds_core/components/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/top_appbar/top_appbar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_appbar/top_appbar_enum.dart';

import '../../theme/theme_controller.dart';
import '../../utilities/app_assets.dart';

/// Utility class to map tag customization options to corresponding OudsTopAppBar attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsTopAppBar] properties. It includes methods for determining the top appbar layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for top appbar customization and rendering.

class TopAppBarCustomizationUtils {

  static const int minActionCount = 0;
  static const int maxActionCount = 3;

  /// Generates a list of consecutive item count values from [minActionCount]
  /// to [maxActionCount] (inclusive).
  static final actionCountOptions = List<int>.generate(
    maxActionCount - (minActionCount - 1),
        (index) => minActionCount + index,
  );

  /// Builds a list of actions for the app bar based on the provided context,
  /// theme controller, customization state, and desired action count.
  ///
  /// The generated list contains a number of actions specified by [actionCount],
  /// constrained within the limits defined by [minActionCount] and [maxActionCount].
  /// If the action count is greater than 1, the last action is replaced with an avatar.
  ///
  static List<OudsTopAppBarActionConfig> buildActions({
    required BuildContext context,
    required ThemeController themeController,
    TopAppBarCustomizationState? customizationState,
    int actionCount = minActionCount,
  }) {
    final safeActionCount = actionCount.clamp(minActionCount, maxActionCount);
    List<OudsTopAppBarActionConfig> actions = [];
    actions = List.generate(
      safeActionCount,
          (index) {
        final isLastItem = index == safeActionCount - 2;
        return _getActionConfig(context, customizationState!, isLastItem);
      },
    );

    if(safeActionCount > 1) {
      actions.removeLast();
      actions.add(_getAvatarActionConfig(context, customizationState!));
    }

    return  actions;
  }

  /// Maps the top app bar size type enum to `OudsTopAppBarSize`.
  static OudsTopAppBarSize getSize(Object size) {
    switch (size) {
      case TopAppBarSizeEnum.medium:
        return OudsTopAppBarSize.medium;
      case TopAppBarSizeEnum.large:
        return OudsTopAppBarSize.large;
      default:
        return OudsTopAppBarSize.small;
    }
  }

  /// Determines the icon to display based on the selected layout.
  static OudsTopAppBarNavigationLeadingIcon? getNavigationIcon(Object icon) {
    switch (icon) {
      case NavigationIconTypeEnum.back:
        return OudsTopAppBarNavigationLeadingIcon.back;
      case NavigationIconTypeEnum.menu:
        return OudsTopAppBarNavigationLeadingIcon.menu;
      case NavigationIconTypeEnum.close:
        return OudsTopAppBarNavigationLeadingIcon.close;
      case NavigationIconTypeEnum.custom:
        return OudsTopAppBarNavigationLeadingIcon.custom;
      default:
        return OudsTopAppBarNavigationLeadingIcon.none;
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
      TopAppBarCustomizationState customizationState) {
    return customizationState.selectedActionAvatar == ActionAvatarEnum.monogram
        ? customizationState.actionAvatarMonogramText
        : null;
  }

  /// Retrieves the count to display based on the current customization state.
  static OudsTopAppBarActionBadge? getActionBadge(TopAppBarCustomizationState customizationState) {
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

  /// Retrieves height of top app bar.
  static double getExpandedHeaderValue(TopAppBarCustomizationState customizationState) {
    double headerValue = customizationState.selectedSize == TopAppBarSizeEnum.medium
        ? OudsTopAppBar(size: OudsTopAppBarSize.medium).preferredSize.height
        : customizationState.selectedSize == TopAppBarSizeEnum.large
        ? OudsTopAppBar(size: OudsTopAppBarSize.large).preferredSize.height
        : OudsTopAppBar().preferredSize.height;
    if(customizationState.selectedSize == TopAppBarSizeEnum.small){
      return headerValue;
    }else {
      return customizationState.expandedHeightText != null &&
          customizationState.expandedHeightText!.isNotEmpty
          ? double.parse(
          customizationState.expandedHeightText ?? "$headerValue")
          : headerValue;
    }
  }

  /// Retrieves the title line count of TopAppBar.
  static int getTitleLineCountValue(TopAppBarCustomizationState customizationState) {
    return int.tryParse(customizationState.titleLineCountText ?? "1") ?? 1;
  }

  /// Retrieves the configuration for a simple icon action .
  static OudsTopAppBarActionConfig _getActionConfig(
      BuildContext context,
      TopAppBarCustomizationState? customizationState,
      bool isLastItem
      ){

    return OudsTopAppBarActionConfig(
        type: OudsTopAppBarActionType.icon,
        contentDescription: context.l10n.app_components_common_action_a11y,
        badge : (customizationState!.actionSelected == 1 || isLastItem)
            ? TopAppBarCustomizationUtils.getActionBadge(customizationState)
            : null,
        onActionPressed: () {}
    );
  }

  /// Retrieves an avatar action configuration for the TopAppBar.
  /// The content of the avatar can either be an image or a single letter monogram.
  static OudsTopAppBarActionConfig _getAvatarActionConfig(
      BuildContext context,
      TopAppBarCustomizationState customizationState){

    return OudsTopAppBarActionConfig(
        type: OudsTopAppBarActionType.avatar,
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

  /// Returns the placeholder text for the expanded height based on the selected size of the top app bar.
  ///
  /// The method checks the current size selected in the [state] and returns the corresponding localized label.
  /// If the size is 'medium', it returns the medium placeholder height label.
  /// If the size is 'large', it returns the large placeholder height label.
  /// For any other size, it returns an empty string.
  ///
  static String getPlaceholderExpandedHeightText(
      BuildContext context,
      TopAppBarCustomizationState state){

    if(state.selectedSize == TopAppBarSizeEnum.medium){
      return context.l10n.app_components_topAppBar_mediumPlaceholderHeight_label;
    }
    else if(state.selectedSize == TopAppBarSizeEnum.large){
      return context.l10n.app_components_topAppBar_largePlaceholderHeight_label;
    }
    else{
      return "";
    }

  }
}
