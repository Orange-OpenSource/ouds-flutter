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
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization_utils.dart';

///
/// The TagCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a tag component. It leverages the tag's
/// customization state (such as label text, and layout) and
/// generates the corresponding code in string format, which can be used for
/// rendering or previewing the tag with the selected properties.
///
class TagCodeGenerator {
  // Static method to generate the code based on tag customization state
  static String updateCode(BuildContext context) {
    // Fetch the current tag customization state from context
    final TagCustomizationState? customizationState = TagCustomization.of(context);

    // Get the text value for the tag from customization state
    String label = customizationState?.labelText ?? "Label";

    // Get the tag's layout from customization state
    OudsTagLayout layout = TagCustomizationUtils.getLayout(customizationState?.selectedLayout as Object);
    OudsTagHierarchy hierarchy = TagCustomizationUtils.getHierarchy(customizationState?.selectedHierarchy as Object);
    OudsTagSize size = TagCustomizationUtils.getSize(customizationState?.selectedSize as Object);
    OudsTagStatus status = TagCustomizationUtils.getStatus(customizationState?.selectedStatus as Object);


    String code = '';
    String? hierarchyCode = hierarchy != OudsTagHierarchy.emphasized ? "OudsTagHierarchy.muted" : null ;
    String? sizeCode = size == OudsTagSize.small ? "OudsTagSize.small" : null ;
    String? statusCode = status != OudsTagStatus.neutral ? status.toString() : null ;
    String? layoutCode = layout != OudsTagLayout.textOnly ? layout.toString() : null ;

    List<String> params = [
      '  label: "$label",',
      if (hierarchyCode != null) 'hierarchy: $hierarchyCode',
      if (statusCode != null) 'status: $statusCode',
      if (sizeCode != null) 'size: $sizeCode',
      if (layoutCode != null) 'layout : $layoutCode'
    ];



    // Switch on the layout type and generate the corresponding code
    switch (layout) {
      case OudsTagLayout.textOnly:
      case OudsTagLayout.textAndLoader:
      case OudsTagLayout.textAndBullet:
        code = """OudsTag(\n${params.join('\n  ')}\n);""";
        break;

      case OudsTagLayout.textAndIcon:
        if(status == OudsTagStatus.neutral || status == OudsTagStatus.disabled || status ==  OudsTagStatus.accent) {
          code = """OudsTag(\n${params.join(
              '\n  ')},\nicon: 'assets/ic_heart.svg',\n},\n);""";
        }
        else{
          code = """OudsTag(\n${params.join('\n  ')}\n);""";
        }
        break;

    }

    return code; // Return the generated code as a string
  }

}
