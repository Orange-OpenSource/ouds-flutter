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
import 'package:ouds_core/components/typography/ouds_typography.dart';
import 'package:ouds_flutter_demo/ui/components/typography/typography_customization.dart';
import 'package:ouds_flutter_demo/ui/components/typography/typography_enum.dart';

/// The TypographyCodeGenerator class is responsible for dynamically generating Flutter code for
/// the customization of a typography component. It leverages the typography's customization
/// state, specifically the selected size and label text, and generates the corresponding code in
/// string format, which can be used for rendering or previewing the widget with the selected
/// properties.
class TypographyCodeGenerator {
  // Static method to generate the code based on the typography customization state
  static String updateCode(BuildContext context, TypographyVariant variant) {
    final customizationState = TypographyCustomization.of(context);
    final size = customizationState?.selectedSize ?? defaultSizeFor(variant);
    final text = customizationState?.labelText ?? '';
    final marker = customizationState?.hasMarker ?? true;
    final markerLine =
        variant == TypographyVariant.heading &&
            size == OudsHeadingTextSize.large
        ? '\n  marker: $marker,'
        : '';
    final weight = customizationState?.selectedWeight;
    final weightLine = hasWeightFor(variant) && weight != null
        ? '\n  weight: OudsTextWeight.${weight.name},'
        : '';
    final hasAnnotatedText = customizationState?.hasAnnotatedText ?? false;

    if (variant == TypographyVariant.heading && hasAnnotatedText) {
      return """OudsHeadingText.rich(
  size: ${sizeEnumNameFor(variant)}.${(size as Enum).name},$markerLine
  text: buildOudsAnnotatedHeadingText((builder) {
    builder.append('Heading with ');
    builder.withColor(color, () => builder.append('colored text'));
  }),
)""";
    }

    return """${classNameFor(variant)}(
  text: '$text',
  size: ${sizeEnumNameFor(variant)}.${(size as Enum).name},$weightLine$markerLine
)""";
  }
}
