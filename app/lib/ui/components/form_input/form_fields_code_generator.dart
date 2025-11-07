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
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_customization.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_enum.dart';

class FormFieldsCodeGenerator {
  static String updateCode(BuildContext context, FormFieldsTypeEnum inputTypeEnum) {
    final FormFieldsCustomizationState? state = FormFieldsCustomization.of(context);
    String boolPropertiesCode = generateBoolPropertiesCode(state, inputTypeEnum);
    String linkCode = "helperLink:\nOudsLink(\n"
        " label: '${state?.helperLinkText}',\n"
        " onPressed: () {},\n),";
    List<String> codeParts;

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
      state?.hasOutlined ?? false,
      state?.hasError == true,
      inputTypeEnum,
    );

    switch (inputTypeEnum) {
      case FormFieldsTypeEnum.textInput:
        codeParts = ["OudsTextField(", if (boolPropertiesCode.trim().isNotEmpty) boolPropertiesCode,linkCode, decoration, "),"];
        break;
      case FormFieldsTypeEnum.phoneNumberInput:
        codeParts = ["OudsPhoneNumberInput(", if (boolPropertiesCode.trim().isNotEmpty) boolPropertiesCode, decoration, "),"];
        break;
      case FormFieldsTypeEnum.passwordInput:
        codeParts = ["OudsPasswordInput(", if (boolPropertiesCode.trim().isNotEmpty) boolPropertiesCode, decoration, "),"];
        break;
    }

    return codeParts.join("\n");
  }

  static String generateBoolPropertiesCode(FormFieldsCustomizationState? state, FormFieldsTypeEnum inputTypeEnum) {
    if (state == null) return "";

    List<String> lines = [];

    if (state.hasEnabled != true) {
      lines.add('enabled: false,');
    }

    if (state.hasReadOnly == true) {
      lines.add('readOnly: true,');
    }

    if (state.hasCountrySelector == true && inputTypeEnum == FormFieldsTypeEnum.phoneNumberInput) {
      lines.add('countrySelector: CountrySelector(countryFilter:\n CountryFilter.custom,\n codes: ["fr", "tn", "us"],\n onCountryChanged: (country) {},\n ),');
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
    bool? hasOutlined,
    bool hasError,
    FormFieldsTypeEnum inputTypeEnum,
  ) {
    List<String> lines = [];

    if (hasOutlined == true) lines.add('  outlined: true,');
    if (label.trim().isNotEmpty) lines.add('  labelText: "$label",');
    if (suffix.trim().isNotEmpty) lines.add('  suffix: "$suffix",');
    if (prefix.trim().isNotEmpty) lines.add('  prefix: "$prefix",');
    if (hintText.trim().isNotEmpty) lines.add('  hintText: "$hintText",');
    if (helperText.trim().isNotEmpty) lines.add('  helperText: "$helperText",');
    if (hasLoader) lines.add('  loader: true,');

    String decorationClass = "OudsInputDecoration";

    switch (inputTypeEnum) {
      case FormFieldsTypeEnum.phoneNumberInput:
        break;
      case FormFieldsTypeEnum.passwordInput:
        decorationClass = "OudsPasswordInputDecoration";
        if (prefixIcon == true) lines.add("  prefixIcon: true,");
        if (hasError) lines.add('  errorText: "Please enter your password.",');
        break;
      default:
        if (suffixIcon == true) lines.add("  suffixIcon: 'assets/ic_heart.svg',\n onSuffixPressed: () {},");
        if (prefixIcon == true) lines.add("  prefixIcon: 'assets/ic_heart.svg',");
        if (hasError) lines.add('  errorText: "This field can’t..",');
    }

    if (lines.isEmpty) return "decoration: $decorationClass(),";

    return "decoration: $decorationClass(\n${lines.join("\n")}\n ),";
  }
}
