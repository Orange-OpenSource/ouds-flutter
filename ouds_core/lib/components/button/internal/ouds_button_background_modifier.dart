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
import 'package:ouds_core/components/button/internal/ouds_button_control_state.dart';
import 'package:ouds_core/components/button/internal/ouds_button_loading_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the appearance and style
class OudsButtonBackgroundModifier {
  static WidgetStateProperty<Color?> resolveBackgroundColor(
    BuildContext context,
    OudsButtonAppearance appearance,
    OudsButtonControlState? buttonState,
  ) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (buttonState == OudsButtonControlState.loading) {
          return OudsButtonLoadingModifier.getBackgroundToken(context, appearance);
        }

        // Handles both Flutter's native pressed state and custom OudsButton state.
        // `states` is the standard WidgetState set, while `buttonState` is a custom control enum.
        if (states.contains(WidgetState.pressed) || (buttonState != null && buttonState == OudsButtonControlState.pressed)) {
          return _getPressedColor(context, appearance);
        } else if (states.contains(WidgetState.hovered)) {
          return _getHoverColor(context, appearance);
        } else if (states.contains(WidgetState.disabled)) {
          return _getDisabledColor(context, appearance);
        } else if (states.contains(WidgetState.focused) || (buttonState != null && buttonState == OudsButtonControlState.focused)) {
          return _getFocusedColor(context, appearance);
        }

        return _getEnabledColor(context, appearance);
      },
    );
  }

  static Color? _getFocusedColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongFocus : theme.colorScheme(context).actionFocus;
      case OudsButtonAppearance.brand:
        return theme.componentsTokens(context).button.colorBgBrandFocus;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgMinimalFocus : theme.componentsTokens(context).button.colorBgMinimalFocus;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).actionNegativeFocus;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultFocus : theme.componentsTokens(context).button.colorBgDefaultFocus;
    }
  }

  static Color? _getEnabledColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongEnabled : theme.colorScheme(context).actionEnabled;
      case OudsButtonAppearance.brand:
        return theme.componentsTokens(context).button.colorBgBrandEnabled;
      case OudsButtonAppearance.minimal:
        return null;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).actionNegativeEnabled;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultEnabled : theme.componentsTokens(context).button.colorBgDefaultEnabled;
    }
  }

  static Color? _getHoverColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongHover : theme.colorScheme(context).actionHover;
      case OudsButtonAppearance.brand:
        return theme.componentsTokens(context).button.colorBgBrandHover;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgMinimalHover : theme.componentsTokens(context).button.colorBgMinimalHover;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).actionNegativeHover;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultHover : theme.componentsTokens(context).button.colorBgDefaultHover;
    }
  }

  static Color? _getPressedColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongPressed : theme.colorScheme(context).actionPressed;
      case OudsButtonAppearance.brand:
        return theme.componentsTokens(context).button.colorBgBrandPressed;
      case OudsButtonAppearance.minimal:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgMinimalPressed : theme.componentsTokens(context).button.colorBgMinimalPressed;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).actionNegativePressed;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultPressed : theme.componentsTokens(context).button.colorBgDefaultPressed;
    }
  }

  static Color? _getDisabledColor(BuildContext context, OudsButtonAppearance appearance) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (appearance) {
      case OudsButtonAppearance.strong:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgStrongDisabled : theme.colorScheme(context).actionDisabled;
      case OudsButtonAppearance.brand:
        return theme.colorScheme(context).actionDisabled;
      case OudsButtonAppearance.minimal:
        return null;
      case OudsButtonAppearance.negative:
        return theme.colorScheme(context).actionDisabled;
      default:
        return onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBgDefaultDisabled : theme.componentsTokens(context).button.colorBgDefaultDisabled;
    }
  }
}
