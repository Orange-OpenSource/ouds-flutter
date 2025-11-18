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
  // List to manage inclusion of elements
  static List<String> _includedElements = [
    'titleCode',
    'additionalTitleCode',
    'helperTitleCode',
    'reversedCode',
    'readOnlyCode',
    'iconCode',
    'errorCode',
    'errorMessageCode',
    'dividerCode',
    'outlinedCode',
    'tristateCode',
    'groupValueCode',
    'disableCode',
    'disableCodeRadio'
  ];

  // Method to set the inclusion list
  static void setIncludedElements(List<String> elements) {
    _includedElements = elements;
  }

  // Static method to generate the code based on control item customization state
  static String updateCode(BuildContext context, bool indeterminate, ControlItemType control) {
    String value = 'isChecked';
    String itemCode;

    switch (control) {
      case ControlItemType.radioButton:
        itemCode = 'OudsRadioButtonItem<RadioOption>';
        value = 'RadioOption.option';
        break;
      case ControlItemType.switchButton:
        itemCode = 'SwitchItem';
        value = 'isChecked';
        break;
      case ControlItemType.checkbox:
        itemCode = 'OudsCheckboxItem';
        value = 'isChecked';
        break;
    }

    // Build the code string with conditional inclusion
    String code = """$itemCode(
value: $value,${control == ControlItemType.radioButton ? groupValueCode(context) : ''}
${control == ControlItemType.radioButton ? disableCodeRadio(context) : disableCode(context)}
${_includedElements.contains('titleCode') ? titleCode(context) : ''}
${_includedElements.contains('additionalTitleCode') ? additionalTitleCode(context) : ''}
${_includedElements.contains('helperTitleCode') ? helperTitleCode(context) : ''}
${_includedElements.contains('reversedCode') ? reversedCode(context) : ''}
${_includedElements.contains('readOnlyCode') ? readOnlyCode(context) : ''}
${_includedElements.contains('iconCode') ? iconCode(context) : ''}
${_includedElements.contains('errorCode') ? errorCode(context) : ''}
${_includedElements.contains('errorMessageCode') ? errorMessageCode(context) : ''}
${_includedElements.contains('dividerCode') ? dividerCode(context) : ''}${_includedElements.contains('outlinedCode') ? outlinedCode(context) : ''}${tristateCode(context, indeterminate)}
);""";

    return code;
  }

  // Method to generate the disable code for the control item onChanged callback
  static String disableCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);

    return "onChanged: ${customizationState?.hasEnabled == true ? "(bool? value) { \n"
        "setState(() {\n "
        "isChecked = value;\n "
        "});\n}" : 'null'},";
  }

  static String disableCodeRadio(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);

    return "onChanged: ${customizationState?.hasEnabled == true ? "(RadioOption? value) { \n"
        "setState(() {\n "
        "selectedOption = value;\n "
        "});\n}" : 'null'},";
  }

  // Method to generate the group value code for radio buttons
  static String groupValueCode(BuildContext context) {
    return '\ngroupValue: selectedOption,';
  }

  // Method to generate the error code for the control item
  static String errorCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return 'isError: ${customizationState?.hasError == true ? 'true' : 'false'},';
  }

  // Method to generate the error message code for the control item
  static String errorMessageCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return """errorText: '${customizationState?.errorMessageLabel}',""";
  }

  // Method to generate the title code for the control item
  static String titleCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return """title: '${customizationState?.labelText}',""";
  }

  // Method to generate the additional label code for the control item
  static String additionalTitleCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return customizationState!.additionalLabelText.isEmpty ? 'additionalLabel: null,' : """additionalLabel: '${customizationState.additionalLabelText}',""";
  }

  // Method to generate the helperTitle code for the control item
  static String helperTitleCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return customizationState!.descriptionLabel.isEmpty ? 'helperTitle: null,' : """helperTitle: '${customizationState.descriptionLabel}',""";
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

  // Method to generate the outlined code for the control item
  static String outlinedCode(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    return "\noutlined: ${customizationState?.hasOutlined},";
  }

  // Method to generate the tristate code for the control item
  static String tristateCode(BuildContext context, bool indeterminate) {
    return indeterminate ? "\ntristate: $indeterminate," : '';
  }
}
