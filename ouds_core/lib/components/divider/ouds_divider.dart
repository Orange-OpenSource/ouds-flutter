//
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
import 'package:ouds_theme_contract/ouds_theme.dart';

/// TODO Add DSM link when available
/// An [OUDS Divider] component as per the design guidelines of OUDS.
///
/// Dividers are used to visually structure an interface by clearly separating content sections. It helps to improve readability and content organization
/// without introducing a strong hierarchy like a heading or a container would.
///
/// You can choose the orientation by using one of the named constructors:
/// - [OudsDivider.horizontal]
/// - [OudsDivider.vertical]
///
/// The following parameters are available:
/// - [color] The color of the divider, chosen from the [OudsDividerColor] enum.
///   Default value set to [OudsDividerColor.defaultColor].
/// - [length] The length of the divider (width for horizontal, height for vertical).
///   Defaults to [double.infinity] for horizontal and 0 for vertical.
/// - [thickness] The thickness of the divider (height for horizontal, width for vertical).
/// - [margin] Optional margin around the divider, for spacing from surrounding content.
///
///
/// # You can use [OudsDivider.horizontal] like this :
///
/// ## Divider horizontal with default color :
///
/// Separates stacked vertical sections. Example use case: Between main content and a footer.
///
///
/// ```dart
///OudsDivider.horizontal(
///       color: OudsDividerColor.defaultColor
///       )
/// ```
///
///
///
/// ## Divider vertical with default color :
///
/// Separates horizontally aligned elements. Example use case: Between two columns in a layout.
///
/// ```dart
///OudsDivider.vertical(
///       color: OudsDividerColor.defaultColor
///       )
/// ```
///

class OudsDivider extends StatelessWidget {
  final Axis orientation;
  final OudsDividerColor color;
  final double length;
  final double? thickness;
  final EdgeInsetsGeometry? margin;

  /// Creates an horizontal divider.
  const OudsDivider.horizontal({
    super.key,
    this.color = OudsDividerColor.defaultColor,
    this.length = double.infinity,
    this.thickness,
    this.margin,
  }) : orientation = Axis.horizontal;

  /// Creates a vertical divider.
  const OudsDivider.vertical({
    super.key,
    this.color = OudsDividerColor.defaultColor,
    this.length = 0,
    this.thickness,
    this.margin,
  }) : orientation = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final actualThickness = thickness ?? OudsTheme.of(context).componentsTokens(context).divider.borderWidth;

    final divider = Container(
      color: color.getColor(context),
      width: orientation == Axis.horizontal ? length : actualThickness,
      height: orientation == Axis.horizontal ? actualThickness : 50,
      margin: margin,
    );

    return Padding(padding: EdgeInsetsDirectional.all(OudsTheme.of(context).spaceScheme(context).fixedMedium), child: divider);
  }
}

/// Represents the available colors for [OudsDivider].
///
/// The authorized colors are :
///
/// - color-border-default,
/// - color-border-muted,
/// - color-border-emphasized,
/// - color-border-brand-primary (secondary/tertiary),
/// - color-border-on-brand-primary (secondary/tertiary),
/// - color-always-black,
/// - color-always-white,
/// - color-always-on-black,
/// - color-always-on-white
///
///
enum OudsDividerColor {
  defaultColor,
  muted,
  emphasized,
  brandPrimary,
  onBrandPrimary,
  alwaysBlack,
  alwaysOnBlack,
  alwaysWhite,
  alwaysOnWhite;

  Color getColor(BuildContext context) {
    final theme = OudsTheme.of(context);

    switch (this) {
      case OudsDividerColor.muted:
        return theme.colorScheme(context).borderMuted;
      case OudsDividerColor.emphasized:
        return theme.colorScheme(context).borderEmphasized;
      case OudsDividerColor.brandPrimary:
        return theme.colorScheme(context).borderBrandPrimary;
      case OudsDividerColor.onBrandPrimary:
        return theme.colorScheme(context).borderOnBrandPrimary;
      case OudsDividerColor.alwaysBlack:
        return theme.colorScheme(context).alwaysBlack;
      case OudsDividerColor.alwaysOnBlack:
        return theme.colorScheme(context).alwaysOnBlack;
      case OudsDividerColor.alwaysWhite:
        return theme.colorScheme(context).alwaysWhite;
      case OudsDividerColor.alwaysOnWhite:
        return theme.colorScheme(context).alwaysOnWhite;
      default:
        return theme.colorScheme(context).borderDefault;
    }
  }
}
