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
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongLoading : theme.colorScheme(context).contentOnActionLoading;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalLoading : theme.componentsTokens(context).button.colorContentMinimalLoading;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultLoading : theme.componentsTokens(context).button.colorContentDefaultLoading;
    }
  }

  static Color getBackgroundToken(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongLoading : theme.colorScheme(context).actionLoading;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgMinimalLoading : theme.componentsTokens(context).button.colorBgMinimalLoading;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).actionNegativeLoading;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultLoading : theme.componentsTokens(context).button.colorBgDefaultLoading;
    }
  }

  static BorderSide getBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderStrongLoading, width: theme.componentsTokens(context).button.borderWidthDefaultInteraction) : BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface
            ? BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderMinimalLoading, width: theme.componentsTokens(context).button.borderWidthMinimalInteraction)
            : BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderMinimalLoading, width: theme.componentsTokens(context).button.borderWidthMinimalInteraction);
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return onColoredSurface
            ? BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderDefaultLoading, width: theme.componentsTokens(context).button.borderWidthDefaultInteraction)
            : BorderSide(color: theme.componentsTokens(context).button.colorBorderDefaultLoading, width: theme.componentsTokens(context).button.borderWidthDefaultInteraction);
    }
  }
}
