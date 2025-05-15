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
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_enum.dart';

/// Utility class to map divider customization options to corresponding OudsDivider attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsDivider] properties. It includes methods for determining the divider color,
/// based on the input enum values. These methods help in translating
/// user-selected options into code that is used for button customization and rendering.

class DividerCustomizationUtils {
  /// Maps the color enum to `OudsDividerColor`.
  static OudsDividerColor getOudsDividerColor(DividerEnumColor? color) {
    switch (color) {
      case DividerEnumColor.onBrandPrimary:
        return OudsDividerColor.onBrandPrimary;
      case DividerEnumColor.muted:
        return OudsDividerColor.muted;
      case DividerEnumColor.emphasized:
        return OudsDividerColor.emphasized;
      case DividerEnumColor.brandPrimary:
        return OudsDividerColor.brandPrimary;
      case DividerEnumColor.alwaysBlack:
        return OudsDividerColor.alwaysBlack;
      case DividerEnumColor.alwaysOnBlack:
        return OudsDividerColor.alwaysOnBlack;
      case DividerEnumColor.alwaysWhite:
        return OudsDividerColor.alwaysWhite;
      case DividerEnumColor.alwaysOnWhite:
        return OudsDividerColor.alwaysOnWhite;
      default:
        return OudsDividerColor.defaultColor;
    }
  }
}
