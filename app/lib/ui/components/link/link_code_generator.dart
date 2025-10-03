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
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_customization.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_customization_utils.dart';

///
/// The TagCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a link component. It leverages the link's
/// customization state (such as label text, and layout) and
/// generates the corresponding code in string format, which can be used for
/// rendering or previewing the link with the selected properties.
///
class LinkCodeGenerator {
  // Static method to generate the code based on link customization state
  static String updateCode(BuildContext context) {
    // Fetch the current tag customization state from context
    final LinkCustomizationState? customizationState = LinkCustomization.of(context);

    // Get the text value for the tag from customization state
    String label = customizationState?.labelText ?? "Label";

    // Get the link's layout from customization state
    OudsLinkLayout layout = LinkCustomizationUtils.getLayout(customizationState?.selectedLayout as Object);
    OudsLinkSize size = LinkCustomizationUtils.getSize(customizationState?.selectedSize as Object);

    String? sizeCode = size == OudsLinkSize.small ? "OudsLinkSize.small" : null ;
    String? layoutCode = layout != OudsLinkLayout.textOnly ? layout.toString() : null ;
    String? iconCode = layout == OudsLinkLayout.textAndIcon? 'assets/ic_heart.svg' : null;
    String? pressedCode = " ${customizationState?.hasEnabled == true ? "() {}" : 'null'}";

    List<String> params = [
      '  label: "$label",',
      if (sizeCode != null) 'size: $sizeCode',
      if (layoutCode != null) 'layout: $layoutCode',
      if(iconCode != null) 'icon: $iconCode',
      'onPressed:$pressedCode'
    ];

    return """${coloredSurfaceCodeModifier(context)}OudsLink(\n${params.join('\n  ')}\n);""";
    // Return the generated code as a string
  }

  // Method to generate code for a colored surface wrapper around the button, if needed
  static String coloredSurfaceCodeModifier(BuildContext context) {
    final LinkCustomizationState? customizationState = LinkCustomization.of(context);

    String code = '';

    // If the button should have a colored surface, wrap the button in OudsColoredBox
    if (customizationState?.hasOnColoredBox == true) {
      code = '''OudsColoredBox(\ncolor: OudsColoredBoxColor.brandPrimary,\nchild: ''';
    }

    return code;
  }

}
