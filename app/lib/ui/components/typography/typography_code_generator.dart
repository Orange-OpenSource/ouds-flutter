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

import 'package:material_ui/material_ui.dart';
import 'package:ouds_core/components/typography/ouds_heading_text.dart';
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
    final size = variant != TypographyVariant.code
        ? customizationState?.selectedSize ?? defaultSizeFor(variant)
        : null;
    final text = customizationState?.labelText;
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
    final sizeLine = variant != TypographyVariant.code
        ? "size: ${sizeEnumNameFor(variant)}.${(size as Enum).name},"
        : "";
    if (hasAnnotatedText) {
      final appendLines = annotatedTextSegmentsFor(context, variant)
          .map((segment) {
            final escapedText = segment.text
                .replaceAll('\\', r'\\')
                .replaceAll("'", r"\'")
                .replaceAll('\n', r'\n');
            return segment.colorTokenName == null
                ? "    builder.append('$escapedText');"
                : "    builder.withColor(\n"
                      "      (context) => OudsTheme.of(context).colorScheme(context).${segment.colorTokenName},\n"
                      "      () => builder.append('$escapedText'),\n"
                      "    );";
          })
          .join('\n');
      return """
${variant != TypographyVariant.code ? '${classNameFor(variant)}.rich(\n  $sizeLine$weightLine$markerLine' : '${classNameFor(variant)}.rich('}
  text: buildOudsAnnotatedText((builder) {
$appendLines
  }),
)""";
    }

    if (variant == TypographyVariant.code) {
      return """${classNameFor(variant)}(text: '$text')""";
    }

    return """${classNameFor(variant)}(
  text: '$text',
  $sizeLine$weightLine$markerLine
)""";
  }
}
