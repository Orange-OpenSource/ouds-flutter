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
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';

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
    final TagCustomizationState? customizationState = TagCustomization.of(
      context,
    );

    // Get the text value for the tag from customization state
    String label = customizationState?.labelText ?? "Label";

    // Get the tag's layout from customization state
    OudsTagLayout layout = TagCustomizationUtils.getLayout(
      customizationState?.selectedLayout as Object,
    );
    OudsTagAppearance appearance = TagCustomizationUtils.getAppearance(
      customizationState!.selectedAppearance,
    );
    OudsTagSize size = TagCustomizationUtils.getSize(
      customizationState.selectedSize as Object,
    );

    String? appearanceCode = appearance == OudsTagAppearance.muted
        ? "OudsTagAppearance.muted"
        : "OudsTagAppearance.emphasized";
    String? sizeCode = size == OudsTagSize.small
        ? "OudsTagSize.small"
        : "OudsTagSize.defaultSize";
    String? statusCode = _getStatusCode(customizationState);

    List<String> params = [
      ' label: "$label",',
      ' appearance: $appearanceCode,',
      ' enabled: ${customizationState.hasEnabled},',
      ' size: $sizeCode,',
      ' status: $statusCode,',
      ' loading: ${customizationState.hasLoader},',
      ' roundedCorners: ${customizationState.hasRoundedCorner}',
    ];

    switch (layout) {
      case OudsTagLayout.textOnly:
        return """OudsTag.text(\n${params.join('\n  ')}\n);""";
      case OudsTagLayout.textAndIcon:
        return """OudsTag.icon(\n${params.join('\n  ')}\n);""";
      case OudsTagLayout.textAndBullet:
        return """OudsTag.bullet(\n${params.join('\n  ')}\n);""";
    }
  }

  static String _getStatusCode(TagCustomizationState? customizationState) {
    final withIcon =
        customizationState?.selectedLayout == TagEnumLayout.iconAndText;
    switch (customizationState?.selectedStatus) {
      case StatusEnum.neutral:
        return """Neutral(${withIcon ? "icon: 'assets/heart-empty.svg'" : ""})""";
      case StatusEnum.accent:
        return """Accent(${withIcon ? "icon: 'assets/heart-empty.svg'" : ""})""";
      case StatusEnum.positive:
        return """Positive()""";
      case StatusEnum.info:
        return """Info()""";
      case StatusEnum.warning:
        return """Warning()""";
      default:
        return """Negative()""";
    }
  }
}
