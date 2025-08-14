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
import 'package:ouds_core/components/button/internal/ouds_button_control_state.dart';
import 'package:ouds_core/components/button/internal/ouds_button_loading_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply a border with color, width and radius associated to the hierarchy
class OudsButtonBorderModifier {
  static WidgetStateProperty<BorderSide?> resolveBorderColor(
    BuildContext context,
    OudsButtonHierarchy hierarchy,
    OudsButtonControlState? buttonState,
  ) {
    return WidgetStateProperty.resolveWith<BorderSide?>(
      (Set<WidgetState> states) {
        if (buttonState == OudsButtonControlState.loading) {
          return OudsButtonLoadingModifier.getBorderColor(context, hierarchy);
        }
        if (states.contains(WidgetState.pressed)) {
          return _getPressedBorderColor(context, hierarchy);
        } else if (states.contains(WidgetState.hovered)) {
          return _getHoverBorderColor(context, hierarchy);
        } else if (states.contains(WidgetState.disabled)) {
          return _getDisabledBorderColor(context, hierarchy);
        }
        return _getEnabledBorderColor(context, hierarchy);
      },
    );
  }

  static BorderSide _getEnabledBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderStrongEnabled, width: theme.componentsTokens(context).button.borderWidthDefault) : BorderSide.none;
      case OudsButtonHierarchy.brand:
        return BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return BorderSide.none;
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return BorderSide(
            color: onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBorderDefaultEnabled : theme.componentsTokens(context).button.colorBorderDefaultEnabled, width: theme.componentsTokens(context).button.borderWidthDefault);
    }
  }

  static BorderSide _getHoverBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderStrongHover, width: theme.componentsTokens(context).button.borderWidthDefaultInteraction) : BorderSide.none;
      case OudsButtonHierarchy.brand:
        return BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return BorderSide.none;
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return BorderSide(
            color: onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBorderDefaultEnabled : theme.componentsTokens(context).button.colorBorderDefaultHover, width: theme.componentsTokens(context).button.borderWidthDefaultInteraction);
    }
  }

  static BorderSide _getPressedBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderStrongPressed, width: theme.componentsTokens(context).button.borderWidthDefaultInteraction) : BorderSide.none;
      case OudsButtonHierarchy.brand:
        return BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return BorderSide.none;
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return BorderSide(
            color: onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBorderDefaultPressed : theme.componentsTokens(context).button.colorBorderDefaultPressed,
            width: theme.componentsTokens(context).button.borderWidthDefaultInteraction);
    }
  }

  static BorderSide _getDisabledBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface ? BorderSide(color: theme.componentsTokens(context).buttonMono.colorBorderStrongDisabled, width: theme.componentsTokens(context).button.borderWidthDefault) : BorderSide.none;
      case OudsButtonHierarchy.brand:
        return BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return BorderSide.none;
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return BorderSide(
            color: onColoredSurface ? theme.componentsTokens(context).buttonMono.colorBorderDefaultDisabled : theme.componentsTokens(context).button.colorBorderDefaultDisabled, width: theme.componentsTokens(context).button.borderWidthDefault);
    }
  }

  /// Static method to get the border radius for a button based on the border parameter.
  /// Returns a [BorderRadius] object with the appropriate radius value.
  static BorderRadius getBorderRadius(BuildContext context) {
    final button = OudsTheme.of(context).componentsTokens(context).button;
    final buttonRounded = OudsThemeConfigModel.of(context)?.button?.rounded ?? false;
    switch (buttonRounded) {
      case true:
        return BorderRadius.circular(button.borderRadiusRounded);
      case false:
        return BorderRadius.circular(button.borderRadiusDefault);
    }
  }
}
