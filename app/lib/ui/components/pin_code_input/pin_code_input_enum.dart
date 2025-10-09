
import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';


/// Represents the length of an OUDS PinCodeInput.
enum PinCodeLengthEnum {
  four,
  six,
  eight;

  const PinCodeLengthEnum();

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_length_label;
  }

  static String getHelperText(BuildContext context, PinCodeLengthEnum value){

      switch (value) {
        case PinCodeLengthEnum.four:
          return context.l10n.app_components_pin_code_input_helperText_description_text_4;
        case PinCodeLengthEnum.six:
          return context.l10n.app_components_pin_code_input_helperText_description_text_6;
        case PinCodeLengthEnum.eight:
          return context.l10n.app_components_pin_code_input_helperText_description_text_8;
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

