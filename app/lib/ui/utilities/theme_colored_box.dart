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
import 'package:ouds_core/components/ouds_colored_box.dart';
import 'package:ouds_core/theme/ouds_theme_tweak.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A demo container widget used to showcase components in the application.
///
/// This widget provides a flexible container that can display components either
/// with a colored background using [OudsColoredBox] or with a standard background
/// using [ColoredBox]. It's designed for demonstrating UI components in different
/// visual contexts.
///
/// When [colored] is `true`, the widget uses [OudsColoredBox] with the brand primary
/// color to create a distinctive visual presentation. When [colored] is `false`, it
/// uses [ColoredBox] with a primary background color and applies horizontal padding
/// based on the current theme's grid scheme margin.
///
/// Example:
/// ```dart
/// // Colored demo box with brand primary background
/// ComponentDemoBox(
///   colored: true,
///   child: Text('Demo Component'),
/// )
///
/// // Standard demo box with padding
/// ComponentDemoBox(
///   child: MyWidget(),
/// )
/// ```
///
/// See also:
/// * [LightDarkBox], which uses this widget to display components in both light and dark modes.
/// * [OudsColoredBox], for the colored background implementation.
class ComponentDemoBox extends StatelessWidget {
  /// The widget to display inside the demo box.
  final Widget child;

  /// Whether to use a colored background with the brand primary color.
  ///
  /// When `true`, uses [OudsColoredBox] with [OudsColoredBoxColor.brandPrimary].
  /// When `false`, uses [ColoredBox] with [ColoredBoxColor.backgroundPrimary]
  /// and adds horizontal padding based on the theme's grid scheme margin.
  ///
  /// Defaults to `false`.
  final bool colored;

  /// Creates a [ComponentDemoBox].
  ///
  /// The [child] parameter must not be null.
  /// The [colored] parameter defaults to `false`.
  const ComponentDemoBox({
    super.key,
    required this.child,
    this.colored = false,
  });

  @override
  Widget build(BuildContext context) {
    if (colored) {
      return OudsColoredBox(
        color: OudsColoredBoxColor.brandPrimary,
        child: child,
      );
    } else {
      return ColoredBox(
        color: ColoredBoxColor.backgroundPrimary,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: OudsTheme.of(context).gridScheme(context).margin),
          child: child,
        ),
      );
    }
  }
}

/// A demo widget that displays its child in both light and dark theme modes.
///
/// This widget creates a vertical column containing two instances of the child widget:
/// one in the default theme mode and another with an inverted theme mode using [OudsThemeTweak].
/// This allows for easy comparison of how components look in different theme modes.
///
/// The child can optionally be centered or displayed at its natural size, controlled
/// by the [hasConstrainedMaxWidthOption] parameter.
///
/// Example:
/// ```dart
/// LightDarkBox(
///   child: ComponentDemoBox(
///   child: // your child to add to the box
/// ),
///   hasConstrainedMaxWidthOption: false,
/// )
/// ```
class LightDarkBox extends StatelessWidget {
  /// The widget to display in both light and dark modes.
  final Widget child;

  /// Whether the child widget has constrained maximum width and should not be centered.
  ///
  /// When `true`, the child is displayed as-is without centering.
  /// When `false`, the child is wrapped in a [Center] widget for centered alignment.
  final bool hasConstrainedMaxWidthOption;

  /// Constructor for [LightDarkBox].
  ///
  /// Requires [child]. The [hasConstrainedMaxWidthOption] parameter defaults to `false`.
  const LightDarkBox({
    required this.child,
    this.hasConstrainedMaxWidthOption = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ComponentDemoBox(
          child: hasConstrainedMaxWidthOption
              ? child
              : Center(
                  child: child,
                ),
        ),
        OudsThemeTweak(
          tweak: OudsThemeTweakType.invert,
          child: ComponentDemoBox(
            child: hasConstrainedMaxWidthOption
                ? child
                : Center(
                    child: child,
                  ),
          ),
        ),
      ],
    );
  }
}

/// A demo colored box widget used to showcase components in different theme modes.
///
/// This widget provides a container with a colored background that displays content
/// with consistent spacing and alignment. It's primarily used for demonstrating how
/// components appear in `DARK` and `LIGHT` theme modes.
///
/// The box has the following characteristics:
/// - Full width with a minimum height of 80 pixels
/// - Vertical padding based on the theme's fixed medium space
/// - Content aligned to the start (left in LTR, right in RTL)
/// - Optional background color from [ColoredBoxColor] enum
///
/// When no [color] is specified, the box uses a transparent background.
///
/// Example:
/// ```dart
/// // Box with primary background color
/// ColoredBox(
///   color: ColoredBoxColor.backgroundPrimary,
///   child: Text('Content'),
/// )
///
/// // Box without background color
/// ColoredBox(
///   child: MyWidget(),
/// )
/// ```
///
/// See also:
/// * [ComponentDemoBox], which uses this widget internally for non-colored demos.
/// * [ColoredBoxColor], for available background color options.
class ColoredBox extends StatelessWidget {
  /// The widget to display at the center of the box.
  final Widget child;

  /// The background color of the box, optional.
  final ColoredBoxColor? color;

  /// Creates a [ColoredBox].
  ///
  /// The [child] parameter must not be null.
  /// The [color] parameter is optional and defaults to `null`.
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
        child: Container(
          alignment: AlignmentDirectional.centerStart,
          child: child,
        ),
      ),
    );
  }
}

/// Enumeration representing the possible background colors for a [ColoredBox].
///
/// Each value in this enum corresponds to a specific color from the theme's color scheme.
/// The actual color value is resolved at runtime based on the current theme and theme mode.
///
/// Example:
/// ```dart
/// final color = ColoredBoxColor.backgroundPrimary.getValue(context);
/// ```
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
