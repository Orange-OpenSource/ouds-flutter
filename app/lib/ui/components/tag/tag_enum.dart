import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Capitalizes the first letter of the enum value's name.
///
/// This function takes an enum value, converts it to a string, and splits
/// the string to extract the name. It then capitalizes the first letter
/// of the name and returns the modified string.
///
/// Example:
/// If the input is `TagEnumAppearance.muted`, the function will return "Muted"
String capitalizeEnumValue(Enum enumValue) {
  String enumName = enumValue.toString().split('.').last; // Extracts the enum name
  // Check if the enum name contains "default"
  if (enumName.contains('default')) {
    return 'Default';
  }
  return enumName[0].toUpperCase() + enumName.substring(1); // Capitalizes the first letter
}

/// Represents the layout of an OUDS tag.
enum TagEnumLayout {
  textOnly,
  bulletAndText,
  iconAndText;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_layout_label;
  }
}

extension CustomElementLayout on TagEnumLayout {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case TagEnumLayout.textOnly:
        return l10n.app_components_common_textOnlyLayout_label;
      case TagEnumLayout.iconAndText:
        return l10n.app_components_common_iconAndTextLayout_label;
      case TagEnumLayout.bulletAndText:
        return l10n.app_components_common_textAndBulletLayout_label;
    }
  }
}

/// Represents the appearance of an OUDS Tag.
enum TagEnumAppearance {
  emphasized,
  muted;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_appearance_label;
  }

}
extension CustomElementAppearance on TagEnumAppearance {
  String stringValue(BuildContext context) {

    switch (this) {
      case TagEnumAppearance.emphasized:
        return capitalizeEnumValue(TagEnumAppearance.emphasized);
      case TagEnumAppearance.muted:
        return capitalizeEnumValue(TagEnumAppearance.muted);

    }
  }
}

/// Represents the appearance of an OUDS Tag.
enum TagEnumStatus {
  accent,
  info,
  negative,
  neutral,
  positive,
  warning;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_status_label;
  }
}
extension CustomElementStatus on TagEnumStatus {
  String stringValue(BuildContext context) {

    switch (this) {
      case TagEnumStatus.neutral:
        return capitalizeEnumValue(TagEnumStatus.neutral);
      case TagEnumStatus.negative:
        return capitalizeEnumValue(TagEnumStatus.negative);
      case TagEnumStatus.accent:
        return capitalizeEnumValue(TagEnumStatus.accent);
      case TagEnumStatus.info:
        return capitalizeEnumValue(TagEnumStatus.info);
      case TagEnumStatus.warning:
        return capitalizeEnumValue(TagEnumStatus.warning);
      case TagEnumStatus.positive:
        return capitalizeEnumValue(TagEnumStatus.positive);
    }
  }
}

/// Represents the size of an OUDS Tag.
enum TagEnumSize {
  defaultSize,
  small;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_size_label;
  }

}
extension CustomElementSize on TagEnumSize {
  String stringValue(BuildContext context) {

    switch (this) {
      case TagEnumSize.defaultSize:
        return capitalizeEnumValue(TagEnumSize.defaultSize);
      case TagEnumSize.small:
        return capitalizeEnumValue(TagEnumSize.small);

    }
  }
}
