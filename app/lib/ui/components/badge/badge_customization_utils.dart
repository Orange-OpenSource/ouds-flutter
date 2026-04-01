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

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_enum.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class BadgeCustomizationUtils {
  /// Maps the hierarchy enum to `OudsBadgeSize`.
  static OudsBadgeSize getSize(BadgeEnumSize size) {
    switch (size) {
      case BadgeEnumSize.xsmall:
        return OudsBadgeSize.xsmall;
      case BadgeEnumSize.small:
        return OudsBadgeSize.small;
      case BadgeEnumSize.medium:
        return OudsBadgeSize.medium;
      default:
        return OudsBadgeSize.large;
    }
  }

  /// Maps the hierarchy enum to `BadgeEnumType`.
  static BadgeEnumType getType(BadgeEnumType type) {
    switch (type) {
      case BadgeEnumType.count:
        return BadgeEnumType.count;
      case BadgeEnumType.icon:
        return BadgeEnumType.icon;
      default:
        return BadgeEnumType.standard;
    }
  }

  /// Maps the hierarchy enum to `OudsIconStatus`.
  static OudsIconStatus getStatus(BadgeEnumStatus status) {
    switch (status) {
      case BadgeEnumStatus.neutral:
        return Neutral();
      case BadgeEnumStatus.accent:
        return Accent();
      case BadgeEnumStatus.positive:
        return Positive();
      case BadgeEnumStatus.info:
        return Info();
      case BadgeEnumStatus.warning:
        return Warning();
      default:
        return Negative();
    }
  }

  /// Retrieves the number text to display based on the current customization state.
  static String? getNumberText(BadgeCustomizationState customizationState) {
    final label = customizationState.countText;
    return label.isEmpty ? null : label;
  }

  /// Retrieves the semantics label based on count and status of badge
  static String getSemanticLabel(BuildContext context,BadgeCustomizationState customizationState) {

    String? numberText = customizationState.selectedType
        == BadgeEnumType.count ? getNumberText(customizationState) : null;
    String baseLabel;

    switch (customizationState.selectedStatus) {
      case BadgeEnumStatus.neutral:
        baseLabel =  context.l10n.app_components_badge_notification_label_a11y;
      case BadgeEnumStatus.accent:
        baseLabel = context.l10n.app_components_badge_important_label_a11y;
      case BadgeEnumStatus.positive:
        baseLabel = context.l10n.app_components_badge_success_label_a11y;
      case BadgeEnumStatus.info:
        baseLabel = context.l10n.app_components_badge_info_label_a11y;
      case BadgeEnumStatus.warning:
        baseLabel = context.l10n.app_components_badge_warning_label_a11y;
      case BadgeEnumStatus.negative:
        baseLabel = context.l10n.app_components_badge_negative_label_a11y;
    }
    return numberText != null
        ? '$numberText $baseLabel'
        : baseLabel;
  }

  /// Determines the Status (icon and color) to display based on the selected status.
  static OudsIconStatus getIconStatus(BuildContext context,BadgeCustomizationState customizationState,ThemeController? themeController) {
    switch (customizationState.selectedStatus) {
      case BadgeEnumStatus.neutral:
        return Neutral(
            icon: customizationState.selectedType == BadgeEnumType.icon
                ? AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!)
                : null);
      case BadgeEnumStatus.accent:
        return Accent(
            icon: customizationState.selectedType == BadgeEnumType.icon
                ? AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!)
                : null);
      case BadgeEnumStatus.positive:
        return Positive();
      case BadgeEnumStatus.info:
        return Info();
      case BadgeEnumStatus.warning:
        return Warning();
      default:
        return Negative();
    }
  }

  /// Returns the background color based on the badge status.
  static Color getStatusColor(BuildContext context,BadgeEnumStatus enumStatus,bool isEnabled) {
    final theme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return theme.actionDisabled;
    }
    final status = getStatus(enumStatus);

    switch (status) {
        case Neutral():
          return theme.surfaceInverseHigh;
        case Accent():
          return theme.surfaceStatusAccentEmphasized;
        case Positive():
          return theme.surfaceStatusPositiveEmphasized;
        case Info():
          return theme.surfaceStatusInfoEmphasized;
        case Warning():
          return theme.surfaceStatusWarningEmphasized;
        case Negative():
          return theme.surfaceStatusNegativeEmphasized;
    }
  }

  /// Returns the icon to display based on the badge type.
  static String? getIcon(BadgeCustomizationState? customizationState, ThemeController? themeController) {
    if (customizationState?.selectedType == BadgeEnumType.icon ){
      return AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!);
    }
    return null;
  }
}
