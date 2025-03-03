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
      height: 80,
      width: double.infinity,
      color: color?.getValue(context),
      child: Center(
        child: child,
      ),
    );
  }
}

/// Enum représentant les différentes couleurs possibles pour le ColoredBox.
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

  /// Retourne la couleur associée à l'enum
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
