/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */
import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization_utils.dart';

class TextInputCodeGenerator {
  static String updateCode(BuildContext context) {
    final TextInputCustomizationState? state = TextInputCustomization.of(context);

    String boolPropertiesCode = generateBoolPropertiesCode(state);

    String decoration = decorationCode(
      context,
      state?.labelText ?? '',
      state?.suffixText ?? '',
      state?.prefixText ?? '',
      state?.placeholderText ?? '',
      state?.helperText ?? '',
      state?.hasTrailingIcon,
      state?.hasLeadingIcon,
      state?.hasLoader ?? false,
      state?.selectedStyle,
      state?.hasError == true, // Pass hasError here for decoration
    );

    List<String> codeParts = ["OudsTextInput(", if (boolPropertiesCode.trim().isNotEmpty) boolPropertiesCode, decoration, "),"];

    return codeParts.join("\n");
  }

  static String generateBoolPropertiesCode(TextInputCustomizationState? state) {
    if (state == null) return "";

    List<String> lines = [];

    if (state.hasEnabled != true) {
      lines.add('enabled: false,');
    }

    if (state.hasReadOnly == true) {
      lines.add('readOnly: true,');
    }

    return lines.join("\n");
  }

  static String decorationCode(
    BuildContext context,
    String label,
    String suffix,
    String prefix,
    String hintText,
    String helperText,
    bool? suffixIcon,
    bool? prefixIcon,
    bool hasLoader,
    Object? selectedStyle,
    bool hasError,
  ) {
    List<String> lines = [];

    if (label.trim().isNotEmpty) lines.add('  labelText: "$label",');
    if (suffix.trim().isNotEmpty) lines.add('  suffix: "$suffix",');
    if (prefix.trim().isNotEmpty) lines.add('  prefix: "$prefix",');
    if (hintText.trim().isNotEmpty) lines.add('  hintText: "$hintText",');
    if (helperText.trim().isNotEmpty) lines.add('  helperText: "$helperText",');
    if (suffixIcon == true) lines.add('  suffixIcon: Icon(Icons.favorite_border),');
    if (prefixIcon == true) lines.add("  prefixIcon: 'assets/ic_heart.svg',");
    if (hasLoader) lines.add('  loader: Loader(progress: null),');
    if (hasError) lines.add('  errorText: "This field can’t..",');

    if (selectedStyle != null) {
      final style = TextInputCustomizationUtils.getStyle(selectedStyle);
      lines.add('  style: $style,');
    }

    if (lines.isEmpty) return "decoration: OudsInputDecoration(),";

    return "decoration: OudsInputDecoration(\n${lines.join("\n")}\n ),";
  }
}
