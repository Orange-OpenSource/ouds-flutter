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
import 'package:ouds_theme_orange_compact/orange_compact_theme.dart';
import 'package:ouds_theme_sosh/ouds_theme_sosh.dart';
import 'package:ouds_theme_wireframe/ouds_theme_wireframe.dart';

class ThemeController extends ChangeNotifier with WidgetsBindingObserver {
  String? fontFamily;

  ThemeMode _themeMode = ThemeMode.system;
  late OudsThemeContract _currentTheme = OrangeTheme(fontFamily);
  bool _onColoredSurface = false;
  bool _onBorderRadiusButtonState = false;
  bool _onBorderRadiusTextInputState = false;
  bool _onBorderRadiusAlertMessageState = false;

  /// Getter to access the current theme
  OudsThemeContract get currentTheme => _currentTheme;

  /// Getter to access the current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Getter to know if we are on a colored surface
  bool get onColoredSurface => _onColoredSurface;

  /// Getter to know if we are on a border state
  bool get onBorderRadiusButtonState => _onBorderRadiusButtonState;
  bool get onBorderRadiusTextInputState => _onBorderRadiusTextInputState;
  bool get onBorderRadiusAlertMessageState => _onBorderRadiusAlertMessageState;

  ThemeController(this.fontFamily) {
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
    final systemBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    /// Set the theme mode to dark or light based on the platform's brightness
    setThemeMode(
      systemBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  /// Changes the current theme to the provided theme
  void setTheme(OudsThemeContract newTheme) {
    _currentTheme = newTheme;

    /// Notify listeners of the theme change
    notifyListeners();
  }

  /// Updates the font family and recreates the current theme with the new font.
  void updateFontFamily(String? newFontFamily) {
    if (fontFamily != newFontFamily) {
      fontFamily = newFontFamily;
      // Recreate the current theme with the new font family
      _currentTheme = _getThemeForCurrentType(_currentTheme.runtimeType);
      notifyListeners();
    }
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

  /// Changes the border state

  void setOnBorderRadiusButtonState(bool? value) {
    bool newValue = value ?? false;
    if (_onBorderRadiusButtonState != newValue) {
      _onBorderRadiusButtonState = newValue;
      notifyListeners();
    }
  }

  void setOnBorderRadiusTextInputState(bool? value) {
    bool newValue = value ?? false;
    if (_onBorderRadiusTextInputState != newValue) {
      _onBorderRadiusTextInputState = newValue;
      notifyListeners();
    }
  }

  void setOnBorderRadiusAlertMessageState(bool? value) {
    bool newValue = value ?? false;
    if (_onBorderRadiusAlertMessageState != newValue) {
      _onBorderRadiusAlertMessageState = newValue;
      notifyListeners();
    }
  }

  /// Returns the ThemeData based on the current theme mode (light or dark)
  ThemeData get themeData {
    return isDarkTheme ? _currentTheme.darkThemeData : _currentTheme.themeData;
  }

  bool get isDarkTheme {
    if (themeMode == ThemeMode.system) {
      final Brightness brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  bool get isInverseDarkTheme {
    if (themeMode == ThemeMode.system) {
      final Brightness brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.light;
    } else {
      return themeMode == ThemeMode.light;
    }
  }

  /// Returns the appropriate theme instance based on the current theme type
  OudsThemeContract _getThemeForCurrentType(Type currentType) {
    if (currentType == OrangeTheme) {
      return OrangeTheme(fontFamily);
    } else if (currentType == OrangeCompactTheme) {
      return OrangeCompactTheme(fontFamily);
    } else if (currentType == SoshTheme) {
      return SoshTheme();
    } else if (currentType == WireframeTheme) {
      return WireframeTheme();
    } else {
      return OrangeTheme(fontFamily); // Default to OrangeTheme
    }
  }

  /// Returns the correct asset path based on the current active theme.
  ///
  /// This function retrieves the name of the current theme from the
  /// [ThemeController], converts it to lowercase, and builds the asset path
  /// accordingly. For example:
  /// - If the theme name is "Orange" → returns "assets/orange/"
  /// - If the theme name is "Orange Compact" → returns "assets/orange_compact/"
  /// - If the theme name is "Sosh" → returns "assets/sosh/"
  /// - If the theme name is "WireFrame" → returns "assets/wireframe/"
  ///
  /// This ensures that the correct folder of assets is used for the
  /// corresponding theme.
  String getAssetsPath(ThemeController themeController) {
    // Get the current theme name
    // replace white space by _
    // convert it to lowercase
    final themeName = themeController.currentTheme.name
        .replaceAll(' ', '_')
        .toLowerCase();
    // Build and return the corresponding asset path
    return 'assets/$themeName/';
  }
}
