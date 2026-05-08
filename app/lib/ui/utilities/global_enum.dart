/// Capitalizes the first letter of the enum value's name.
///
/// This function takes an enum value, converts it to a string, and splits
/// the string to extract the name. It then capitalizes the first letter
/// of the name and returns the modified string.
///
/// Examples:
/// If the input is `LinkEnumSize.defaultSize`, the function will return "default"
/// If the input is `ButtonsEnumHierarchy.strong`, the function will return "Strong"
/// If the input is `TagEnumHierarchy.muted`, the function will return "Muted"
/// If the input is `MyEnum.endBottom`, the function will return "End Bottom"
///
String capitalizeEnumValue(Enum enumValue) {
  String enumName = enumValue
      .toString()
      .split('.')
      .last; // Extracts the enum name

  // Check if the enum name contains "default"
  if (enumName.contains('default')) {
    return 'Default';
  }

  // Insert a space before any uppercase letter that is not the first character
  // and then capitalize the first letter of each word.
  String result = enumName.replaceAllMapped(
    RegExp(r'(?<=[a-z])(?=[A-Z])'),
    (match) => ' ',
  );
  return result[0].toUpperCase() + result.substring(1);
}
