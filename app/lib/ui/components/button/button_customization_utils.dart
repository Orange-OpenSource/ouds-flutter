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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_enum.dart';

/// Utility class to map button customization options to corresponding OudsButton attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsButton] properties. It includes methods for determining the button hierarchy,
/// style, and layout based on the input enum values. These methods help in translating
/// user-selected options into code that is used for button customization and rendering.

class ButtonCustomizationUtils {
  /// Maps the hierarchy enum to `OudsButtonHierarchy`.
  static OudsButtonHierarchy getHierarchy(Object hierarchy) {
    switch (hierarchy) {
      case ButtonEnumHierarchy.minimal:
        return OudsButtonHierarchy.minimal;
      case ButtonEnumHierarchy.negative:
        return OudsButtonHierarchy.negative;
      case ButtonEnumHierarchy.strong:
        return OudsButtonHierarchy.strong;
      default:
        return OudsButtonHierarchy.defaultHierarchy;
    }
  }

  /// Maps the style enum to `OudsButtonStyle`.
  static OudsButtonStyle getStyle(Object style) {
    switch (style) {
      case ButtonEnumStyle.loading:
        return OudsButtonStyle.loading;
      default:
        return OudsButtonStyle.defaultStyle;
    }
  }

  /// Maps the layout enum to `OudsButtonLayout`.
  static OudsButtonLayout getLayout(Object layout) {
    switch (layout) {
      case ButtonEnumLayout.iconOnly:
        return OudsButtonLayout.iconOnly;
      case ButtonEnumLayout.textOnly:
        return OudsButtonLayout.textOnly;
      case ButtonEnumLayout.iconAndText:
        return OudsButtonLayout.iconAndText;
      default:
        return OudsButtonLayout.textOnly;
    }
  }

  /// Determines the icon to display based on the selected layout.
  static Widget? getIcon(ButtonCustomizationState? customizationState) {
    if (customizationState?.selectedLayout == ButtonEnumLayout.iconOnly || customizationState?.selectedLayout == ButtonEnumLayout.iconAndText) {
      return const Icon(Icons.favorite_border);
    }
    return null;
  }

  /// Determines the text to display based on the selected layout.
  static String? getText(ButtonCustomizationState? customizationState) {
    if (customizationState?.selectedLayout == ButtonEnumLayout.textOnly || customizationState?.selectedLayout == ButtonEnumLayout.iconAndText) {
      return customizationState?.textValue;
    }
    return null;
  }
}
