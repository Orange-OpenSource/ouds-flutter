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
import 'package:ouds_theme_contract/ouds_theme_contract.dart';

/// A widget that applies a specific theme to its child using [OudsTheme].
///
/// This widget allows setting a theme mode (`ThemeMode`) and a theme contract
/// (`OudsThemeContract`). It wraps its child inside a background colored by a [ColoredBox].
class ThemeBox extends StatelessWidget {
  /// The widget to display inside the [ThemeBox].
  final Widget child;

  /// The theme mode to apply (light, dark, or system).
  final ThemeMode themeMode;

  /// The theme contract defining the theme's design tokens and styles.
  final OudsThemeContract themeContract;

  /// Constructor for [ThemeBox].
  ///
  /// Requires [child], [themeMode], and [themeContract].
  const ThemeBox({
    required this.child,
    required this.themeMode,
    required this.themeContract,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OudsTheme(
      themeContract: themeContract,
      themeMode: themeMode,
      onColoredSurface: false,
      child: Builder(
        builder: (context) {
          return ColoredBox(
            color: ColoredBoxColor.backgroundPrimary,
            child: Column(
              children: [
                child,
              ],
            ),
          );
        },
      ),
    );
  }
}

/// A demo colored box widget used to showcase `DARK` and `LIGHT` modes.
/// It displays a background with centered content and a minimum height.
class ColoredBox extends StatelessWidget {
  /// The widget to display at the center of the box.
  final Widget child;

  /// The background color of the box, optional.
  final ColoredBoxColor? color;

  /// Constructor for [ColoredBox].
  ///
  /// Requires [child], [color] is optional.
  const ColoredBox({
    required this.child,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 80,
      ),
      width: double.infinity,
      color: color?.getValue(context),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          vertical: OudsTheme.of(context).spaceScheme(context).fixedMedium,
          horizontal: OudsTheme.of(context).spaceScheme(context).fixedNone,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

/// Enumeration representing the possible background colors of a [ColoredBox].
enum ColoredBoxColor {
  /// Primary background color.
  backgroundPrimary;

  /// Retrieves the color value associated with this enum in the current context.
  Color getValue(BuildContext context) {
    final theme = OudsTheme.of(context);

    switch (this) {
      case ColoredBoxColor.backgroundPrimary:
        return theme.colorScheme(context).bgPrimary;
    }
  }
}
