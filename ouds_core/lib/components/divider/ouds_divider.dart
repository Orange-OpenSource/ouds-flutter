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
///   Defaults to [double.infinity].
/// - [thickness] The thickness of the divider (height for horizontal, width for vertical).
///   Defaults to `1.0`.
/// - [margin] Optional margin around the divider, for spacing from surrounding content.
///

/// Represents the available colors for [OudsDivider].
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

class OudsDivider extends StatelessWidget {
  final Axis orientation;
  final OudsDividerColor color;
  final double length;
  final double thickness;
  final EdgeInsetsGeometry? margin;

  /// Creates a horizontal divider.
  const OudsDivider.horizontal({
    this.color = OudsDividerColor.defaultColor,
    this.length = double.infinity,
    this.thickness = 1,
    this.margin,
  }) : orientation = Axis.horizontal;

  /// Creates a vertical divider.
  const OudsDivider.vertical({
    this.color = OudsDividerColor.defaultColor,
    this.length = 100,
    this.thickness = 1,
    this.margin,
  }) : orientation = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    var colors = OudsDividerColor.values;

    final divider = Container(
      color: colors.first.getColor(context),
      width: orientation == Axis.horizontal ? length : thickness,
      height: orientation == Axis.horizontal ? thickness : length,
      margin: margin,
    );

    return divider;
  }
}

/// OUDS Divider is a styled thin line of 1dp thickness that groups content in lists and layouts.
class OudsDividerList extends StatelessWidget {
  const OudsDividerList({super.key});

  final double _dividerOpacity = 0.12;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      thickness: 1,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(_dividerOpacity),
    );
  }
}
