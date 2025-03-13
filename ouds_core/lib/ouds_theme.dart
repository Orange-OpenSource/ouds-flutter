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

/// [OudsTheme] is an InheritedWidget that provides a way to share the Ouds theme configuration
/// (colors, typography, etc.) and the current theme mode (light or dark) across the widget tree.
/// It replaces the default MaterialTheme in Flutter. Use it at the root of your application to
/// apply the theme to your entire app or specific parts of the widget tree.

class OudsTheme extends InheritedWidget {
  final OudsThemeContract themeContract;
  final ThemeMode themeMode;
  final bool onColoredSurface;

  static late OudsTheme _instance;

  /// Constructor to initialize the OudsTheme with a theme configuration and theme mode.
  /// @param themeContract The theme configuration containing colors, typography, etc.
  /// @param themeMode The current theme mode (light or dark).
  /// @param onColoredSurface Whether the theme is applied on a colored surface.
  /// @param child The widget tree that will be wrapped by this theme.

  OudsTheme({
    super.key,
    required this.themeContract,
    required this.themeMode,
    required this.onColoredSurface,
    required super.child,
  }) {
    _instance = this;
  }

  static ThemeMode get themeModeGlobal => _instance.themeMode;
  static bool get onColoredSurfaceGlobal => _instance.onColoredSurface;

  /// Retrieves the OudsThemeContract from the widget tree.
  /// This allows access to the theme configuration (colors, typography, etc.).
  /// @param context The BuildContext from which to retrieve the theme.
  /// @returns The OudsThemeContract associated with the current context.

  static OudsThemeContract of(BuildContext context) {
    final OudsTheme? result = context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    assert(result != null, 'No OudsTheme found in context!');
    return result!.themeContract;
  }

  /// Retrieves the current theme mode (light or dark) from the widget tree.
  /// @param context The BuildContext to retrieve the theme mode from.
  /// @returns The ThemeMode (light or dark) associated with the current context.

  static ThemeMode modeOf(BuildContext context) {
    final OudsTheme? result = context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    assert(result != null, 'No ThemeMode found in context!');
    return result!.themeMode;
  }

  /// Retrieves the current `onColoredSurface` value from the widget tree.
  /// @param context The BuildContext to retrieve the surface mode from.
  /// @returns A boolean indicating whether the theme is applied on a colored surface.

  static bool? isOnColoredSurfaceOf(BuildContext context) {
    final OudsTheme? result = context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    assert(result != null, 'No OnColoredSurfaceOf found in context!');
    return result!.onColoredSurface;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is OudsTheme &&
        (oldWidget.themeMode != themeMode || oldWidget.themeContract != themeContract || oldWidget.onColoredSurface != onColoredSurface);
  }
}
