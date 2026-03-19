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
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/tag/ouds_tag_icon_status.dart';
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

  /// Maps the appearance enum to `OudsTagStatus`.
  static OudsTagStatus getStatus(Object status) {
    switch (status) {
      case TagEnumStatus.accent:
        return OudsTagStatus.accent;
      case TagEnumStatus.info:
        return OudsTagStatus.info;
      case TagEnumStatus.negative:
        return OudsTagStatus.negative;
      case TagEnumStatus.positive:
        return OudsTagStatus.positive;
      case TagEnumStatus.warning:
        return OudsTagStatus.warning;
      default:
        return OudsTagStatus.neutral;
    }
  }

  static OudsTagSize getSize(Object size) {
    switch (size) {
      case TagEnumSize.small:
        return OudsTagSize.small;
      default:
        return OudsTagSize.defaultSize;
    }
  }

  /// Returns the background color based on the tag status.
  // The param state will be removed after deprecation
  static Color? getStatusColor(BuildContext context,OudsTagStatus? state, OudsTagIconStatus? tagIconStatus, OudsTagAppearance? appearance, bool isEnabled) {
    final isEmphasized = appearance == OudsTagAppearance.emphasized;
    final theme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return theme.actionDisabled;
    }

    if(state != null){
      switch (state) {
        case OudsTagStatus.neutral:
          return _getNeutralStatusColor(context,isEmphasized);
        case OudsTagStatus.accent:
          return _getAccentStatusColor(context,isEmphasized);
        case OudsTagStatus.positive:
          return _getPositiveStatusColor(context,isEmphasized);
        case OudsTagStatus.info:
          return _getInfoStatusColor(context,isEmphasized);
        case OudsTagStatus.warning:
          return _getWarningStatusColor(context,isEmphasized);
        case OudsTagStatus.negative:
          return _getNegativeStatusColor(context,isEmphasized);
      }
    }
    else if(tagIconStatus != null){
      return switch (tagIconStatus) {
        Neutral() => _getNeutralStatusColor(context,isEmphasized),
        Accent() => _getAccentStatusColor(context,isEmphasized),
        Positive() => _getPositiveStatusColor(context,isEmphasized),
        Info() => _getInfoStatusColor(context,isEmphasized),
        Warning() => _getWarningStatusColor(context,isEmphasized),
        Negative() => _getNegativeStatusColor(context,isEmphasized),
      };
    }

    return null;
  }

  static Color _getNeutralStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceInverseHigh : theme.surfaceSecondary;
  }
  static Color _getAccentStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusAccentEmphasized : theme.surfaceStatusAccentMuted;
  }
  static Color _getPositiveStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusPositiveEmphasized : theme.surfaceStatusPositiveMuted;
  }
  static Color _getInfoStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusInfoEmphasized : theme.surfaceStatusInfoMuted;
  }
  static Color _getWarningStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusWarningEmphasized : theme.surfaceStatusWarningMuted;
  }
  static Color _getNegativeStatusColor(BuildContext context,bool isEmphasized){
    final theme = OudsTheme.of(context).colorScheme(context);
    return isEmphasized ? theme.surfaceStatusNegativeEmphasized : theme.surfaceStatusNegativeMuted;
  }

  /// Determines the icon to display based on the selected layout.
  static OudsTagIconStatus getTagIconStatus(BuildContext context,TagCustomizationState customizationState,ThemeController? themeController) {
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
