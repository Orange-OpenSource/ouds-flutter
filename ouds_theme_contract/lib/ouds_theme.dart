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
import 'package:ouds_theme_contract/ouds_theme_contract.dart';

enum OudsThemeAspect { themeMode, onColoredSurface }

/// [OudsTheme] is an InheritedWidget that provides a way to share the Ouds theme configuration
/// (colors, typography, etc.) and the current theme mode (light or dark) across the widget tree.
/// It replaces the default MaterialTheme in Flutter. Use it at the root of your application to
/// apply the theme to your entire app or specific parts of the widget tree.
class OudsTheme extends InheritedModel<OudsThemeAspect> {
  final OudsThemeContract themeContract;
  final ThemeMode themeMode;
  final bool onColoredSurface;

  static late OudsTheme _instance;

  /// Constructor to initialize the OudsTheme with a theme configuration and theme mode.
  /// [themeContract] The theme configuration containing colors, typography, etc.
  /// [themeMode] The current theme mode (light or dark).
  /// [onColoredSurface] Whether the theme is applied on a colored surface.
  /// [child] The widget tree that will be wrapped by this theme.
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

  /// Retrieves the OudsThemeContract from the widget tree.
  /// This allows access to the theme configuration (colors, typography, etc.).
  /// [context] The BuildContext from which to retrieve the theme.
  /// returns The [OudsThemeContract] associated with the current context.
  static OudsThemeContract of(BuildContext context) {
    final OudsTheme? result = context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    assert(result != null, 'No OudsTheme found in context!');
    return result!.themeContract;
  }

  /// Retrieves the ThemeMode from the widget tree.
  /// This allows access to the current theme mode (light or dark)..
  /// [context] The BuildContext from which to retrieve the theme.
  /// returns The [ThemeMode] associated with the current context.
  static ThemeMode? modeOf(BuildContext context) {
    return InheritedModel.inheritFrom<OudsTheme>(context, aspect: OudsThemeAspect.themeMode)?.themeMode;
  }

  /// Retrieves the bool from the widget tree.
  /// This allows access to the current isOnColoredSurfaceOf
  /// [context] The BuildContext from which to retrieve the theme.
  /// returns The [bool] associated with the current context.
  static bool isOnColoredSurfaceOf(BuildContext context) {
    return InheritedModel.inheritFrom<OudsTheme>(context, aspect: OudsThemeAspect.onColoredSurface)?.onColoredSurface ?? false;
  }

  /// Determines if the OUDS theme is currently in dark mode.
  ///
  /// This function respects overrides applied by [OudsThemeTweak] (from `ouds_core` package).
  ///
  /// The OUDS theme can be inverted or forced to light/dark modes using [OudsThemeTweak].
  /// The value returned by this function reflects these effective changes.
  ///
  /// If [OudsThemeTweak] is not used in the layout hierarchy, this function returns
  /// the value based on the `themeMode` parameter of the root `OudsTheme` widget.
  ///
  /// **Note:** To use theme tweaks, you must import `ouds_core` package which provides
  /// the [OudsThemeTweak] widget and [OudsThemeTweakScope].
  ///
  /// Returns `true` if the effective OUDS theme is dark, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// final isDark = OudsTheme.isOudsInDarkTheme(context);
  /// ```
  static bool isOudsInDarkTheme(BuildContext context) {
    // Try to find a theme tweak scope (requires ouds_core package)
    // Using dynamic type to avoid hard dependency on ouds_core
    final tweakScope = context.dependOnInheritedWidgetOfExactType<InheritedWidget>();

    // Check if it's actually an OudsThemeTweakScope (duck typing)
    if (tweakScope != null && tweakScope.runtimeType.toString() == 'OudsThemeTweakScope') {
      try {
        // Access effectiveThemeMode via reflection-like approach
        final effectiveMode = (tweakScope as dynamic).effectiveThemeMode as ThemeMode;
        return effectiveMode == ThemeMode.dark;
      } catch (_) {
        // Fallback if reflection fails
      }
    }

    // No tweak found, use base theme mode
    final themeMode = modeOf(context) ?? ThemeMode.system;
    if (themeMode == ThemeMode.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  @override
  bool updateShouldNotify(covariant InheritedModel<OudsThemeAspect> oldWidget) {
    return oldWidget is OudsTheme && (oldWidget.themeMode != themeMode || oldWidget.themeContract != themeContract || oldWidget.onColoredSurface != onColoredSurface);
  }

  @override
  bool updateShouldNotifyDependent(
    InheritedModel<OudsThemeAspect> oldWidget,
    Set<OudsThemeAspect> dependencies,
  ) {
    if (oldWidget is OudsTheme) {
      if (themeMode != oldWidget.themeMode && dependencies.contains(OudsThemeAspect.themeMode)) {
        return true;
      }
      if (onColoredSurface != oldWidget.onColoredSurface && dependencies.contains(OudsThemeAspect.onColoredSurface)) {
        return true;
      }
    }
    return false;
  }
}