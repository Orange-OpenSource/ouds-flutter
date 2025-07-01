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
import 'package:ouds_core/components/chip/ouds_chip.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization_utils.dart';

///
/// The ChipFilterCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a chip component. It leverages the chip's
/// customization state (such as label text, and layout) and
/// generates the corresponding code in string format, which can be used for
/// rendering or previewing the chip with the selected properties.
///
class ChipFilterCodeGenerator {
  // Static method to generate the code based on chip customization state
  static String updateCode(BuildContext context) {
    // Fetch the current chip customization state from context
    final ChipCustomizationState? customizationState = ChipCustomization.of(context);

    // Get the text value for the chip from customization state
    String label = customizationState?.labelText ?? "Label";
    bool? isEnabled = customizationState?.hasEnabled;

    // Get the chip's layout from customization state
    OudsChipLayout layout = ChipCustomizationUtils.getLayout(customizationState?.selectedLayout as Object);

    String code = '';

    // Switch on the layout type and generate the corresponding code
    switch (layout) {
      case OudsChipLayout.textOnly:
        code = """OudsFilterChip(\nlabel: "$label",\nselected: ${customizationState?.hasSelected == true ? "true" : 'false'},\n${disableCode(context)}\n);""";
        break;

      case OudsChipLayout.iconOnly:
        code = "OudsFilterChip(\navatar: 'assets/ic_chip_heart.svg',\nselected: ${customizationState?.hasSelected == true ? "true" : 'false'},\n${disableCode(context)}\n);";
        break;

      case OudsChipLayout.iconAndText:
        code = """OudsFilterChip(\nlabel: "$label",\navatar: 'assets/ic_chip_heart.svg',\nselected: ${customizationState?.hasSelected == true ? "true" : 'false'},\n${disableCode(context)}\n);""";
        break;
    }

    return code; // Return the generated code as a string
  }

  // Method to generate the disable code for the checkbox onChanged callback
  static String disableCode(BuildContext context) {
    final ChipCustomizationState? customizationState = ChipCustomization.of(context);
    // Return the onChanged callback code with its enabled or disabled state
    return "onSelected: ${customizationState?.hasEnabled == true ? "(bool newValue) { \n"
        "setState(() {\n "
        "isSelected = newValue;\n "
        "});\n}" : 'null'},";
  }
}
