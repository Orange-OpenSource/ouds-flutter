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
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_enum.dart';

class BadgeCodeGenerator {
  // Static method to generate the code based on Badge customization state
  static String updateCode(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);
    return customizationState!.selectedType == BadgeEnumType.count
        ? "OudsBadge.count(\n${label(context)}, \n${enabled(context)},\n${status(context)}, \n${state(context)}\n)"
        : customizationState.selectedType == BadgeEnumType.icon
        ? "OudsBadge.icon(\n${getBadgeIconStatus(context)}, \n${enabled(context)},\n${state(context)}\n)"
        : "OudsBadge.standard(\n${enabled(context)}, \n${status(context)}, \n${state(context)}\n)";
  }

  // Method to get the function name according to the icon of Badge
  static String label(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);
    late String labelValue = "";

    if (customizationState!.selectedType == BadgeEnumType.count) {
      labelValue = "label: '${BadgeCustomizationUtils.getNumberText(customizationState)}'";
    } else {
      labelValue = "label: null";
    }

    return labelValue;
  }

  // Method to get the function name according to the icon of Badge
  static String getBadgeIconStatus(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);

    switch (customizationState!.selectedStatus) {
      case BadgeEnumStatus.neutral:
        return """badgeIconStatus: OudsBadgeIconStatus.neutral(context: context,icon: 'assets/heart-empty.svg')""";
      case BadgeEnumStatus.accent:
        return """badgeIconStatus: OudsBadgeIconStatus.accent(context: context, icon: 'assets/heart-empty.svg')""";
      case BadgeEnumStatus.positive:
        return """badgeIconStatus: OudsBadgeIconStatus.positive(context: context)""";
      case BadgeEnumStatus.info:
        return """badgeIconStatus: OudsBadgeIconStatus.info(context: context)""";
      case BadgeEnumStatus.warning:
        return """badgeIconStatus: OudsBadgeIconStatus.warning(context: context)""";
      default:
        return """badgeIconStatus: OudsBadgeIconStatus.negative(context: context)""";
    }
  }

  // Method to get the function name according to the size of Badge
  static String state(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);

    return "size: ${BadgeCustomizationUtils.getSize(customizationState!.selectedState)}";
  }

  // Method to generate the selected color
  static String status(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);

    return "status: ${BadgeCustomizationUtils.getStatus(customizationState!.selectedStatus)}";
  }

  // Method to generate the enabled status
  static String enabled(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);

    return "enabled: ${customizationState!.hasEnabled}";
  }
}
