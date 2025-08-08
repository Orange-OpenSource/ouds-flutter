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
import 'package:ouds_core/components/button/internal/ouds_button_control_state.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Class responsible for modifying the icon appearance of an Ouds button based on its state and context.
class OudsButtonIconModifier {
  final BuildContext context;

  /// Constructor that takes the build context.
  OudsButtonIconModifier(this.context);

  /// Static method to get the icon color based on button state, hierarchy, and style.
  static Color getIconColor(BuildContext context, OudsButtonControlState states, OudsButtonHierarchy hierarchy, OudsButtonStyle? style) {
    if (style == OudsButtonStyle.loading) {
      // If the button is in loading style, get the loading color token.
      return ButtonLoadingModifier.getColorToken(context, hierarchy);
    }
    // Determine icon color based on the current control state.
    switch (states) {
      case OudsButtonControlState.enabled:
        return _getEnabledIconColor(context, hierarchy);
      case OudsButtonControlState.hovered:
        return _getHoverIconColor(context, hierarchy);
      case OudsButtonControlState.pressed:
        return _getPressedIconColor(context, hierarchy);
      case OudsButtonControlState.disabled:
        return _getDisabledIconColor(context, hierarchy);
    }
  }

  /// Private static method to get the icon color when the button is enabled.
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

  /// Private static method to get the icon color when the button is hovered.
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

  /// Private static method to get the icon color when the button is pressed.
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

  /// Private static method to get the icon color when the button is disabled.
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

  /// Static method to get the icon size based on button layout.
  static double getIconSize(BuildContext context, OudsButtonLayout layout) {
    final buttonToken = OudsTheme.of(context).componentsTokens(context).button;
    switch (layout) {
      case OudsButtonLayout.iconOnly:
        return buttonToken.sizeIconOnly;
      case OudsButtonLayout.iconAndText:
        return buttonToken.sizeIcon;
      case OudsButtonLayout.textOnly:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
