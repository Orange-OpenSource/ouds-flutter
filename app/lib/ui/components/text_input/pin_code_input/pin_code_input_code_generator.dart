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
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/pin_code_input/pin_code_input_enum.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization_utils.dart';

class PinCodeInputCodeGenerator {
  static String updateCode(BuildContext context) {
    final TextInputCustomizationState? state = TextInputCustomization.of(context);

    if (state == null) return "OudsPinCodeInput(),";

    List<String> lines = [];

    if (state.hasHelperText) {
      lines.add(
          'helperText: ${TextInputCustomizationUtils.getPinCodeHelperText(state, PinCodeLengthEnum.getHelperText(context, state.selectedPinCodeLength))},');
    }

    if (state.hasRoundedCorner) {
      lines.add('roundedCorner: true,');
    }

    if (state.hasError) {
      lines.add(
          'errorText: ${context.l10n.app_components_pin_code_input_error_label},');
    }

    final style = TextInputCustomizationUtils.getStyle(state.selectedStyle);
    lines.add('style: $style,');

    final length = TextInputCustomizationUtils.getLength(state.selectedPinCodeLength);
    lines.add('length: $length,');

    lines.add('onCompleted: (value) {\n  //handle completed pin code\n},');
    
    final String decoration = _digitDecorationCode(state);

    return [
      "OudsPinCodeInput(",
      ...lines,
      decoration,
      "),"
    ].join("\n");
  }

  static String _digitDecorationCode(TextInputCustomizationState state) {
    List<String> props = [];

    if (state.placeholderText.isNotEmpty) {
      final hint = TextInputCustomizationUtils.getPlaceholderText(state);
      props.add('hintText: "$hint",');
    }

    if (state.hasHiddenPassword) {
      props.add('hiddenPassword: true,');
    }

    if (props.isEmpty) {
      return "digitInputDecoration: OudsDigitInputDecoration(),";
    }

    return "digitInputDecoration: OudsDigitInputDecoration(\n${props.join("\n")}\n),";
  }
}
