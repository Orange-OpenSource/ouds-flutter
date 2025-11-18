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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization_utils.dart';

///
/// The ButtonCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a button component. It leverages the button's
/// customization state (such as label text, appearance, style, and layout) and
/// generates the corresponding code in string format, which can be used for
/// rendering or previewing the button with the selected properties.
///
class ButtonCodeGenerator {
  // Static method to generate the code based on button customization state
  static String updateCode(BuildContext context) {
    // Fetch the current button customization state from context
    final ButtonCustomizationState? customizationState = ButtonCustomization.of(context);

    // Get the text value for the button from customization state
    String label = customizationState?.textValue ?? "Button";

    // Get the button's appearance, style, and layout from customization state
    OudsButtonAppearance appearance = ButtonCustomizationUtils.getAppearance(customizationState?.selectedAppearance as Object);
    OudsButtonLayout layout = ButtonCustomizationUtils.getLayout(customizationState?.selectedLayout as Object);

    String code = '';

    // Switch on the layout type and generate the corresponding code
    switch (layout) {
      case OudsButtonLayout.textOnly:
        code = """${coloredSurfaceCodeModifier(context)}OudsButton(\nlabel: "$label",\nappearance: ${appearance.toString()},${loaderCodeModifier(context)}\n${disableCode(context)}""";
        break;

      case OudsButtonLayout.iconOnly:
        code = """${coloredSurfaceCodeModifier(context)}OudsButton(\nicon: 'assets/ic_heart.svg',\nappearance: ${appearance.toString()},${loaderCodeModifier(context)}\n${disableCode(context)}""";
        break;

      case OudsButtonLayout.iconAndText:
        code = """${coloredSurfaceCodeModifier(context)}OudsButton(\nicon: 'assets/ic_heart.svg',\nlabel: "$label",\nappearance: ${appearance.toString()},${loaderCodeModifier(context)}\n${disableCode(context)}""";
        break;
    }

    return code; // Return the generated code as a string
  }

  // Method to generate the disable code for the button's onPressed callback
  static String disableCode(BuildContext context) {
    final ButtonCustomizationState? customizationState = ButtonCustomization.of(context);

    String end = customizationState?.hasOnColoredBox == true ? " ),\n);" : ");";

    // Return the onPressed callback code with its enabled or disabled state
    return "onPressed: ${customizationState?.hasEnabled == true ? "() {}" : 'null'},\n$end";
  }

  static String loaderCodeModifier(BuildContext context) {
    final ButtonCustomizationState? customizationState = ButtonCustomization.of(context);
    if (customizationState?.hasLoader == true) {
      return "\nloader: Loader(progress: null),";
    } else {
      return "";
    }
  }

  // Method to generate code for a colored surface wrapper around the button, if needed
  static String coloredSurfaceCodeModifier(BuildContext context) {
    final ButtonCustomizationState? customizationState = ButtonCustomization.of(context);

    String code = '';

    // If the button should have a colored surface, wrap the button in OudsColoredBox
    if (customizationState?.hasOnColoredBox == true) {
      code = '''OudsColoredBox(\ncolor: OudsColoredBoxColor.brandPrimary,\nchild: ''';
    }

    return code;
  }
}
