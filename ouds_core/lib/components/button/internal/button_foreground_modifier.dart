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

/// Used to apply the right forground color associated to the hierarchy and state
class ButtonForegroundModifier {
  static WidgetStateProperty<Color?> resolveForegroundColor(
    BuildContext context,
    OudsButtonHierarchy hierarchy,
    OudsButtonStyle? style,
  ) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (style == OudsButtonStyle.loading) {
          return ButtonLoadingModifier.getColorToken(context, hierarchy);
        }

        if (states.contains(WidgetState.pressed)) {
          return _getPressedForegroundColor(context, hierarchy);
        } else if (states.contains(WidgetState.hovered)) {
          return _getHoverForegroundColor(context, hierarchy);
        } else if (states.contains(WidgetState.disabled)) {
          return _getDisabledForegroundColor(context, hierarchy);
        }
        return _getEnabledForegroundColor(context, hierarchy);
      },
    );
  }

  static Color _getEnabledForegroundColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongEnabled : theme.colorScheme(context).contentOnActionEnabled;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalEnabled : theme.componentsTokens(context).button.colorContentMinimalEnabled;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultEnabled : theme.componentsTokens(context).button.colorContentDefaultEnabled;
    }
  }

  static Color _getHoverForegroundColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongHover : theme.colorScheme(context).contentOnActionHover;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalHover : theme.componentsTokens(context).button.colorContentMinimalHover;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultHover : theme.componentsTokens(context).button.colorContentDefaultHover;
    }
  }

  static Color _getPressedForegroundColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongPressed : theme.colorScheme(context).contentOnActionPressed;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultPressed : theme.componentsTokens(context).button.colorContentDefaultPressed;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultPressed : theme.componentsTokens(context).button.colorContentDefaultPressed;
    }
  }

  static Color _getDisabledForegroundColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongDisabled : theme.colorScheme(context).contentOnActionDisabled;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalDisabled : theme.componentsTokens(context).button.colorContentMinimalDisabled;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnActionDisabled;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultDisabled : theme.componentsTokens(context).button.colorContentDefaultDisabled;
    }
  }
}
