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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsButtonLoadingModifier {
  final OudsButtonLayout layout;
  final OudsButtonAppearance appearance;
  final String? label;

  const OudsButtonLoadingModifier({
    required this.layout,
    required this.appearance,
    this.label,
  });

  static Color getColorToken(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongLoading : theme.colorScheme(context).contentOnActionLoading;
      case OudsButtonAppearance.brand:
        return theme.colorScheme(context).contentOnActionLoading;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalLoading : theme.componentsTokens(context).button.colorContentMinimalLoading;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultLoading : theme.componentsTokens(context).button.colorContentDefaultLoading;
    }
  }

  static Color? getBackgroundToken(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongLoading : theme.colorScheme(context).actionLoading;
      case OudsButtonAppearance.brand:
        return theme.colorScheme(context).actionLoading;
      case OudsButtonAppearance.minimal:
        return null;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).actionNegativeLoading;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultLoading : theme.componentsTokens(context).button.colorBgDefaultLoading;
    }
  }

  static BorderSide getBorderColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return BorderSide.none;
      case OudsButtonAppearance.brand:
        return BorderSide.none;
      case OudsButtonAppearance.minimal:
        return BorderSide.none;
      case OudsButtonAppearance.negative:
        return BorderSide.none;
      default:
        return onColoredSurface
            ? BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderDefaultLoading, width: theme.componentsTokens(context).button.borderWidthDefaultInteraction)
            : BorderSide(color: theme.componentsTokens(context).button.colorBorderDefaultLoading, width: theme.componentsTokens(context).button.borderWidthDefaultInteraction);
    }
  }
}
