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
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

/// Utility class to map button customization options to corresponding OudsButton attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsButton] properties. It includes methods for determining the button appearance,
/// style, and layout based on the input enum values. These methods help in translating
/// user-selected options into code that is used for button customization and rendering.

class ButtonCustomizationUtils {
  /// Maps the appearance enum to `OudsButtonAppearance`.
  static OudsButtonAppearance getAppearance(Object appearance) {
    switch (appearance) {
      case ButtonEnumAppearance.minimal:
        return OudsButtonAppearance.minimal;
      case ButtonEnumAppearance.negative:
        return OudsButtonAppearance.negative;
      case ButtonEnumAppearance.strong:
        return OudsButtonAppearance.strong;
      case ButtonEnumAppearance.brand:
        return OudsButtonAppearance.brand;
      default:
        return OudsButtonAppearance.defaultAppearance;
    }
  }

  /// Displays the loader if it is selected .
  static Loader? getLoader(ButtonCustomizationState? customizationState) {
    if (customizationState?.hasLoader == true) {
      return Loader(progress: null);
    }
    return null;
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
  static String? getIcon(ButtonCustomizationState? customizationState, ThemeController themeController) {
    if (customizationState?.selectedLayout == ButtonEnumLayout.iconOnly || customizationState?.selectedLayout == ButtonEnumLayout.iconAndText) {
      return AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController);
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
