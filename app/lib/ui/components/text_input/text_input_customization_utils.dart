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
import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/pin_code_input/ouds_pin_code_input.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/pin_code_input/pin_code_input_enum.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_enum.dart';

/// Utility class to map button customization options to corresponding TextInput attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [TextInput] properties.

class TextInputCustomizationUtils {
  /// Retrieves the label text to display based on the current customization state.
  static String? getLabelText(TextInputCustomizationState customizationState) {
    final label = customizationState.labelText;
    return label.isEmpty ? null : label;
  }

  /// Retrieves the suffix text to display based on the current customization state.
  static String? getSuffixText(TextInputCustomizationState customizationState) {
    final label = customizationState.suffixText;
    return label.isEmpty ? null : label;
  }

  /// Retrieves the prefix text to display based on the current customization state.
  static String? getPrefixText(TextInputCustomizationState customizationState) {
    final label = customizationState.prefixText;
    return label.isEmpty ? null : label;
  }

  /// Retrieves the placeholder text to display based on the current customization state.
  static String? getPlaceholderText(TextInputCustomizationState customizationState) {
    final label = customizationState.placeholderText;
    return label.isEmpty ? null : label;
  }

  /// Retrieves the helper text to display based on the current customization state.
  static String? getHelperText(TextInputCustomizationState customizationState) {
    final label = customizationState.helperText;
    return label.isEmpty ? null : label;
  }

  /// Maps the style enum to `OudsButtonStyle`.
  static OudsTextInputStyle getStyle(Object style) {
    switch (style) {
      case TextInputEnumStyle.defaultStyle:
        return OudsTextInputStyle.defaultStyle;
      default:
        return OudsTextInputStyle.alternative;
    }
  }

  //TODO this functions for Pin Code Input

  /// Maps the length enum to 'OudsPinCodeInputLength'
  static OudsPinCodeInputLength getLength(Object length) {
    switch (length) {
      case PinCodeLengthEnum.four:
        return OudsPinCodeInputLength.four;
      case PinCodeLengthEnum.six:
        return OudsPinCodeInputLength.six;
      default:
        return OudsPinCodeInputLength.eight;
    }
  }

  /// Retrieves the helper text to display based on the current length.
  static String getPinCodeHelperText(TextInputCustomizationState customizationState, String customHelperText) {

    final label = customizationState.pinCodeHelperText;
    return label.isEmpty ? customHelperText : label;
  }

  /// Retrieves the pin code placeholder text to display based on the current customization state.
  static String? getPinCodePlaceholderText(TextInputCustomizationState customizationState) {
    final label = customizationState.pinCodePlaceholderText;
    debugPrint("TEST label = $label");
    return label.isEmpty ? null : label;
  }

  /// Retrieves the pin code error text to display based on the current customization state.
  static String? getPinCodeErrorText(TextInputCustomizationState customizationState,String customErrorText) {
    final label = customizationState.pinCodeErrorText;
    return label.isEmpty ? customErrorText : label;
  }
}
