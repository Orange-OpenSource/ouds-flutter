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
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

/// Utility class to map tag customization options to corresponding OudsTopAppBar attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsTopBar] properties. It includes methods for determining the top bar layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for top bar customization and rendering.

class TopAppBarCustomizationUtils {
  /// Minimum number of actions allowed for the Material style TopBar component.
  static const int minActionCount = 0;

  /// Maximum number of actions allowed for the Material style TopBar component.
  static const int maxActionCount = 3;

  /// Maximum title line count for Material style TopBar in medium and large sizes.
  static const int maxLinesCount = 4;

  /// Minimum height for the Top Bar when using the medium size.
  ///
  /// This value represents the default height when the medium variant
  /// is displayed with a single line of content.
  static const int minHeightMediumSize = 112;

  /// The default height when the medium variant is displayed with two lines of content.
  static const int minHeightMediumSizeTwoLines = 128;

  /// Minimum height for the Top Bar when using the large size.
  ///
  /// This value applies regardless of the number of lines.
  static const int minHeightLargeSize = 152;

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

  /// Determines the icon to display based on the selected layout.
  static OudsTopBarActionConfig getNavigationIcon(
    BuildContext context,
    ThemeController themeController,
    NavigationIconTypeEnum icon,
  ) {
    // A switch statement directly maps the enum to the correct factory constructor.
    switch (icon) {
      case NavigationIconTypeEnum.back:
        return OudsTopBarActionConfig.back(
          onActionPressed: () {
            // Example action: Navigate back when pressed.
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        );
      case NavigationIconTypeEnum.menu:
        return OudsTopBarActionConfig.menu(
          onActionPressed: () {
            // Example action: Open a drawer.
            Scaffold.of(context).openDrawer();
          },
        );
      case NavigationIconTypeEnum.close:
        return OudsTopBarActionConfig.close(
          onActionPressed: () {
            // Example action: Close a modal screen.
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        );
      case NavigationIconTypeEnum.custom:
        // The .custom() factory is used for developer-defined icons.
        return OudsTopBarActionConfig.custom(
          // The asset path is now passed directly to the factory.
          icon: AppAssets.icons.assistanceTipsAndTricks(themeController),
          contentDescription: context.l10n.app_components_common_icon_a11y,
          onActionPressed: () {},
        );
      case NavigationIconTypeEnum.none:
        // The .none() factory creates a configuration for no action.
        return OudsTopBarActionConfig.none();
    }
  }

  static List<OudsTopBarActionConfig> getMaterialActions({
    required BuildContext context,
    required TopBarCustomizationState customizationState,
    required ThemeController themeController,
    int actionCount = minActionCount,
  }) {
    final safeActionCount = actionCount.clamp(minActionCount, maxActionCount);
    List<OudsTopBarActionConfig> actions = [];
    actions = List.generate(safeActionCount, (index) {
      final isLastItem = index == safeActionCount - 1;
      return _getActionConfig(
        context,
        themeController,
        customizationState,
        isLastItem,
      );
    });
    actions.add(_getAvatarActionConfig(context, customizationState));
    return actions;
  }

  /// Maps the action avatar type enum to `OudsTopAppBarActionAvatar`.
  static OudsTopAppBarActionAvatar getActionAvatar(Object actionAvatar) {
    return actionAvatar == ActionAvatarEnum.monogram
        ? OudsTopAppBarActionAvatar.monogram
        : OudsTopAppBarActionAvatar.image;
  }

  /// Retrieves the char to display based on the current customization state.
  static String? getMonogramText(TopBarCustomizationState customizationState) {
    return customizationState.selectedActionAvatar == ActionAvatarEnum.monogram
        ? customizationState.actionAvatarMonogramText
        : "A";
  }

  /// Calculates the expanded header height based on the customization state.
  static double getExpandedHeaderValue(
    TopBarCustomizationState customizationState,
  ) {
    // Determine the default header height based on the selected size
    double headerValue =
        customizationState.selectedSize == TopBarSizeEnum.medium
        ? OudsTopAppBar.getPreferredSize(size: OudsTopBarSize.medium).height
        : customizationState.selectedSize == TopBarSizeEnum.large
        ? OudsTopAppBar.getPreferredSize(size: OudsTopBarSize.large).height
        : OudsTopAppBar.getPreferredSize().height;

    // Initialize cleanedInput with a default value
    String cleanedInput = minHeightMediumSize.toString();
    // If the expandedHeightText is not empty, clean it by removing non-numeric characters
    if (customizationState.expandedHeightText.isNotEmpty) {
      cleanedInput = customizationState.expandedHeightText.replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );
    }
    // If the selected size is small, return the default header height
    if (customizationState.selectedSize == TopBarSizeEnum.small) {
      return headerValue;
    }
    // If size is medium and expandedHeightText is provided and greater than default, return it
    else if (customizationState.selectedSize == TopBarSizeEnum.medium &&
        customizationState.expandedHeightText.isNotEmpty &&
        double.parse(cleanedInput) > headerValue) {
      return double.parse(cleanedInput);
    }
    // If size is large and expandedHeightText is provided and greater than default, return it
    else if (customizationState.selectedSize == TopBarSizeEnum.large &&
        customizationState.expandedHeightText.isNotEmpty &&
        double.parse(cleanedInput) > headerValue) {
      return double.parse(cleanedInput);
    }
    // Otherwise, return the default header height
    else {
      return headerValue;
    }
  }

  /// Retrieves the title line count of TopAppBar.
  static int getTitleLineCountValue(
    TopBarCustomizationState customizationState,
  ) {
    return customizationState.maxLinesSelected;
  }

  /// Retrieves the configuration for a simple icon action .
  static OudsTopBarActionConfig _getActionConfig(
    BuildContext context,
    ThemeController themeController,
    TopBarCustomizationState? customizationState,
    bool isLastItem,
  ) {
    // Use the .icon() factory for clarity and type-safety.
    return OudsTopBarActionConfig.icon(
      // The factory requires an icon. Provide a default for the demo.
      icon: AppAssets.icons.assistanceTipsAndTricks(themeController),
      contentDescription: context.l10n.app_components_common_action_a11y,
      onActionPressed: () {},
      // The badge logic remains the same.
      badge: (customizationState?.actionSelected == 1 || isLastItem)
          ? TopBarCustomizationUtils.getActionBadge(customizationState!)
          : null,
    );
  }

  /// Retrieves an avatar action configuration for the TopAppBar.
  /// The content of the avatar can either be an image or a single letter monogram.
  static OudsTopBarActionConfig _getAvatarActionConfig(
    BuildContext context,
    TopBarCustomizationState customizationState,
  ) {
    return OudsTopBarActionConfig.avatar(
      avatarConfig: OudsTopAppBarAvatarConfig(
        image: customizationState.selectedActionAvatar == ActionAvatarEnum.image
            ? AppAssets.images.ilTopAppBarAvatar
            : null,
        monogram:
            customizationState.selectedActionAvatar == ActionAvatarEnum.monogram
            ? customizationState.actionAvatarMonogramText
            : null,
      ),
      contentDescription: context.l10n.app_components_common_action_a11y,
      onActionPressed: () {},
    );
  }

  /// Returns the helper text for the expanded height based on the selected size of the top app bar.
  ///
  /// The method checks the current size selected in the [state] and returns the corresponding localized label.
  /// If the size is 'medium', it returns the medium helper text height label.
  /// If the size is 'large', it returns the large helper text height label.
  /// For any other size, it returns an empty string as this value is not needed
  /// and the corresponding text field in the customization panel will be disabled.
  static String getExpandedHeightHelperText(
    BuildContext context,
    TopBarCustomizationState state,
  ) {
    if (state.selectedSize == TopBarSizeEnum.medium) {
      return context.l10n.app_components_topAppBar_mediumHelperTextHeight_label;
    } else if (state.selectedSize == TopBarSizeEnum.large) {
      return context.l10n.app_components_topAppBar_largeHelperTextHeight_label;
    } else {
      return "";
    }
  }

  /// Validates the expanded height input based on the selected [TopBarSizeEnum].
  ///
  /// Sanitizes the input string by removing non-numeric characters before parsing.
  /// Returns an error message if the height is below Material Design thresholds:
  /// - At least [minHeightMediumSize] for [TopBarSizeEnum.medium]
  /// - At least [minHeightLargeSize] for [TopBarSizeEnum.large]
  /// Returns null if the input is valid or empty.
  static String? getExpandedHeightErrorText(
    BuildContext context,
    TopBarCustomizationState state,
  ) {
    if (state.expandedHeightText.isNotEmpty) {
      int height = int.parse(
        state.expandedHeightText.replaceAll(RegExp(r'[^0-9]'), ''),
      );

      if (state.selectedSize == TopBarSizeEnum.medium &&
          (height < minHeightMediumSize)) {
        return context.l10n.app_components_topAppBar_mediumErrorMessage_label;
      } else if (state.selectedSize == TopBarSizeEnum.large &&
          (height < minHeightLargeSize)) {
        return context.l10n.app_components_topAppBar_largeErrorMessage_label;
      }
    }

    return null;
  }

  /// Returns the list of max lines options to disable based on the selected TopAppBar size
  static List<int>? getMaxLiensDisabledOptions(TopBarCustomizationState state) {
    final list = TopAppBarCustomizationUtils.maxLinesOptions.toList();
    final lastTwoValues = list.sublist(list.length - 2);

    return state.selectedSize == TopBarSizeEnum.small
        ? TopAppBarCustomizationUtils.maxLinesOptions.toList()
        : state.selectedSize == TopBarSizeEnum.medium
        ? lastTwoValues
        : null;
  }

  /// Returns the expanded height of the Top Bar as a string
  /// based on the current customization state.
  ///
  /// The height depends on:
  /// - the selected size (medium or large)
  /// - the number of text lines (for medium size only)
  ///
  /// Rules:
  /// - Medium + 1 line → [minHeightMediumSize]
  /// - Medium + 2 lines → [minHeightMediumSizeTwoLines]
  /// - Large → [minHeightLargeSize]
  /// - Otherwise → empty string
  static String setExpandedHeight(TopBarCustomizationState state) {
    return state.selectedSize == TopBarSizeEnum.medium &&
            state.maxLinesSelected == 2
        ? minHeightMediumSizeTwoLines.toString()
        : state.selectedSize == TopBarSizeEnum.medium &&
              state.maxLinesSelected == 1
        ? minHeightMediumSize.toString()
        : state.selectedSize == TopBarSizeEnum.large
        ? minHeightLargeSize.toString()
        : "";
  }

  static OudsTopAppBarConfig getMaterialConfig(TopBarCustomizationState state) {
    return OudsTopAppBarConfig(
      centerTitle: state.hasCentredAligned,
      expandedHeight: getExpandedHeaderValue(state),
      titleMaxLines: getTitleLineCountValue(state),
      showAvatar: state.showAvatar,
    );
  }
}
