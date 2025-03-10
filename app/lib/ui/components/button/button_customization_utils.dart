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

import 'package:ouds_core/components/button/ouds_button.dart';
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
      case ButtonsEnumHierarchy.Minimal:
        return OudsButtonHierarchy.Minimal;
      case ButtonsEnumHierarchy.Negative:
        return OudsButtonHierarchy.Negative;
      case ButtonsEnumHierarchy.Strong:
        return OudsButtonHierarchy.Strong;
      default:
        return OudsButtonHierarchy.Default;
    }
  }

  /// Maps the style enum to `OudsButtonStyle`.
  static OudsButtonStyle getStyle(Object style) {
    switch (style) {
      case ButtonsEnumStyle.Loading:
        return OudsButtonStyle.Loading;
      default:
        return OudsButtonStyle.Default;
    }
  }

  /// Maps the layout enum to `OudsButtonLayout`.
  static OudsButtonLayout getLayout(Object layout) {
    switch (layout) {
      case ButtonsEnumLayout.IconOnly:
        return OudsButtonLayout.IconOnly;
      case ButtonsEnumLayout.TextOnly:
        return OudsButtonLayout.TextOnly;
      case ButtonsEnumLayout.IconAndText:
        return OudsButtonLayout.IconAndText;
      default:
        return OudsButtonLayout.TextOnly;
    }
  }
}
