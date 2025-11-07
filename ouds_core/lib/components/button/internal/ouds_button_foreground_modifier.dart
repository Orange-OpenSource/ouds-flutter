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

/// Used to apply the right forground color associated to the appearance and state
class OudsButtonForegroundModifier {
  static WidgetStateProperty<Color?> resolveForegroundColor(
    BuildContext context,
    OudsButtonAppearance appearance,
    OudsButtonControlState? buttonState,
  ) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (buttonState == OudsButtonControlState.loading) {
          return OudsButtonLoadingModifier.getColorToken(context, appearance);
        }

        // Handles both Flutter's native pressed state and custom OudsButton state.
        // `states` is the standard WidgetState set, while `buttonState` is a custom control enum.
        if (states.contains(WidgetState.pressed) || (buttonState != null && buttonState == OudsButtonControlState.pressed)) {
          return _getPressedForegroundColor(context, appearance);
        } else if (states.contains(WidgetState.hovered)) {
          return _getHoverForegroundColor(context, appearance);
        } else if (states.contains(WidgetState.disabled)) {
          return _getDisabledForegroundColor(context, appearance);
        }
        return _getEnabledForegroundColor(context, appearance);
      },
    );
  }

  static Color _getEnabledForegroundColor(BuildContext context, OudsButtonAppearance appearance) {
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

  static Color _getHoverForegroundColor(BuildContext context, OudsButtonAppearance appearance) {
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

  static Color _getPressedForegroundColor(BuildContext context, OudsButtonAppearance appearance) {
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

  static Color _getDisabledForegroundColor(BuildContext context, OudsButtonAppearance appearance) {
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
}
