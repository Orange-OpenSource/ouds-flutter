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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/internal/ouds_button_control_state.dart';
import 'package:ouds_core/components/button/internal/ouds_button_loading_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Class responsible for modifying the icon appearance of an Ouds button based on its state and context.
class OudsButtonIconModifier {
  final BuildContext context;

  /// Constructor that takes the build context.
  OudsButtonIconModifier(this.context);

  /// Static method to get the icon color based on button state, appearance.
  static Color getIconColor(BuildContext context, OudsButtonControlState states, OudsButtonAppearance appearance) {
    // Determine icon color based on the current control state.
    switch (states) {
      case OudsButtonControlState.enabled:
        return _getEnabledIconColor(context, appearance);
      case OudsButtonControlState.hovered:
        return _getHoverIconColor(context, appearance);
      case OudsButtonControlState.pressed:
        return _getPressedIconColor(context, appearance);
      case OudsButtonControlState.disabled:
        return _getDisabledIconColor(context, appearance);
      case OudsButtonControlState.focused:
        return _getFocusedIconColor(context, appearance);
      case OudsButtonControlState.loading:
        return OudsButtonLoadingModifier.getColorToken(context, appearance);
    }
  }

  /// Private static method to get the icon color when the button is enabled.
  static Color _getFocusedIconColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongFocus : theme.colorScheme(context).contentOnActionFocus;
      case OudsButtonAppearance.brand:
        return theme.componentsTokens(context).button.colorContentBrandFocus;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalFocus : theme.componentsTokens(context).button.colorContentMinimalFocus;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultFocus : theme.componentsTokens(context).button.colorContentDefaultFocus;
    }
  }

  /// Private static method to get the icon color when the button is enabled.
  static Color _getEnabledIconColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongEnabled : theme.colorScheme(context).contentOnActionEnabled;
      case OudsButtonAppearance.brand:
        return theme.componentsTokens(context).button.colorContentBrandEnabled;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalEnabled : theme.componentsTokens(context).button.colorContentMinimalEnabled;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultEnabled : theme.componentsTokens(context).button.colorContentDefaultEnabled;
    }
  }

  /// Private static method to get the icon color when the button is hovered.
  static Color _getHoverIconColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongHover : theme.colorScheme(context).contentOnActionHover;
      case OudsButtonAppearance.brand:
        return theme.colorScheme(context).contentOnActionHover;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalHover : theme.componentsTokens(context).button.colorContentMinimalHover;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultHover : theme.componentsTokens(context).button.colorContentDefaultHover;
    }
  }

  /// Private static method to get the icon color when the button is pressed.
  static Color _getPressedIconColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongPressed : theme.colorScheme(context).contentOnActionPressed;
      case OudsButtonAppearance.brand:
        return theme.colorScheme(context).contentOnActionPressed;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultPressed : theme.componentsTokens(context).button.colorContentDefaultPressed;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).contentOnStatusNegativeEmphasized;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentDefaultPressed : theme.componentsTokens(context).button.colorContentDefaultPressed;
    }
  }

  /// Private static method to get the icon color when the button is disabled.
  static Color _getDisabledIconColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentStrongDisabled : theme.colorScheme(context).contentOnActionDisabled;
      case OudsButtonAppearance.brand:
        return theme.colorScheme(context).contentOnActionDisabled;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorContentMinimalDisabled : theme.componentsTokens(context).button.colorContentMinimalDisabled;
      case OudsButtonAppearance.negative:
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
