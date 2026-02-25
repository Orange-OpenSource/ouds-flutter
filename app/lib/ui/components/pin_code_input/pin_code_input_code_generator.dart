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
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_customization_utils.dart';

class PinCodeInputCodeGenerator {
  static String updateCode(BuildContext context) {
    final PinCodeInputCustomizationState? state = PinCodeInputCustomization.of(context);

    if (state == null) return "OudsPinCodeInput(),";

    List<String> lines = [];

    lines.add(" controllers: controllers,");

    if (state.hasHelperText && !state.hasError) {
      lines.add(' helperText: "${PinCodeInputCustomizationUtils.getPinCodeHelperText(state)}",');
    }

    if (state.hasError) {
      lines.add(' errorText: "${PinCodeInputCustomizationUtils.getPinCodeErrorText(state)}",');
    }

    final length = PinCodeInputCustomizationUtils.getLength(state.selectedPinCodeLength);
    lines.add(' length: $length,');

    lines.add(' onEditingComplete: (value) {\n  //handle completed pin code\n},');

    lines.add(' onChange: (value) {\n  //handle change digit input\n},');

    final String decoration = _digitDecorationCode(state);

    return ["OudsPinCodeInput(", ...lines, decoration, "),"].join("\n");
  }

  static String _digitDecorationCode(PinCodeInputCustomizationState state) {
    List<String> props = [];

    if (state.pinCodePlaceholderText.isNotEmpty) {
      final hint = PinCodeInputCustomizationUtils.getPinCodePlaceholderText(state);
      props.add(' hintText: "$hint",');
    }

    if (state.hasHiddenPassword) {
      props.add(' hiddenPassword: ${state.hasHiddenPassword},');
    }

    if (state.hasOutlined) {
      props.add(' isOutlined: ${state.hasOutlined},');
    }

    if (props.isEmpty) {
      return "digitInputDecoration: OudsDigitInputDecoration(),";
    }

    return "digitInputDecoration: OudsDigitInputDecoration(\n${props.join("\n")}\n),";
  }
}
