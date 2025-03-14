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
import 'package:ouds_core/ouds_theme.dart';

class ButtonLoadingModifier {
  final OudsButtonLayout layout;
  final OudsButtonHierarchy hierarchy;
  final OudsButtonStyle? style;
  final String? label;

  const ButtonLoadingModifier({
    required this.layout,
    required this.hierarchy,
    this.style,
    this.label,
  });

  static Color getColorToken(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens.button.colorContentStrongLoadingMono : theme.colorsScheme.contentOnActionLoading;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface
            ? theme.componentsTokens.button.colorContentMinimalLoadingMono
            : theme.componentsTokens.button.colorContentMinimalLoading;
      case OudsButtonHierarchy.negative:
        return theme.colorsScheme.contentOnStatusEmphasizedAlt;
      default:
        return onColoredSurface
            ? theme.componentsTokens.button.colorContentDefaultLoadingMono
            : theme.componentsTokens.button.colorContentDefaultLoading;
    }
  }

  static Color getBackgroundToken(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens.button.colorBgStrongLoadingMono : theme.colorsScheme.actionLoading;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens.button.colorBgMinimalLoadingMono : theme.componentsTokens.button.colorBgMinimalLoading;
      case OudsButtonHierarchy.negative:
        return theme.colorsScheme.actionNegativeLoading;
      default:
        return onColoredSurface ? theme.componentsTokens.button.colorBgDefaultLoadingMono : theme.componentsTokens.button.colorBgDefaultLoading;
    }
  }

  static BorderSide getBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface
            ? BorderSide(
                color: theme.componentsTokens.button.colorBorderStrongLoadingMono, width: theme.componentsTokens.button.borderWidthDefaultInteraction)
            : BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface
            ? BorderSide(
                color: theme.componentsTokens.button.colorBorderMinimalLoadingMono,
                width: theme.componentsTokens.button.borderWidthMinimalInteraction)
            : BorderSide(
                color: theme.componentsTokens.button.colorBorderMinimalLoading, width: theme.componentsTokens.button.borderWidthMinimalInteraction);
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return onColoredSurface
            ? BorderSide(
                color: theme.componentsTokens.button.colorBorderDefaultLoadingMono,
                width: theme.componentsTokens.button.borderWidthDefaultInteraction)
            : BorderSide(
                color: theme.componentsTokens.button.colorBorderDefaultLoading, width: theme.componentsTokens.button.borderWidthDefaultInteraction);
    }
  }
}
