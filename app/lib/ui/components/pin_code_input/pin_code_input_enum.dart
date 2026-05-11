
import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';


/// Represents the length of an OUDS PinCodeInput.
enum PinCodeLengthEnum {
  four,
  six,
  eight;

  const PinCodeLengthEnum();

  static String enumName(BuildContext context) {
    return context.l10n.app_components_pinCodeInput_length_label;
  }

  static String getHelperText(BuildContext context, PinCodeLengthEnum value){

      switch (value) {
        case PinCodeLengthEnum.four:
          return context.l10n.app_components_pinCodeInput_helperText_description_text_4;
        case PinCodeLengthEnum.six:
          return context.l10n.app_components_pinCodeInput_helperText_description_text_6;
        case PinCodeLengthEnum.eight:
          return context.l10n.app_components_pinCodeInput_helperText_description_text_8;
      }

  }
}

extension CustomElementLayout on PinCodeLengthEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case PinCodeLengthEnum.four:
        return "4";
      case PinCodeLengthEnum.six:
        return "6";
      case PinCodeLengthEnum.eight:
        return "8";
    }
  }
}

/// Mirrors [OudsPinCodeInputKeyboardType] for the demo customization layer.
enum PinCodeKeyboardTypeEnum {
  numeric,
  alphanumeric;

  const PinCodeKeyboardTypeEnum();

  static String enumName(BuildContext context) {
    return context.l10n.app_components_pinCodeInput_keyboardType_label;
  }
}

extension PinCodeKeyboardTypeLabel on PinCodeKeyboardTypeEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case PinCodeKeyboardTypeEnum.numeric:
        return context.l10n.app_components_pinCodeInput_keyboardType_numeric_label;
      case PinCodeKeyboardTypeEnum.alphanumeric:
        return context.l10n.app_components_pinCodeInput_keyboardType_alphanumeric_label;
    }
  }
}

