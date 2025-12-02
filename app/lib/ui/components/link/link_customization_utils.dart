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

import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_customization.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

/// Utility class to map tag customization options to corresponding OudsLink attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsLink] properties. It includes methods for determining the link layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for link customization and rendering.

class LinkCustomizationUtils {
  /// Maps the layout enum to `OudsLinkLayout`.
  static OudsLinkLayout getLayout(Object layout) {
    switch (layout) {
      case LinkEnumLayout.textAndIcon:
        return OudsLinkLayout.textAndIcon;
      case LinkEnumLayout.next:
        return OudsLinkLayout.next;
      case LinkEnumLayout.back:
        return OudsLinkLayout.back;
      default:
        return OudsLinkLayout.textOnly;
    }
  }

  /// Determines the text to display.
  static String getText(LinkCustomizationState customizationState) {
    return customizationState.labelText;
  }

  /// Determines the icon to display based on the selected layout.
  static String? getIcon(LinkCustomizationState? customizationState, ThemeController themeController) {
    if (customizationState?.selectedLayout == LinkEnumLayout.textAndIcon) {
      return AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController);
    }
    return null;
  }

  /// Maps the enum to `OudsLinkSize`.
  static OudsLinkSize getSize(Object size) {
    switch (size) {
      case LinkEnumSize.small:
        return OudsLinkSize.small;
      default:
        return OudsLinkSize.defaultSize;
    }
  }
}
