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
import 'package:ouds_flutter_demo/ui/components/switch/switch_customization.dart';

///
/// The SwitchCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a Switch component. It leverages the Switch's
/// customization state, specifically the enabled, error, and read-only states,
/// and generates the corresponding code in string format, which can be used for
/// rendering or previewing the Switch with the selected properties.
///
class SwitchCodeGenerator {
  /// Static method to generate the code based on switch customization state.
  static String updateCode(BuildContext context) {
    final SwitchCustomizationState? customizationState = SwitchCustomization.of(context);

    // Base list for building the switch code dynamically.
    final List<String> code = [];
    code.add('OudsSwitch(');
    code.add('  value: isSwitched,');

    // Add the onChanged callback only when enabled.
    if (customizationState?.hasEnabled == true) {
      code.add('  onChanged: (bool? value) {');
      code.add('    setState(() {');
      code.add('      isSwitched = value;');
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

    // End of the widget declaration.
    code.add(');');

    // Return the formatted code as a single string.
    return code.join('\n');
  }
}
