import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Represents the style of an OUDS TextInput.
enum TextInputEnumStyle {
  defaultStyle,
  alternative;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_style_label;
  }
}

extension CustomElementLayout on TextInputEnumStyle {
  String stringValue(BuildContext context) {
    switch (this) {
      case TextInputEnumStyle.defaultStyle:
        return "Default";
      case TextInputEnumStyle.alternative:
        return "Alternative";
    }
  }
}

/// Enum to choose wich input type to use
enum InputTypeEnum {
  textInput,
  phoneNumberInput;
}

extension CustomLabelLayout on InputTypeEnum {
  String get labelValue {
    switch (this) {
      case InputTypeEnum.textInput:
        return "Label";
      case InputTypeEnum.phoneNumberInput:
        return "Phone number";
    }
  }
}

extension CustomHelperLayout on InputTypeEnum {
  String get helperValue {
    switch (this) {
      case InputTypeEnum.textInput:
        return "Helper text";
      case InputTypeEnum.phoneNumberInput:
        return "Include your full number without spaces.";
    }
  }
}
