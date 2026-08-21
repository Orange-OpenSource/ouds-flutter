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
import 'package:ouds_flutter_demo/ui/components/link/link_enum.dart';

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
    final LinkCustomizationState? customizationState = LinkCustomization.of(
      context,
    );

    // Get the text value for the tag from customization state
    String label = customizationState?.labelText ?? "Label";

    // Get layout & size from customization state
    LinkEnumLayout layout =
        customizationState?.selectedLayout ?? LinkEnumLayout.textOnly;
    OudsLinkSize size = LinkCustomizationUtils.getSize(
      customizationState?.selectedSize as Object,
    );
    OudsLinkDensity density = LinkCustomizationUtils.getDensity(
      customizationState?.selectedDensity as Object,
    );

    String? sizeCode = size == OudsLinkSize.small
        ? OudsLinkSize.small.toString()
        : 'OudsLinkSize.default';
    String? densityCode = density == OudsLinkDensity.compact
        ? OudsLinkDensity.compact.toString()
        : 'OudsLinkDensity.default';
    String? pressedCode =
        " ${customizationState?.hasEnabled == true ? "() {}" : 'null'}";

    // Determines the dedicated OudsLink constructor name matching the layout.
    String constructorName = switch (layout) {
      LinkEnumLayout.textAndIcon => "OudsLink.icon",
      LinkEnumLayout.next => "OudsLink.next",
      LinkEnumLayout.previous => "OudsLink.previous",
      LinkEnumLayout.external => "OudsLink.external",
      LinkEnumLayout.textOnly => "OudsLink",
    };

    List<String> params = [
      '  label: "$label",',
      if (layout == LinkEnumLayout.textAndIcon) ...[
        '  icon: "assets/ic_heart.svg",',
        '  tinted: ${customizationState?.isTinted ?? true},',
      ],
      '  size: $sizeCode,',
      '  density: $densityCode,',
      '  onPressed:$pressedCode',
    ];

    // Base widget
    String code = "$constructorName(\n${params.join('\n')}\n)";

    // Apply colored surface wrapper if needed
    code = coloredSurfaceCodeModifier(context, code);

    return "$code;";
  }

  // Method to wrap code with colored background or theme if needed
  static String coloredSurfaceCodeModifier(
    BuildContext context,
    String childCode,
  ) {
    final LinkCustomizationState? customizationState = LinkCustomization.of(
      context,
    );

    if (customizationState?.hasOnColoredBox == true) {
      return '''
OudsTheme(
  themeContract: OrangeTheme(),
  themeMode: ThemeMode.light,
  onColoredSurface: true,
  child: Builder(
    builder: (context) {
      return OudsColoredBox(
        color: OudsColoredBoxColor.brandPrimary,
        child: $childCode,
      );
    },
  ),
)''';
    }

    return childCode;
  }
}
