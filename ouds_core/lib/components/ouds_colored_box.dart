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
import 'package:ouds_core/ouds_theme.dart';

///
/// An OUDS colored box is a [Box] where content color is automatically adjusted to maximize the contrast with the chosen background [color].
///
/// Moreover, the colors of several OUDS components (for instance [OudsButton]) are also automatically adjusted.
/// Some tokens associated with these specific colors can be customized and are identified with the `Mono` suffix (for instance [OudsButtonTokens.colorBgDefaultEnabledMono]).
///
/// [color] The background color.
/// [child] content The content of this colored box.
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
        padding: EdgeInsets.all(OudsTheme.of(context).spaceTokens.fixedMedium),
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
        return theme.colorsScheme.surfaceBrandPrimary;
      case OudsColoredBoxColor.statusAccentEmphasized:
        return theme.colorsScheme.surfaceStatusAccentEmphasized;
      case OudsColoredBoxColor.statusAccentMuted:
        return theme.colorsScheme.surfaceStatusAccentMuted;
      case OudsColoredBoxColor.statusInfoEmphasized:
        return theme.colorsScheme.surfaceStatusInfoEmphasized;
      case OudsColoredBoxColor.statusInfoMuted:
        return theme.colorsScheme.surfaceStatusInfoMuted;
      case OudsColoredBoxColor.statusNegativeEmphasized:
        return theme.colorsScheme.surfaceStatusNegativeEmphasized;
      case OudsColoredBoxColor.statusNegativeMuted:
        return theme.colorsScheme.surfaceStatusNegativeMuted;
      case OudsColoredBoxColor.statusNeutralEmphasized:
        return theme.colorsScheme.surfaceStatusNeutralEmphasized;
      case OudsColoredBoxColor.statusNeutralMuted:
        return theme.colorsScheme.surfaceStatusNeutralMuted;
      case OudsColoredBoxColor.statusPositiveEmphasized:
        return theme.colorsScheme.surfaceStatusPositiveEmphasized;
      case OudsColoredBoxColor.statusPositiveMuted:
        return theme.colorsScheme.surfaceStatusPositiveMuted;
      case OudsColoredBoxColor.statusWarningEmphasized:
        return theme.colorsScheme.surfaceStatusWarningEmphasized;
      case OudsColoredBoxColor.statusWarningMuted:
        return theme.colorsScheme.surfaceStatusWarningMuted;
    }
  }
}
