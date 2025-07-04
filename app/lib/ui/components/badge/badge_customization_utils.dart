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

import 'package:ouds_core/components/badge/internal/ouds_badge_size_modifier.dart';
import 'package:ouds_core/components/badge/internal/ouds_badge_status_modifier.dart';
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
      case BadgeEnumStatus.negative:
        return OudsBadgeStatus.negative;
      case BadgeEnumStatus.accent:
        return OudsBadgeStatus.accent;
      case BadgeEnumStatus.positive:
        return OudsBadgeStatus.positive;
      case BadgeEnumStatus.info:
        return OudsBadgeStatus.info;
      case BadgeEnumStatus.warning:
        return OudsBadgeStatus.warning;
      case BadgeEnumStatus.neutral:
        return OudsBadgeStatus.neutral;
      default:
        return OudsBadgeStatus.disabled;
    }
  }

  /// Retrieves the number text to display based on the current customization state.
  static String? getNumberText(BadgeCustomizationState customizationState) {
    final label = customizationState.countText;
    return label.isEmpty ? null : label;
  }
}
