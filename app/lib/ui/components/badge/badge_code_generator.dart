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

class BadgeCodeGenerator {
  // Static method to generate the code based on Badge customization state
  static String updateCode(BuildContext context) {
    return """OudsBadge(\n${state(context)},\n${status(context)}\n)""";
  }

  // Method to get the function name according to the orientation of Badge
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
