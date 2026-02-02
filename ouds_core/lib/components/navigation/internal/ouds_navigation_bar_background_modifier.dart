/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/utilities/theme_utils.dart';

class OudsNavigationBarBackgroundColorModifier {
  final BuildContext context;

  OudsNavigationBarBackgroundColorModifier(this.context);

  /// Returns the navigation bar background color based on translucency and the current theme (light/dark).
  Color getBackgroundColor(bool isTranslucent) {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    final isDark = ThemeUtils.isDarkTheme(context);
    if (isTranslucent) {
      return isDark ? barTheme.colorBgTranslucentDark : barTheme.colorBgTranslucentLight;
    } else {
      return barTheme.colorBgOpaque;
    }
  }
}
