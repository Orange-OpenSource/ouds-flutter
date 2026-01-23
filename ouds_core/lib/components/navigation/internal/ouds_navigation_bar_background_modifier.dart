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

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/utilities/theme_utils.dart';

class OudsNavigationBarBackgroundColorModifier {
  final BuildContext context;

  OudsNavigationBarBackgroundColorModifier(this.context);

  /// Returns the background color of the navigation bar depending on translucency and theme.
  Color getBackgroundColor(bool isTranslucent) {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    final isDark = ThemeUtils.isDarkTheme(context);
    if (isTranslucent) {
      return isDark ? barTheme.colorBgTranslucentDark.withValues(alpha: 0.5) : barTheme.colorBgTranslucentLight.withValues(alpha: 0.5);
    } else {
      return barTheme.colorBgOpaque.withValues(alpha: 0.5);
    }
  }
}
