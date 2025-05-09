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
import 'package:ouds_flutter_demo/ui/components/radio_button/radioButton_customization.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radioButton_demo_screen.dart';

class RadioButtonCodeGenerator {
  // Static method to generate the code based on Radiobutton customization state
  static String updateCode(BuildContext context, bool indeterminate, RadioOption selectedOption) {
    // Get the text value for the Radiobutton from customization state
    bool value = selectedOption == RadioOption.first;

    //return """OudsCheckbox(\nvalue: $value,\n${disableCode(context)}\n${errorCode(context)}${tristateCode(context, indeterminate)}""";
    return """First Radio Button:\nOudsRadioButton<RadioOption>(\nvalue: $value,\ngroupValue: $value,\n${disableCode(context,value)}\n${errorCode(context)}${tristateCode(context, indeterminate)}""";
  }

  // Method to generate the disable code for the Radiobutton onChanged callback
  static String disableCode(BuildContext context, bool value) {
    final RadioButtonCustomizationState? customizationState = RadioButtonCustomization.of(context);
    // Return the onChanged callback code with its enabled or disabled state
    return "onChanged: ${customizationState?.hasEnabled == true ? "(RadioOption? value) { \n"
        "setState(() {\n "
        "isSelected = ${value};\n "
        "});\n}" : 'null'},";
  }

  // Method to generate the error code for the Radiobutton
  static String errorCode(BuildContext context) {
    final RadioButtonCustomizationState? customizationState = RadioButtonCustomization.of(context);

    // Return the onPressed callback code with its enabled or disabled state
    return 'isError: ${customizationState?.hasError == true ? 'true' : 'false'},';
  }

  // Method to generate the tristate code for the Radiobutton
  static String tristateCode(BuildContext context, bool indeterminate) {
    String end = """\n);""";
    if (indeterminate == false) {
      return end;
    }
    // Return the onPressed callback code with its enabled or disabled state
    return "\ntristate: $indeterminate, $end";
  }
}
