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
import 'package:ouds_flutter/theme-contract/theme/ouds_theme_contract.dart';
import 'package:ouds_flutter/theme-orange/orange_theme.dart';
import 'package:ouds_flutter/theme-white-label/white_label_theme.dart';

class ThemeController extends ChangeNotifier {
  OudsThemeContract _currentTheme = OrangeTheme(); // Thème par défaut

  OudsThemeContract get currentTheme => _currentTheme;

  void setTheme(OudsThemeContract newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }

  ThemeData get themeData => _currentTheme.themeData;

  // Méthode pour basculer entre deux thèmes (exemple).
  void toggleTheme() {
    if (_currentTheme is OrangeTheme) {
      setTheme(WhiteLabelTheme());
    } else {
      setTheme(OrangeTheme());
    }
  }
}
