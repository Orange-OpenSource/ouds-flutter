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

import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';

/// Utility class to map button customization options to corresponding ControlItem attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [ControlItem] properties. It includes methods for determining the button hierarchy,
/// style, and layout based on the input enum values. These methods help in translating
/// user-selected options into code that is used for button customization and rendering.

class ControlItemCustomizationUtils {
  /// Retrieves the label text to display based on the current customization state.
  static String getLabelText(ControlItemCustomizationState customizationState) {
    return customizationState.labelText;
  }

  /// Retrieves the helper label text to display based on the current customization state.
  static String? getHelperLabelText(ControlItemCustomizationState customizationState) {
    final label = customizationState.helperLabelText;
    return label.isEmpty ? null : label;
  }
}
