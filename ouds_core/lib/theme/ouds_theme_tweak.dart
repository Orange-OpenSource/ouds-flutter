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
/// {@category Theme}
library;

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Defines adjustments that can be applied to the current [OudsTheme] via the [OudsThemeTweak] widget.
///
/// These tweaks allow you to temporarily override the theme mode for specific parts of your UI
/// without affecting the global theme configuration.
enum OudsThemeTweakType {
  /// Inverts the current theme (Light ↔ Dark).
  ///
  /// If the app is currently in light mode, it switches to dark mode for the subtree.
  /// If in dark mode, it switches to light mode.
  invert,

  /// Forces Dark mode regardless of system settings or parent theme mode.
  ///
  /// Useful for components that must always appear in dark mode
  /// (e.g., video players, code editors).
  forceDark,

  /// Forces Light mode regardless of system settings or parent theme mode.
  ///
  /// Useful for components that must always appear in light mode
  /// (e.g., certain branded sections).
  forceLight,
}

/// Internal InheritedWidget to propagate theme tweak down the tree.
///
/// This widget stores the effective theme mode after applying a tweak,
/// allowing nested widgets to query the current effective theme via
/// [OudsTheme.isOudsInDarkTheme] or by directly accessing this scope.
class _OudsThemeTweakScope extends InheritedWidget {
  final OudsThemeTweakType tweak;
  final ThemeMode effectiveThemeMode;

  const _OudsThemeTweakScope({
    required this.tweak,
    required this.effectiveThemeMode,
    required super.child,
  });
/*
  /// Retrieves the current theme tweak scope from the widget tree.
  ///
  /// Returns `null` if no [OudsThemeTweak] is present in the ancestor tree.
  static _OudsThemeTweakScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_OudsThemeTweakScope>();
  }

  /// Retrieves the current theme tweak scope from the widget tree.
  ///
  /// Throws an error if no [OudsThemeTweak] is present in the ancestor tree.
  static _OudsThemeTweakScope of(BuildContext context) {
    final scope = maybeOf(context);
    assert(scope != null, 'No OudsThemeTweakScope found in context. Wrap your widget with OudsThemeTweak.');
    return scope!;
  }*/

  @override
  bool updateShouldNotify(_OudsThemeTweakScope oldWidget) {
    return oldWidget.tweak != tweak || oldWidget.effectiveThemeMode != effectiveThemeMode;
  }
}

/// Modifies the current OUDS theme configuration and applies it to the given [child].
///
/// This widget allows you to temporarily override the theme mode for a specific subtree
/// without affecting the rest of your application. It's useful for:
/// - **Preview/demo screens** showing both light and dark themes side-by-side
/// - **Specific UI sections** that need forced light/dark mode (e.g., video player always dark)
/// - **Theme switching animations** or transitions
/// - **Component showcases** in design systems
///
/// **Important Notes:**
/// - This widget **must** be nested within an [OudsTheme] widget
/// - Multiple [OudsThemeTweak] widgets can be nested (inner tweak takes precedence)
/// - The tweak only affects the visual appearance; logical theme queries via [OudsTheme.modeOf]
///   will reflect the tweaked mode within the subtree
/// - Use [OudsTheme.isOudsInDarkTheme] to check the effective theme mode (respects tweaks)
///
/// ### Parameters:
/// - [tweak]: The specific adjustment to apply: ( [OudsThemeTweakType.invert], [OudsThemeTweakType.forceDark], or [OudsThemeTweakType.forceLight])
///
/// - [child]: The widget subtree to which the tweaked theme will be applied. This widget receives a context with the tweaked theme.
///
/// ### Example usage:
///
/// **Accessing the tweaked theme:**
/// ```dart
/// OudsThemeTweak(
///   tweak: OudsThemeTweakType.invert,
///   child: MyComponentPreview(),
///   ),
/// )
/// ```
///
/// **Force Light theme preview:**
/// ```dart
/// OudsThemeTweak(
///   tweak: OudsThemeTweakType.forceLight,
///   child: MyComponentPreview(),
/// ),
/// ```
///
/// **Force Dark theme preview:**
/// ```dart
/// OudsThemeTweak(
///   tweak: OudsThemeTweakType.forceDark,
///   child: MyComponentPreview(),
/// ),
/// ```
class OudsThemeTweak extends StatelessWidget {
  final OudsThemeTweakType tweak;
  final Widget child;

  const OudsThemeTweak({
    super.key,
    required this.tweak,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Get current theme mode (may already be tweaked by a parent OudsThemeTweak)
    final currentThemeMode = OudsTheme.modeOf(context) ?? ThemeMode.system;
    final systemBrightness = MediaQuery.platformBrightnessOf(context);

    // Resolve current effective dark mode state
    final bool isCurrentlyDark;
    if (currentThemeMode == ThemeMode.system) {
      isCurrentlyDark = systemBrightness == Brightness.dark;
    } else {
      isCurrentlyDark = currentThemeMode == ThemeMode.dark;
    }

    // Calculate effective theme mode based on tweak type
    final ThemeMode effectiveThemeMode = switch (tweak) {
      OudsThemeTweakType.invert => isCurrentlyDark ? ThemeMode.light : ThemeMode.dark,
      OudsThemeTweakType.forceDark => ThemeMode.dark,
      OudsThemeTweakType.forceLight => ThemeMode.light,
    };

    // Get appropriate ThemeData and theme contract
    final parentOudsTheme = OudsTheme.of(context);
    final themeData = effectiveThemeMode == ThemeMode.dark ? parentOudsTheme.darkThemeData : parentOudsTheme.themeData;

    return _OudsThemeTweakScope(
      tweak: tweak,
      effectiveThemeMode: effectiveThemeMode,
      child: OudsTheme(
        themeContract: parentOudsTheme,
        themeMode: effectiveThemeMode,
        onColoredSurface: OudsTheme.isOnColoredSurfaceOf(context),
        child: Theme(
          data: themeData,
          child: Builder(
            builder: (BuildContext newContext) {
              // The child now receives a context where OudsTheme.of(newContext)
              // will return the tweaked theme, not the parent theme
              return child;
            },
          ),
        ),
      ),
    );
  }
}
