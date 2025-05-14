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

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/divider/Divider_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_customization.dart';

///
/// The CheckboxCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a divider component. It leverages the divider's
/// customization state, specifically the color state, and generates
/// the corresponding code in string format, which can be used for rendering or
/// previewing the divider with the selected properties.
///
class DividerCodeGenerator {
  // Static method to generate the code based on divider customization state
  static String updateCode(BuildContext context, bool vertical) {
    return """${functionName(vertical)}(\n${color(context)}\n)""";
  }

  // Method to get the function name according to the orientation of divider
  static String functionName(bool vertical) {
    // Return the function name  based on the orientation of divider
    return "${vertical == true ? 'OudsVerticalDivider' : 'OudsHorizontalDivider'}";
  }

  // Method to generate the selected color
  static String color(BuildContext context) {
    final DividerCustomizationState? customizationState = DividerCustomization.of(context);

    return "color = ${DividerCustomizationUtils.getOudsDividerColor(customizationState?.selectedColor)}";
  }
}
