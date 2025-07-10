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

import 'package:ouds_core/components/chip/ouds_suggestion_chip.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_enum.dart';

/// Utility class to map chip customization options to corresponding OudsChip attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsSugesstionChip] properties. It includes methods for determining the chip layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for chip customization and rendering.

class ChipCustomizationUtils {

  /// Maps the layout enum to `OudsChipLayout`.
  static OudsChipLayout getLayout(Object layout) {
    switch (layout) {
      case ChipEnumLayout.iconOnly:
        return OudsChipLayout.iconOnly;
      case ChipEnumLayout.textOnly:
        return OudsChipLayout.textOnly;
      case ChipEnumLayout.iconAndText:
        return OudsChipLayout.iconAndText;
      default:
        return OudsChipLayout.textOnly;
    }
  }

  /// Determines the icon to display based on the selected layout.
  static String? getIcon(ChipCustomizationState? customizationState) {
    if (customizationState?.selectedLayout == ChipEnumLayout.iconOnly || customizationState?.selectedLayout == ChipEnumLayout.iconAndText) {
      return AppAssets.icons.icChipHeart;
    }
    return null;
  }

  /// Determines the text to display based on the selected layout.
  static String? getText(ChipCustomizationState? customizationState) {
    if (customizationState?.selectedLayout == ChipEnumLayout.textOnly || customizationState?.selectedLayout == ChipEnumLayout.iconAndText) {
      return customizationState?.labelText;
    }
    return null;
  }
}
