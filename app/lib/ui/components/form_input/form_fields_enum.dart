/// Enum to choose wich input type to use
enum FormFieldsTypeEnum {
  textInput,
  phoneNumberInput;
}

extension CustomLabelLayout on FormFieldsTypeEnum {
  String get labelValue {
    switch (this) {
      case FormFieldsTypeEnum.textInput:
        return "Label";
      case FormFieldsTypeEnum.phoneNumberInput:
        return "Phone number";
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
    }
  }
}
