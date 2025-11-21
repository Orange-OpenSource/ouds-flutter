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
