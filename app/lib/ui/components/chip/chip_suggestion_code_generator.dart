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
import 'package:ouds_core/components/chip/ouds_suggestion_chip.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization_utils.dart';

///
/// The ChipSuggestionCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a suggestion chip component. It leverages the chip's
/// customization state (such as label text, and layout) and
/// generates the corresponding code in string format, which can be used for
/// rendering or previewing the chip with the selected properties.
///
class ChipSuggestionCodeGenerator {
  // Static method to generate the code based on chip customization state
  static String updateCode(BuildContext context) {
    // Fetch the current chip customization state from context
    final ChipCustomizationState? customizationState = ChipCustomization.of(context);

    // Get the text value for the chip from customization state
    String label = customizationState?.labelText ?? "Label";

    // Get the chip's layout from customization state
    OudsChipLayout layout = ChipCustomizationUtils.getLayout(customizationState?.selectedLayout as Object);

    String code = '';

    // Switch on the layout type and generate the corresponding code
    switch (layout) {
      case OudsChipLayout.textOnly:
        code = """OudsSuggestionChip(\nlabel: "$label",\nonPressed: ${customizationState?.hasEnabled == true ? "() {}" : 'null'},\n);""";
        break;

      case OudsChipLayout.iconOnly:
        code = "OudsSuggestionChip(\navatar: 'assets/ic_heart.svg',\nonPressed: ${customizationState?.hasEnabled == true ? "() {}" : 'null'},\n);";
        break;

      case OudsChipLayout.iconAndText:
        code = """OudsSuggestionChip(\nlabel: "$label",\navatar: 'assets/ic_heart.svg',\nonPressed: ${customizationState?.hasEnabled == true ? "() {}" : 'null'},\n);""";
        break;
    }

    return code; // Return the generated code as a string
  }
}
