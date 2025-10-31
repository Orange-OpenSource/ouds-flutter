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
///
String capitalizeEnumValue(Enum enumValue) {
  String enumName = enumValue.toString().split('.').last; // Extracts the enum name
  // Check if the enum name contains "default"
  if (enumName.contains('default')) {
    return 'Default';
  }
  return enumName[0].toUpperCase() + enumName.substring(1); // Capitalizes the first letter
}
