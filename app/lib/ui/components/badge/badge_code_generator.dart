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
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';

class BadgeCodeGenerator {
  // Static method to generate the code based on Badge customization state
  static String updateCode(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(
      context,
    );
    return customizationState!.selectedType == BadgeEnumType.count
        ? "OudsBadge.count(\n${label(context)}, \n${enabled(context)},\n${getStatus(context)}, \n${size(context)}\n)"
        : customizationState.selectedType == BadgeEnumType.icon
        ? "OudsBadge.icon(\n${enabled(context)}, \n ${getStatus(context)},\n${size(context)}\n)"
        : "OudsBadge.standard(\n${enabled(context)}, \n${getStatus(context)}, \n${size(context)}\n)";
  }

  // Method to get the function name according to the icon of Badge
  static String label(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(
      context,
    );
    late String labelValue = "";

    if (customizationState!.selectedType == BadgeEnumType.count) {
      labelValue =
          "label: '${BadgeCustomizationUtils.getNumberText(customizationState)}'";
    } else {
      labelValue = "label: null";
    }

    return labelValue;
  }

  // Method to get the function name according to the icon of Badge
  static String getStatus(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(
      context,
    );
    final withIcon = customizationState!.selectedType == BadgeEnumType.icon;

    switch (customizationState.selectedStatus) {
      case StatusEnum.neutral:
        return """status: Neutral(${withIcon ? "icon: 'assets/heart-empty.svg'" : ""})""";
      case StatusEnum.accent:
        return """status: Accent(${withIcon ? "icon: 'assets/heart-empty.svg'" : ""})""";
      case StatusEnum.positive:
        return """status: Positive()""";
      case StatusEnum.info:
        return """status: Info()""";
      case StatusEnum.warning:
        return """status: Warning()""";
      default:
        return """status: Negative()""";
    }
  }

  // Method to get the function name according to the size of Badge
  static String size(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(
      context,
    );

    return "size: ${BadgeCustomizationUtils.getSize(customizationState!.selectedState)}";
  }

  // Method to generate the enabled status
  static String enabled(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(
      context,
    );

    return "enabled: ${customizationState!.hasEnabled}";
  }
}
