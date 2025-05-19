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
import 'package:ouds_core/ouds_theme.dart';

class ThemeUtils {
  static bool isDarkTheme(BuildContext context) {
    final mode = OudsTheme.modeOf(context);
    if (mode == ThemeMode.system) {
      final Brightness brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return mode == ThemeMode.dark;
    }
  }
}
