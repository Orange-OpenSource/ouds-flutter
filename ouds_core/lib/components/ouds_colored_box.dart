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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

///
/// An OUDS colored box is a [Box] where content color is automatically adjusted to maximize the contrast with the chosen background [color].
///
/// Moreover, the colors of several OUDS components are also automatically adjusted.
/// Some tokens associated with these specific colors can be customized and are identified with the `Mono` suffix (for instance [OudsButtonTokens.colorBgDefaultEnabledMono]).
///
/// [color] The background color of the colored box.
/// [child] content The content of this colored box.
///
///
/// ## Yo can use [OudsColoredBox] with [OudsButton] like this
///
///
/// ```dart
/// OudsColoredBox(
///       color: OudsColoredBoxColor.brandPrimary
///       child: OudsButton(
///         label: "Label",
///         onPressed: () {}
///       ),
///     );
/// ```
///
///
class OudsColoredBox extends StatelessWidget {
  final Widget child;
  final OudsColoredBoxColor? color;

  const OudsColoredBox({
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
        padding: EdgeInsetsDirectional.symmetric(vertical: OudsTheme.of(context).spaceScheme(context).fixedMedium, horizontal: OudsTheme.of(context).spaceScheme(context).fixedNone),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

///Represents the possible background colors of an [OudsColoredBox].
enum OudsColoredBoxColor {
  brandPrimary,
  statusAccentEmphasized,
  statusAccentMuted,
  statusInfoEmphasized,
  statusInfoMuted,
  statusNegativeEmphasized,
  statusNegativeMuted,
  statusNeutralEmphasized,
  statusNeutralMuted,
  statusPositiveEmphasized,
  statusPositiveMuted,
  statusWarningEmphasized,
  statusWarningMuted;

  Color getValue(BuildContext context) {
    final theme = OudsTheme.of(context);

    switch (this) {
      case OudsColoredBoxColor.brandPrimary:
        return theme.colorScheme(context).surfaceBrandPrimary;
      case OudsColoredBoxColor.statusAccentEmphasized:
        return theme.colorScheme(context).surfaceStatusAccentEmphasized;
      case OudsColoredBoxColor.statusAccentMuted:
        return theme.colorScheme(context).surfaceStatusAccentMuted;
      case OudsColoredBoxColor.statusInfoEmphasized:
        return theme.colorScheme(context).surfaceStatusInfoEmphasized;
      case OudsColoredBoxColor.statusInfoMuted:
        return theme.colorScheme(context).surfaceStatusInfoMuted;
      case OudsColoredBoxColor.statusNegativeEmphasized:
        return theme.colorScheme(context).surfaceStatusNegativeEmphasized;
      case OudsColoredBoxColor.statusNegativeMuted:
        return theme.colorScheme(context).surfaceStatusNegativeMuted;
      case OudsColoredBoxColor.statusNeutralEmphasized:
        return theme.colorScheme(context).surfaceStatusNeutralEmphasized;
      case OudsColoredBoxColor.statusNeutralMuted:
        return theme.colorScheme(context).surfaceStatusNeutralMuted;
      case OudsColoredBoxColor.statusPositiveEmphasized:
        return theme.colorScheme(context).surfaceStatusPositiveEmphasized;
      case OudsColoredBoxColor.statusPositiveMuted:
        return theme.colorScheme(context).surfaceStatusPositiveMuted;
      case OudsColoredBoxColor.statusWarningEmphasized:
        return theme.colorScheme(context).surfaceStatusWarningEmphasized;
      case OudsColoredBoxColor.statusWarningMuted:
        return theme.colorScheme(context).surfaceStatusWarningMuted;
    }
  }
}
