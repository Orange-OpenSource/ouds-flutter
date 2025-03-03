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
import 'package:ouds_core/ouds_theme.dart';

/// Used to apply the right forground color associated to the hierarchy and state
class ButtonForegroundModifier {
  static WidgetStateProperty<Color?> resolveForegroundColor(
    BuildContext context,
    ButtonHierarchy hierarchy,
    OudsButtonStyle2? style,
  ) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (style == OudsButtonStyle2.loading) {
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

  static Color _getEnabledForegroundColor(BuildContext context, ButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case ButtonHierarchy.Strong:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentStrongEnabledMono
            : theme.colorsScheme.contentOnActionEnabled;
      case ButtonHierarchy.Minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentMinimalEnabledMono
            : theme.componentsTokens.button.colorContentMinimalEnabled;
      case ButtonHierarchy.Negative:
        return theme.colorsScheme.contentOnStatusEmphasizedAlt;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentDefaultEnabledMono
            : theme.componentsTokens.button.colorContentDefaultEnabled;
    }
  }

  static Color _getHoverForegroundColor(BuildContext context, ButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case ButtonHierarchy.Strong:
        return OudsTheme.onColoredSurfaceGlobal ? theme.componentsTokens.button.colorContentStrongHoverMono : theme.colorsScheme.contentOnActionHover;
      case ButtonHierarchy.Minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentMinimalHoverMono
            : theme.componentsTokens.button.colorContentMinimalHover;
      case ButtonHierarchy.Negative:
        return theme.colorsScheme.contentOnStatusEmphasizedAlt;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentDefaultHoverMono
            : theme.componentsTokens.button.colorContentDefaultHover;
    }
  }

  static Color _getPressedForegroundColor(BuildContext context, ButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case ButtonHierarchy.Strong:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentStrongPressedMono
            : theme.colorsScheme.contentOnActionPressed;
      case ButtonHierarchy.Minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentDefaultPressedMono
            : theme.componentsTokens.button.colorContentDefaultPressed;
      case ButtonHierarchy.Negative:
        return theme.colorsScheme.contentOnStatusEmphasizedAlt;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentDefaultPressedMono
            : theme.componentsTokens.button.colorContentDefaultPressed;
    }
  }

  static Color _getDisabledForegroundColor(BuildContext context, ButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case ButtonHierarchy.Strong:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentStrongDisabledMono
            : theme.colorsScheme.contentOnActionDisabled;
      case ButtonHierarchy.Minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentMinimalDisabledMono
            : theme.componentsTokens.button.colorContentMinimalDisabled;
      case ButtonHierarchy.Negative:
        return theme.colorsScheme.contentOnActionDisabled;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentDefaultDisabledMono
            : theme.componentsTokens.button.colorContentDefaultDisabled;
    }
  }
}
