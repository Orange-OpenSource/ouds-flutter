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
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_enum.dart';

///
/// The ControlItemCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a control item component. It leverages the control item
/// customization state (such as label text, hierarchy, style, and layout) and
/// generates the corresponding code in string format, which can be used for
/// rendering or previewing the checkbox with the selected properties.
///
class ControlItemCodeGenerator {
  // Static method to generate the code based on control item customization state
  static String updateCode(BuildContext context, bool indeterminate, ControlItemType control) {
    String value = 'isChecked';
    String itemCode;

    switch (control) {
      case ControlItemType.radioButton:
        itemCode = 'RadioButtonItem';
        break;
      case ControlItemType.toggleSwitch:
        itemCode = 'SwitchItem';
        break;
      case ControlItemType.checkbox:
        itemCode = 'OudsCheckboxItem';
        break;
    }
    return """$itemCode(
value: $value,
${titleCode(context)}
${helperTitleCode(context)}
${reversedCode(context)}
${readOnlyCode(context)}
${iconCode(context)}
${errorCode(context)}
${dividerCode(context)}
${tristateCode(context, indeterminate)}
${disableCode(context)}
);""";
  }

  // Method to generate the disable code for the control item onChanged callback
  static String disableCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);

    return "onChanged: ${customizationState?.hasEnabled == true ? "(bool? value) { \n"
        "setState(() {\n "
        "isChecked = value;\n "
        "});\n}" : 'null'},";
  }

  // Method to generate the error code for the control item
  static String errorCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return 'isError: ${customizationState?.hasError == true ? 'true' : 'false'},';
  }

  // Method to generate the title code for the control item
  static String titleCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return """title: '${customizationState?.labelText}',""";
  }

  // Method to generate the helperTitle code for the control item
  static String helperTitleCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return customizationState!.helperLabelText.isEmpty ? 'helperTitle: null,' : """helperTitle: '${customizationState.helperLabelText}',""";
  }

  // Method to generate the reversed code for the control item
  static String reversedCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return "reversed: ${customizationState?.hasReversed},";
  }

  // Method to generate the readOnly code for the control item
  static String readOnlyCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return "readOnly: ${customizationState?.hasReadOnly},";
  }

  // Method to generate the icon code for the control item
  static String iconCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return "icon: ${customizationState?.hasIcon == true ? "'assets/ic_heart.svg'" : 'null'},";
  }

  // Method to generate the divider code for the control item
  static String dividerCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return "divider: ${customizationState?.hasDivider},";
  }

  // Method to generate the tristate code for the control item
  static String tristateCode(BuildContext context, bool indeterminate) {
    return indeterminate ? "\ntristate: $indeterminate,\n);" : "\n);";
  }
}
