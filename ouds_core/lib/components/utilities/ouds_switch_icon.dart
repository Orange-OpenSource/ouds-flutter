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

/// Class that encapsulates the logic for generating the thumb icon for the Switch.
class OudsSwitchIcon {
  final BuildContext context;

  /// Constructor that takes a BuildContext.
  OudsSwitchIcon(this.context);

  /// Getter for the thumbIcon property.
  WidgetStateProperty<Icon?>? get thumbIcon {
    /// Determine if the current theme is light or dark.
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
      /// If the Switch is both disabled and selected.
      if (states.contains(WidgetState.disabled) &&
          states.contains(WidgetState.selected)) {
        return Icon(Icons.check,
            color: isLightTheme ? Colors.grey[400] : Colors.black87);
      }

      /// If the Switch is selected.
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check, color: Colors.black);
      }

      /// If the Switch is disabled.
      if (states.contains(WidgetState.disabled)) {
        return Icon(Icons.close,
            color: isLightTheme ? Colors.grey[200] : Colors.grey[600]);
      }

      /// Default case: Return a close icon with a fixed white color.
      return const Icon(Icons.close, color: Colors.white);
    });
  }
}
