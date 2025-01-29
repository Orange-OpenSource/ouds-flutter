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
import 'package:theme_contract/theme/ouds_theme_contract.dart';
import 'package:theme_orange/orange_theme.dart';

class ThemeController extends ChangeNotifier {
  OudsThemeContract _currentTheme = OrangeTheme();
  ThemeMode _themeMode = ThemeMode.system;

  OudsThemeContract get currentTheme => _currentTheme;
  ThemeMode get themeMode => _themeMode;

  void setTheme(OudsThemeContract newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  ThemeData get themeData {
    if (_themeMode == ThemeMode.dark) {
      return _currentTheme.darkThemeData;
    } else {
      return _currentTheme.themeData;
    }
  }

  ThemeData getThemeForMode(Brightness brightness) {
    return brightness == Brightness.dark
        ? _currentTheme.darkThemeData
        : _currentTheme.themeData;
  }
}
