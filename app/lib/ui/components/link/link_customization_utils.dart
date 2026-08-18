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

import 'package:flutter/foundation.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_customization.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

/// Utility class to map tag customization options to corresponding OudsLink attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsLink] properties. It includes methods for building the dedicated [OudsLink]
/// constructor matching the selected layout. These methods help in translating
/// user-selected options into code that is used for link customization and rendering.

class LinkCustomizationUtils {
  /// Builds the [OudsLink] widget matching the selected layout, using the
  /// dedicated constructor for each variant (icon, previous, next, external).
  static OudsLink buildLink({
    required LinkCustomizationState customizationState,
    required ThemeController themeController,
    required VoidCallback? onPressed,
  }) {
    final label = getText(customizationState);
    final size = getSize(customizationState.selectedSize);
    final density = getDensity(customizationState.selectedDensity);

    switch (customizationState.selectedLayout) {
      case LinkEnumLayout.textAndIcon:
        return OudsLink.icon(
          label: label,
          icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty(
            themeController,
          ),
          size: size,
          density: density,
          onPressed: onPressed,
        );
      case LinkEnumLayout.next:
        return OudsLink.next(
          label: label,
          size: size,
          density: density,
          onPressed: onPressed,
        );
      case LinkEnumLayout.previous:
        return OudsLink.previous(
          label: label,
          size: size,
          density: density,
          onPressed: onPressed,
        );
      case LinkEnumLayout.external:
        return OudsLink.external(
          label: label,
          size: size,
          density: density,
          onPressed: onPressed,
        );
      case LinkEnumLayout.textOnly:
        return OudsLink(
          label: label,
          size: size,
          density: density,
          onPressed: onPressed,
        );
    }
  }

  /// Determines the text to display.
  static String getText(LinkCustomizationState customizationState) {
    return customizationState.labelText;
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

  /// Maps the enum to `OudsLinkDensity`.
  static OudsLinkDensity getDensity(Object density) {
    switch (density) {
      case LinkEnumDensity.compact:
        return OudsLinkDensity.compact;
      default:
        return OudsLinkDensity.defaultDensity;
    }
  }
}
