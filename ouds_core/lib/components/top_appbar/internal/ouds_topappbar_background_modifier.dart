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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the theme mode
class OudsTopAppBarBackgroundColorModifier {

  final BuildContext context;

  OudsTopAppBarBackgroundColorModifier(this.context);

  Color? getBackgroundColor(bool backgroundColor) {
    final themeMode = OudsTheme.modeOf(context);
    final isDark = themeMode == ThemeMode.system
        ? WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
        : themeMode == ThemeMode.dark;
    final barToken = OudsTheme.of(context).componentsTokens(context).bar;
    return backgroundColor ? isDark
        ? barToken.colorBgTranslucentDark
        : barToken.colorBgTranslucentLight : Colors.transparent;

  }

}