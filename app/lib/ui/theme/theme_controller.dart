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
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange_country/orange_country_theme.dart';
import 'package:ouds_theme_white_label/white_label_theme.dart';

class ThemeController extends ChangeNotifier with WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.system;
  OudsThemeContract _currentTheme = OrangeTheme();
  bool _onColoredSurface = false;

  /// Getter to access the current theme
  OudsThemeContract get currentTheme => _currentTheme;

  /// Getter to access the current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Getter to know if we are on a colored surface
  bool get onColoredSurface => _onColoredSurface;

  ThemeController() {
    /// Initialize the theme based on the system's current brightness setting
    _updateThemeForSystemMode();

    /// Add this controller as an observer to listen for platform brightness changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    /// Remove this controller as an observer when it's disposed to prevent memory leaks
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    /// Called when the platform's brightness changes (system light/dark mode)
    super.didChangePlatformBrightness();

    /// Update the theme based on the new platform brightness
    _updateThemeForSystemMode();
  }

  /// Updates the theme mode based on the platform's brightness setting (light/dark)
  void _updateThemeForSystemMode() {
    final systemBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;

    /// Set the theme mode to dark or light based on the platform's brightness
    setThemeMode(systemBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);
  }

  /// Changes the current theme to the provided theme
  void setTheme(OudsThemeContract newTheme) {
    _currentTheme = newTheme;

    /// Notify listeners of the theme change
    notifyListeners();
  }

  /// Changes the theme mode (light or dark) and updates the current theme accordingly
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;

      /// Update the theme based on the new mode
      _currentTheme = _getThemeForCurrentType(_currentTheme.runtimeType);
      notifyListeners();
    }
  }

  void setOnColoredSurface(bool? value) {
    bool newValue = value ?? false;
    if (_onColoredSurface != newValue) {
      _onColoredSurface = newValue;
      notifyListeners();
    }
  }

  /// Returns the ThemeData based on the current theme mode (light or dark)
  ThemeData get themeData {
    return isDarkTheme ? _currentTheme.darkThemeData : _currentTheme.themeData;
  }

  bool get isDarkTheme {
    if (themeMode == ThemeMode.system) {
      final Brightness brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  /// Returns the appropriate theme instance based on the current theme type
  OudsThemeContract _getThemeForCurrentType(Type currentType) {
    if (currentType == OrangeTheme) {
      return OrangeTheme();
    } else if (currentType == OrangeCountryCustomTheme) {
      return OrangeCountryCustomTheme();
    } else if (currentType == WhiteLabelTheme) {
      return WhiteLabelTheme();
    } else {
      return OrangeTheme(); // Default to OrangeTheme
    }
  }
}
