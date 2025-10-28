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
import 'package:ouds_core/components/badge/internal/ouds_badge_size_modifier.dart';
import 'package:ouds_core/components/badge/internal/ouds_badge_status_modifier.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization.dart';

import 'badge_enum.dart';

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
      case BadgeEnumStatus.negative:
        return OudsBadgeStatus.negative;
      default:
        return OudsBadgeStatus.disabled;
    }
  }

  /// Retrieves the number text to display based on the current customization state.
  static String? getNumberText(BadgeCustomizationState customizationState) {
    final label = customizationState.countText;
    return label.isEmpty ? null : label;
  }

  /// Retrieves the semantics label based on count and status of badge
  String getSemanticLabel(BuildContext context,BadgeCustomizationState customizationState) {

    String? numberText = BadgeCustomizationUtils.getType(customizationState.selectedType)
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
      default:
        baseLabel = context.l10n.app_components_badge_disable_label_a11y;
    }
    return numberText != null
        ? '$numberText $baseLabel'
        : baseLabel;
  }
}
