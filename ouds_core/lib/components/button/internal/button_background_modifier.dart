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
import 'package:ouds_core/components/button/internal/button_loading_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the hierarchy and style
class ButtonBackgroundModifier {
  static WidgetStateProperty<Color?> resolveBackgroundColor(
    BuildContext context,
    OudsButtonHierarchy hierarchy,
    OudsButtonStyle? style,
    bool isPressed,
  ) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (style == OudsButtonStyle.loading) {
          return ButtonLoadingModifier.getBackgroundToken(context, hierarchy);
        }

        if (states.contains(WidgetState.pressed) || isPressed) {
          return _getPressedColor(context, hierarchy);
        } else if (states.contains(WidgetState.hovered)) {
          return _getHoverColor(context, hierarchy);
        } else if (states.contains(WidgetState.disabled)) {
          return _getDisabledColor(context, hierarchy);
        }

        return _getEnabledColor(context, hierarchy);
      },
    );
  }

  static Color _getEnabledColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongEnabled : theme.colorScheme(context).actionEnabled;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgMinimalEnabled : theme.componentsTokens(context).button.colorBgMinimalEnabled;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).actionNegativeEnabled;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultEnabled : theme.componentsTokens(context).button.colorBgDefaultEnabled;
    }
  }

  static Color _getHoverColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongHover : theme.colorScheme(context).actionHover;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).button.colorBgMinimalHover : theme.componentsTokens(context).button.colorBgMinimalHover;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).actionNegativeHover;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultHover : theme.componentsTokens(context).button.colorBgDefaultHover;
    }
  }

  static Color _getPressedColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongPressed : theme.colorScheme(context).actionPressed;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgMinimalPressed : theme.componentsTokens(context).button.colorBgMinimalPressed;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).actionNegativePressed;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultPressed : theme.componentsTokens(context).button.colorBgDefaultPressed;
    }
  }

  static Color _getDisabledColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongDisabled : theme.colorScheme(context).actionDisabled;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgMinimalDisabled : theme.componentsTokens(context).button.colorBgMinimalDisabled;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).actionDisabled;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultDisabled : theme.componentsTokens(context).button.colorBgDefaultDisabled;
    }
  }
}
