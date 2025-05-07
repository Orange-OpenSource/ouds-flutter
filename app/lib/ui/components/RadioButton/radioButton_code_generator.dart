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
import 'package:ouds_flutter_demo/ui/components/RadioButton/radioButton_customization.dart';

class RadiobuttonCodeGenerator {
  // Static method to generate the code based on checkbox customization state
  static String updateCode(BuildContext context, bool indeterminate) {
    // Get the text value for the checkbox from customization state
    String value = 'isSelected';

    //return """OudsCheckbox(\nvalue: $value,\n${disableCode(context)}\n${errorCode(context)}${tristateCode(context, indeterminate)}""";
    return """OudsRadioButton(\nvalue: $value,\n${disableCode(context)}\n${errorCode(context)}${tristateCode(context, indeterminate)}""";
  }

  // Method to generate the disable code for the checkbox onChanged callback
  static String disableCode(BuildContext context) {
    final RadioButtonCustomizationState? customizationState = RadioButtonCustomization.of(context);

    // Return the onChanged callback code with its enabled or disabled state
    return "onChanged: ${customizationState?.hasEnabled == true ? "(bool? value) { \n"
        "setState(() {\n "
        "isSelected = value;\n "
        "});\n}" : 'null'},";
  }

  // Method to generate the error code for the checkbox
  static String errorCode(BuildContext context) {
    final RadioButtonCustomizationState? customizationState = RadioButtonCustomization.of(context);

    // Return the onPressed callback code with its enabled or disabled state
    return 'isError: ${customizationState?.hasError == true ? 'true' : 'false'},';
  }

  // Method to generate the tristate code for the checkbox
  static String tristateCode(BuildContext context, bool indeterminate) {
    String end = """\n);""";
    if (indeterminate == false) {
      return end;
    }
    // Return the onPressed callback code with its enabled or disabled state
    return "\ntristate: $indeterminate, $end";
  }
}
