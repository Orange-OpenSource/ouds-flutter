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

/// Used to apply the right background color associated to the hierarchy and style
class ButtonBackgroundModifier {
  static WidgetStateProperty<Color?> resolveBackgroundColor(
    BuildContext context,
    OudsButtonHierarchy hierarchy,
    OudsButtonStyle? style,
  ) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (style == OudsButtonStyle.loading) {
          return ButtonLoadingModifier.getBackgroundToken(context, hierarchy);
        }

        if (states.contains(WidgetState.pressed)) {
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

  /// Retrieve the global onColoredSurface
  bool get onColoredSurface => OudsTheme.onColoredSurfaceGlobal;

  static Color _getEnabledColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return OudsTheme.onColoredSurfaceGlobal ? theme.componentsTokens.button.colorBgStrongEnabledMono : theme.colorsScheme.actionEnabled;
      case OudsButtonHierarchy.minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgMinimalEnabledMono
            : theme.componentsTokens.button.colorBgMinimalEnabled;
      case OudsButtonHierarchy.negative:
        return theme.colorsScheme.actionNegativeEnabled;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgDefaultEnabledMono
            : theme.componentsTokens.button.colorBgDefaultEnabled;
    }
  }

  static Color _getHoverColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return OudsTheme.onColoredSurfaceGlobal ? theme.componentsTokens.button.colorBgStrongHoverMono : theme.colorsScheme.actionHover;
      case OudsButtonHierarchy.minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgMinimalHoverMono
            : theme.componentsTokens.button.colorBgMinimalHover;
      case OudsButtonHierarchy.negative:
        return theme.colorsScheme.actionNegativeHover;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgDefaultHoverMono
            : theme.componentsTokens.button.colorBgDefaultHover;
    }
  }

  static Color _getPressedColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return OudsTheme.onColoredSurfaceGlobal ? theme.componentsTokens.button.colorBgStrongPressedMono : theme.colorsScheme.actionPressed;
      case OudsButtonHierarchy.minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgMinimalPressedMono
            : theme.componentsTokens.button.colorBgMinimalPressed;
      case OudsButtonHierarchy.negative:
        return theme.colorsScheme.actionNegativePressed;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgDefaultPressedMono
            : theme.componentsTokens.button.colorBgDefaultPressed;
    }
  }

  static Color _getDisabledColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return OudsTheme.onColoredSurfaceGlobal ? theme.componentsTokens.button.colorBgStrongDisabledMono : theme.colorsScheme.actionDisabled;
      case OudsButtonHierarchy.minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgMinimalDisabledMono
            : theme.componentsTokens.button.colorBgMinimalDisabled;
      case OudsButtonHierarchy.negative:
        return theme.colorsScheme.actionDisabled;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgDefaultDisabledMono
            : theme.componentsTokens.button.colorBgDefaultDisabled;
    }
  }
}
