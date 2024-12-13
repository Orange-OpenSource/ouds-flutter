/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:ouds_flutter/core/ouds_theme.dart';

class ThemeController extends ChangeNotifier {
  bool _isOrangeTheme = true;

  bool get isOrangeTheme => _isOrangeTheme;

  void setTheme(bool isOrange) {
    _isOrangeTheme = isOrange;
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isOrangeTheme
        ? OudsTheme.orangeThemeLight
        : OudsTheme.inverseThemeLight;
  }

  ThemeData get currentDarkTheme {
    return _isOrangeTheme
        ? OudsTheme.orangeThemeDark
        : OudsTheme.inverseThemeDark;
  }
}
