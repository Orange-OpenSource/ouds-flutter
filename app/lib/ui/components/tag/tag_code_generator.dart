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
import 'package:ouds_core/components/tag/ouds_tag_icon_status.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

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
    final themeController = Provider.of<ThemeController>(context, listen: true);

    // Get the text value for the tag from customization state
    String label = customizationState?.labelText ?? "Label";

    // Get the tag's layout from customization state
    OudsTagLayout layout = TagCustomizationUtils.getLayout(customizationState?.selectedLayout as Object);
    OudsTagAppearance appearance = TagCustomizationUtils.getAppearance(customizationState!.selectedAppearance);
    OudsTagSize size = TagCustomizationUtils.getSize(customizationState.selectedSize as Object);
    OudsTagIconStatus status = TagCustomizationUtils.getTagIconStatus(context, customizationState, themeController);

    String code = '';
    String? appearanceCode = appearance == OudsTagAppearance.muted ? "OudsTagAppearance.muted" : "OudsTagAppearance.emphasized" ;
    String? sizeCode = size == OudsTagSize.small ? "OudsTagSize.small" : "OudsTagSize.defaultSize" ;
    String? statusCode =  _getStatusCode(customizationState);
    String? layoutCode = layout.toString();

    List<String> params = [
      '  label: "$label",',
       ' appearance: $appearanceCode,',
      ' enabled: ${customizationState.hasEnabled},',
      ' size: $sizeCode,',
       ' tagIconStatus: $statusCode,',
       ' layout: $layoutCode,',
      ' loading: ${customizationState.hasLoader}',
    ];

    // Switch on the layout type and generate the corresponding code
    switch (layout) {
      case OudsTagLayout.textOnly:
      case OudsTagLayout.textAndBullet:
        code = """OudsTag(\n${params.join('\n  ')}\n);""";
        break;

      case OudsTagLayout.textAndIcon:
        if(status == Neutral() || status ==  Accent()) {
          code = """OudsTag(\n${params.join(
              '\n  ')},\nicon: 'assets/ic_heart.svg'\n);""";
        }
        else{
          code = """OudsTag(\n${params.join('\n  ')}\n);""";
        }
        break;

    }

    return code; // Return the generated code as a string
  }

  static String _getStatusCode(TagCustomizationState? customizationState){
    switch (customizationState?.selectedStatus) {
      case TagEnumStatus.neutral:
        return """Neutral(icon: 'assets/ic_heart.svg')""";
      case TagEnumStatus.accent:
        return """Accent(icon: 'assets/ic_heart.svg')""";
      case TagEnumStatus.positive:
        return """Positive()""";
      case TagEnumStatus.info:
        return """Info()""";
      case TagEnumStatus.warning:
        return """Warning()""";
      default:
        return """Negative()""";
    }
  }

}
