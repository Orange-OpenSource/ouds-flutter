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
import 'package:ouds_core/components/badge/ouds_badge_icon_status.dart';
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

  static OudsBadgeStatus getStatus(BadgeEnumStatus status) {
    switch (status) {
      case BadgeEnumStatus.neutral:
        return OudsBadgeStatus.neutral;
      case BadgeEnumStatus.accent:
        return OudsBadgeStatus.accent;
      case BadgeEnumStatus.positive:
        return OudsBadgeStatus.positive;
      case BadgeEnumStatus.info:
        return OudsBadgeStatus.info;
      case BadgeEnumStatus.warning:
        return OudsBadgeStatus.warning;
      default:
        return OudsBadgeStatus.negative;
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

  /// Determines the icon to display based on the selected layout.
  static OudsBadgeIconStatus getBadgeStatus(BuildContext context,BadgeCustomizationState customizationState,ThemeController? themeController) {
    switch (customizationState.selectedStatus) {
      case BadgeEnumStatus.neutral:
        return Neutral(
            context: context,
            icon: customizationState.selectedType == BadgeEnumType.icon
                ? AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!)
                : null);
      case BadgeEnumStatus.accent:
        return Accent(
            context: context,
            icon: customizationState.selectedType == BadgeEnumType.icon
                ? AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!)
                : null);
      case BadgeEnumStatus.positive:
        return Positive(context: context);
      case BadgeEnumStatus.info:
        return Info(context: context);
      case BadgeEnumStatus.warning:
        return Warning(context: context);
      default:
        return Negative(context: context);
    }
  }

  /// Returns the background color based on the badge status.
  // The param state will be removed after deprecation
  static Color? getStatusColor(BuildContext context, OudsBadgeStatus? state, OudsBadgeIconStatus? badgeIconStatus,bool isEnabled) {
    final theme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return theme.actionDisabled;
    }
    // it will be removed after deprecation
    if(state != null) {
      switch (state) {
        case OudsBadgeStatus.neutral:
          return theme.surfaceInverseHigh;
        case OudsBadgeStatus.accent:
          return theme.surfaceStatusAccentEmphasized;
        case OudsBadgeStatus.positive:
          return theme.surfaceStatusPositiveEmphasized;
        case OudsBadgeStatus.info:
          return theme.surfaceStatusInfoEmphasized;
        case OudsBadgeStatus.warning:
          return theme.surfaceStatusWarningEmphasized;
        case OudsBadgeStatus.negative:
          return theme.surfaceStatusNegativeEmphasized;
      }
    }
    // this will be called when badgeIconStatus is not null
    if(badgeIconStatus != null){
      return badgeIconStatus.statusColor;
    }
    return null;
  }
}
