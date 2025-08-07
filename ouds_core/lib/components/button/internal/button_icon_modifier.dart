/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/internal/button_loading_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsButtonIconModifier {
  final BuildContext context;

  OudsButtonIconModifier(this.context);

  static Color getIconColor(BuildContext context, OudsButtonControlState states, OudsButtonHierarchy hierarchy, OudsButtonStyle? style) {
    if (style == OudsButtonStyle.loading) {
      return ButtonLoadingModifier.getColorToken(context, hierarchy);
    }
    switch (states) {
      case OudsButtonControlState.enabled:
        return _getEnabledIconColor(context, hierarchy);
      case OudsButtonControlState.hovered:
        //return Colors.yellow;
        return _getHoverIconColor(context, hierarchy);
      case OudsButtonControlState.pressed:
        return _getPressedIconColor(context, hierarchy);
      case OudsButtonControlState.disabled:
        return _getDisabledIconColor(context, hierarchy);
    }
  }

  /// Color icon color based on button state and selection
  static Color _getEnabledIconColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongEnabled : theme.colorScheme(context).contentOnActionEnabled;
      case OudsButtonHierarchy.brand:
        return theme.componentsTokens(context).button.colorContentBrandEnabled;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalEnabled : theme.componentsTokens(context).button.colorContentMinimalEnabled;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultEnabled : theme.componentsTokens(context).button.colorContentDefaultEnabled;
    }
  }

  static Color _getHoverIconColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongHover : theme.colorScheme(context).contentOnActionHover;
      case OudsButtonHierarchy.brand:
        return theme.colorScheme(context).contentOnActionHover;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalHover : theme.componentsTokens(context).button.colorContentMinimalHover;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultHover : theme.componentsTokens(context).button.colorContentDefaultHover;
    }
  }

  static Color _getPressedIconColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongPressed : theme.colorScheme(context).contentOnActionPressed;
      case OudsButtonHierarchy.brand:
        return theme.colorScheme(context).contentOnActionPressed;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultPressed : theme.componentsTokens(context).button.colorContentDefaultPressed;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultPressed : theme.componentsTokens(context).button.colorContentDefaultPressed;
    }
  }

  static Color _getDisabledIconColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongDisabled : theme.colorScheme(context).contentOnActionDisabled;
      case OudsButtonHierarchy.brand:
        return theme.colorScheme(context).contentOnActionDisabled;
      case OudsButtonHierarchy.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalDisabled : theme.componentsTokens(context).button.colorContentMinimalDisabled;
      case OudsButtonHierarchy.negative:
        return theme.colorScheme(context).contentOnActionDisabled;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultDisabled : theme.componentsTokens(context).button.colorContentDefaultDisabled;
    }
  }

  static double getIconSize(BuildContext context, OudsButtonLayout layout) {
    final buttonToken = OudsTheme.of(context).componentsTokens(context).button;
    switch (layout) {
      case OudsButtonLayout.iconOnly:
        return buttonToken.sizeIconOnly;
      case OudsButtonLayout.iconAndText:
        return buttonToken.sizeIcon;
      case OudsButtonLayout.textOnly:
        return 0.0;
    }
  }
}

// TODO: create new file for this class

/// Enum representing the state of the chip control.
enum OudsButtonControlState {
  enabled,
  hovered,
  pressed,
  disabled,
}

/// A class that determines the state of the OudsChip
class OudsButtonControlStateDeterminer {
  final bool enabled;
  final bool isHovered;
  final bool isPressed;

  OudsButtonControlStateDeterminer({
    required this.enabled,
    this.isHovered = false,
    this.isPressed = false,
  });

  /// Determines the current material state of the control.
  OudsButtonControlState determineControlState() {
    if (!enabled) return OudsButtonControlState.disabled;
    if (isPressed) return OudsButtonControlState.pressed;
    if (isHovered) return OudsButtonControlState.hovered;
    return OudsButtonControlState.enabled;
  }
}
