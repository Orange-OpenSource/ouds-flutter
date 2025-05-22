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
import 'package:ouds_flutter_demo/ui/components/switch/switch_customization.dart';

///
/// The SwitchCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a Switch component. It leverages the Switch's
/// customization state, specifically the enabled and error states, and generates
/// the corresponding code in string format, which can be used for rendering or
/// previewing the Switch with the selected properties.
///
class SwitchCodeGenerator {
  // Static method to generate the code based on Switch customization state
  static String updateCode(BuildContext context) {
    // Get the text value for the Switch from customization state
    String value = 'isSwitched';

    return """OudsSwitch(\nvalue: $value,\n${disableCode(context)}\n${EnableCode(context)}}""";
  }

  // Method to generate the disable code for the Switch onChanged callback
  static String disableCode(BuildContext context) {
    final SwitchCustomizationState? customizationState = SwitchCustomization.of(context);

    // Return the onChanged callback code with its enabled or disabled state
    return "onChanged: ${customizationState?.hasEnabled == true ? "(bool? value) { \n"
        "setState(() {\n "
        "isSwitched = value;\n "
        "});\n}" : 'null'},";
  }

  // Method to generate the error code for the checkbox
  static String EnableCode(BuildContext context) {
    final SwitchCustomizationState? customizationState = SwitchCustomization.of(context);

    // Return the isError property based on the customization state
    return 'enabled: ${customizationState?.hasEnabled == true ? 'true' : 'false'}';
  }
}
