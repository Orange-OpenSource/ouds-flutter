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

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Capitalizes the first letter of the enum value's name.
///
/// This function takes an enum value, converts it to a string, and splits
/// the string to extract the name. It then capitalizes the first letter
/// of the name and returns the modified string.
///
/// Example:
/// If the input is `ButtonsEnumHierarchy.strong`, the function will return "Strong"
String capitalizeEnumValue(Enum enumValue) {
  String enumName = enumValue.toString().split('.').last; // Extracts the enum name
  // Check if the enum name contains "default"
  if (enumName.contains('default')) {
    return 'Default';
  }
  return enumName[0].toUpperCase() + enumName.substring(1); // Capitalizes the first letter
}

/// Represents the hierarchy of an OUDS button.
enum ButtonEnumHierarchy {
  defaultHierarchy,
  strong,
  minimal,
  negative;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_button_hierarchy_label;
  }
}

extension CustomElementHierarchy on ButtonEnumHierarchy {
  String stringValue(BuildContext context) {
    switch (this) {
      case ButtonEnumHierarchy.defaultHierarchy:
        return capitalizeEnumValue(ButtonEnumHierarchy.defaultHierarchy);
      case ButtonEnumHierarchy.strong:
        return capitalizeEnumValue(ButtonEnumHierarchy.strong);
      case ButtonEnumHierarchy.minimal:
        return capitalizeEnumValue(ButtonEnumHierarchy.minimal);
      case ButtonEnumHierarchy.negative:
        return capitalizeEnumValue(ButtonEnumHierarchy.negative);
    }
  }
}

/// Represents the style of an OUDS button.
enum ButtonEnumStyle {
  defaultStyle,
  loading;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_style_label;
  }
}

extension CustomElementStyle on ButtonEnumStyle {
  String stringValue(BuildContext context) {
    switch (this) {
      case ButtonEnumStyle.defaultStyle:
        return capitalizeEnumValue(ButtonEnumStyle.defaultStyle);
      case ButtonEnumStyle.loading:
        return capitalizeEnumValue(ButtonEnumStyle.loading);
    }
  }
}

/// Represents the layout of an OUDS button.
enum ButtonEnumLayout {
  textOnly,
  iconAndText,
  iconOnly;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_layout_label;
  }
}

extension CustomElementLayout on ButtonEnumLayout {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case ButtonEnumLayout.textOnly:
        return l10n.app_components_common_textOnlyLayout_label;
      case ButtonEnumLayout.iconAndText:
        return l10n.app_components_common_iconAndTextLayout_label;
      case ButtonEnumLayout.iconOnly:
        return l10n.app_components_button_iconOnlyLayout_label;
    }
  }
}
