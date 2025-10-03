import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Represents the style of an OUDS TextInput.
enum FormFieldsEnumStyle {
  defaultStyle,
  alternative;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_style_label;
  }
}

extension CustomElementLayout on FormFieldsEnumStyle {
  String stringValue(BuildContext context) {
    switch (this) {
      case FormFieldsEnumStyle.defaultStyle:
        return "Default";
      case FormFieldsEnumStyle.alternative:
        return "Alternative";
    }
  }
}

/// Enum to choose wich input type to use
enum FormFieldsTypeEnum {
  textInput,
  phoneNumberInput,
  passwordInput;
}

extension CustomLabelLayout on FormFieldsTypeEnum {
  String get labelValue {
    switch (this) {
      case FormFieldsTypeEnum.textInput:
        return "Label";
      case FormFieldsTypeEnum.phoneNumberInput:
        return "Phone number";
      case FormFieldsTypeEnum.passwordInput:
        return "Password";
    }
  }
}

extension CustomHelperLayout on FormFieldsTypeEnum {
  String get helperValue {
    switch (this) {
      case FormFieldsTypeEnum.textInput:
        return "Helper text";
      case FormFieldsTypeEnum.phoneNumberInput:
        return "Include your full number without spaces.";
      case FormFieldsTypeEnum.passwordInput:
        return "Your password must be between 8 and 20 characters long.";
    }
  }
}
