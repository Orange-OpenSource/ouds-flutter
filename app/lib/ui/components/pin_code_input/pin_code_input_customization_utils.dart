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
import 'package:ouds_core/components/pin_code_input/ouds_pin_code_input.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_enum.dart';

/// Utility class to map button customization options to corresponding PinCodeInput attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [PinCodeInput] properties.

class PinCodeInputCustomizationUtils {

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
  static String? getPinCodeHelperText(PinCodeInputCustomizationState customizationState) {

    final label = customizationState.pinCodeHelperText;
    return label.isEmpty ? null : label;
  }

  /// Retrieves the pin code placeholder text to display based on the current customization state.
  static String? getPinCodePlaceholderText(PinCodeInputCustomizationState customizationState) {
    final label = customizationState.pinCodePlaceholderText;
    return label.isEmpty ? null : label;
  }

  /// Retrieves the pin code error text to display based on the current customization state.
  static String? getPinCodeErrorText(PinCodeInputCustomizationState customizationState) {
    final label = customizationState.pinCodeErrorText;
    return label.isEmpty ? null : label;
  }

  /// Maps the style enum to `OudsTextInputStyle`.
  static OudsTextInputStyle getStyle(Object style) {
    switch (style) {
      case PinCodeInputEnumStyle.defaultStyle:
        return OudsTextInputStyle.defaultStyle;
      default:
        return OudsTextInputStyle.alternative;
    }
  }
}