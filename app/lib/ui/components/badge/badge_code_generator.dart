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
    return """OudsBadge(\n${label(context)},\n${icon(context)},\n${state(context)},\n${status(context)}\n)""";
  }

  // Method to get the function name according to the icon of Badge
  static String label(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);
    late String labelValue = "";

    if (BadgeCustomizationUtils.getType(customizationState!.selectedType) == BadgeEnumType.count) {
      labelValue = "label: ${BadgeCustomizationUtils.getNumberText(customizationState!)}";
    } else {
      labelValue = "label: null";
    }

    return labelValue;
  }

  // Method to get the function name according to the icon of Badge
  static String icon(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);
    late String iconValue = "";
    if (BadgeCustomizationUtils.getType(customizationState!.selectedType) == BadgeEnumType.icon) {
      iconValue = "icon: 'assets/ic_heart_badge.svg'";
    } else {
      iconValue = "icon: null";
    }
    return iconValue;
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
}
