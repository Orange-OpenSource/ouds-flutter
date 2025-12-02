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
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_demo_screen.dart';

///
/// The RadioButtonCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a radio button component. It leverages the radio button's
/// customization state, specifically the enabled, error, read-only, and tristate states,
/// and generates the corresponding code in string format, which can be used for rendering
/// or previewing the radio button with the selected properties.
///
class RadioButtonCodeGenerator {
  /// Static method to generate the code based on radio button customization state.
  static String updateCode(BuildContext context, bool indeterminate, RadioOption selectedOption) {
    final RadioButtonCustomizationState? customizationState = RadioButtonCustomization.of(context);

    bool value = selectedOption == RadioOption.first;

    // Base list for building the radio button code dynamically.
    final List<String> code = [];
    code.add('First Radio Button:');
    code.add('OudsRadioButton<RadioOption>(');
    code.add('  value: $value,');
    code.add('  groupValue: $value,');

    // Add the onChanged callback only when enabled.
    if (customizationState?.hasEnabled == true) {
      code.add('  onChanged: (RadioOption? value) {');
      code.add('    setState(() {');
      code.add('      isSelected = value;');
      code.add('    });');
      code.add('  },');
    } else {
      code.add('  onChanged: null,');
    }

    // Add the isError property only when true.
    if (customizationState?.hasError == true) {
      code.add('  isError: true,');
    }

    // Add the readOnly property only when true.
    if (customizationState?.hasReadOnly == true) {
      code.add('  readOnly: true,');
    }

    // Add tristate only when indeterminate is true.
    if (indeterminate) {
      code.add('  tristate: true,');
    }

    // End of the widget declaration.
    code.add(');');

    // Return the formatted code as a single string.
    return code.join('\n');
  }
}
