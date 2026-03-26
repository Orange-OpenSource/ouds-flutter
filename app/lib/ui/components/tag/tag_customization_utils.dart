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

import 'package:flutter/widgets.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Utility class to map tag customization options to corresponding OudsTag attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsTag] properties. It includes methods for determining the tag layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for tag customization and rendering.

class TagCustomizationUtils {
  /// Maps the layout enum to `OudsTagLayout`.
  static OudsTagLayout getLayout(Object layout) {
    switch (layout) {
      case TagEnumLayout.iconAndText:
        return OudsTagLayout.textAndIcon;
      case TagEnumLayout.bulletAndText:
        return OudsTagLayout.textAndBullet;
      default:
        return OudsTagLayout.textOnly;
    }
  }

  static bool isBullet(TagEnumLayout layout) {
    if (layout == TagEnumLayout.bulletAndText) {
      return true;
    } else {
      return false;
    }
  }

  /// Determines the icon to display based on the selected layout.
  static String? getIcon(TagCustomizationState? customizationState, ThemeController themeController) {
    if (customizationState?.selectedLayout == TagEnumLayout.iconAndText
        && (customizationState?.selectedStatus == TagEnumStatus.accent
            || customizationState?.selectedStatus == TagEnumStatus.neutral)) {
      return AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController);
    }
    return null;
  }

  /// Determines the text to display based on the selected layout.
  static String getText(TagCustomizationState customizationState) {
    return customizationState.labelText;
  }

  /// Maps the appearance enum to `OudsTagAppearance`.
  static OudsTagAppearance getAppearance(TagEnumAppearance appearance) {
    switch (appearance) {
      case TagEnumAppearance.muted:
        return OudsTagAppearance.muted;
      default:
        return OudsTagAppearance.emphasized;
    }
  }

  /// Maps the appearance enum to `OudsIconStatus`.
  static OudsIconStatus _getStatus(TagEnumStatus status) {
    switch (status) {
      case TagEnumStatus.accent:
        return Accent();
      case TagEnumStatus.info:
        return Info();
      case TagEnumStatus.negative:
        return Negative();
      case TagEnumStatus.positive:
        return Positive();
      case TagEnumStatus.warning:
        return Warning();
      default:
        return Neutral();
    }
  }

  /// Maps the size enum to `OudsTagSize`.
  static OudsTagSize getSize(Object size) {
    switch (size) {
      case TagEnumSize.small:
        return OudsTagSize.small;
      default:
        return OudsTagSize.defaultSize;
    }
  }

  /// Returns the background color based on the tag status.
  static Color? getStatusColor(BuildContext context, TagCustomizationState customizationState,
      TagEnumStatus enumStatus,
      bool isEnabled) {

    final theme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return theme.actionDisabled;
    }
    final appearance = getAppearance(customizationState.selectedAppearance);
    final isEmphasized = appearance == OudsTagAppearance.emphasized;
    final status = _getStatus(enumStatus);

      return switch (status) {
        Neutral() => _getNeutralStatusColor(context,isEmphasized),
        Accent() => _getAccentStatusColor(context,isEmphasized),
        Positive() => _getPositiveStatusColor(context,isEmphasized),
        Info() => _getInfoStatusColor(context,isEmphasized),
        Warning() => _getWarningStatusColor(context,isEmphasized),
        Negative() => _getNegativeStatusColor(context,isEmphasized),
      };
  }

  /// Returns the background color for the **neutral** status.
  static Color _getNeutralStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceInverseHigh : theme.surfaceSecondary;
  }

  /// Returns the background color for the **accent** status.
  static Color _getAccentStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusAccentEmphasized : theme.surfaceStatusAccentMuted;
  }

  /// Returns the background color for the **positive** status.
  static Color _getPositiveStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusPositiveEmphasized : theme.surfaceStatusPositiveMuted;
  }

  /// Returns the background color for the **info** status.
  static Color _getInfoStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusInfoEmphasized : theme.surfaceStatusInfoMuted;
  }

  /// Returns the background color for the **warning** status.
  static Color _getWarningStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusWarningEmphasized : theme.surfaceStatusWarningMuted;
  }

  /// Returns the background color for the **negative** status.
  static Color _getNegativeStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusNegativeEmphasized : theme.surfaceStatusNegativeMuted;
  }

  /// Determines the icon to display based on the selected status.
  static OudsIconStatus getIconStatus(BuildContext context,TagCustomizationState customizationState,ThemeController? themeController) {
    switch (customizationState.selectedStatus) {
      case TagEnumStatus.neutral:
        return Neutral(
            icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!),
        );
      case TagEnumStatus.accent:
        return Accent(
            icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!)
        );
      case TagEnumStatus.positive:
        return Positive();
      case TagEnumStatus.info:
        return Info();
      case TagEnumStatus.warning:
        return Warning();
      default:
        return Negative();
    }
  }
}
