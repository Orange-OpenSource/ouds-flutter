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
import 'package:ouds_flutter_demo/ui/components/checkbox/checkbox_customization.dart';

///
/// The CheckboxCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a checkbox component. It leverages the checkbox's
/// customization state, specifically the enabled and error states, and generates
/// the corresponding code in string format, which can be used for rendering or
/// previewing the checkbox with the selected properties.
///
class CheckboxCodeGenerator {
  // Static method to generate the code based on checkbox customization state
  static String updateCode(BuildContext context, bool indeterminate) {
    // Get the text value for the checkbox from customization state
    String value = 'isChecked';

    return """OudsCheckbox(\nvalue: $value,\n${disableCode(context)}\n${errorCode(context)}${tristateCode(context, indeterminate)}""";
  }

  // Method to generate the disable code for the checkbox onChanged callback
  static String disableCode(BuildContext context) {
    final CheckboxCustomizationState? customizationState = CheckboxCustomization.of(context);

    // Return the onChanged callback code with its enabled or disabled state
    return "onChanged: ${customizationState?.hasEnabled == true ? "(bool? value) { \n"
        "setState(() {\n "
        "isChecked = value;\n "
        "});\n}" : 'null'},";
  }

  // Method to generate the error code for the checkbox
  static String errorCode(BuildContext context) {
    final CheckboxCustomizationState? customizationState = CheckboxCustomization.of(context);

    // Return the isError property based on the customization state
    return 'isError: ${customizationState?.hasError == true ? 'true' : 'false'},';
  }

  // Method to generate the tristate code for the checkbox
  static String tristateCode(BuildContext context, bool indeterminate) {
    String end = """\n);""";
    if (indeterminate == false) {
      return end;
    }
    // Return the tristate property based on the indeterminate state
    return "\ntristate: $indeterminate, $end";
  }
}
