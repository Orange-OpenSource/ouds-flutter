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

/// Used to apply a border with color, width and radius associated to the hierarchy
class ButtonBorderModifier {
  static WidgetStateProperty<BorderSide?> resolveBorderColor(
    BuildContext context,
    OudsButtonHierarchy hierarchy,
    OudsButtonStyle? style,
  ) {
    return WidgetStateProperty.resolveWith<BorderSide?>(
      (Set<WidgetState> states) {
        if (style == OudsButtonStyle.loading) {
          return ButtonLoadingModifier.getBorderColor(context, hierarchy);
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
        return onColoredSurface
            ? BorderSide(color: theme.componentsTokens.button.colorBorderStrongEnabledMono, width: theme.componentsTokens.button.borderWidthDefault)
            : BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return BorderSide(
            color: onColoredSurface
                ? theme.componentsTokens.button.colorBorderMinimalEnabledMono
                : theme.componentsTokens.button.colorBorderMinimalEnabled,
            width: theme.componentsTokens.button.borderWidthMinimal);
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return BorderSide(
            color: onColoredSurface
                ? theme.componentsTokens.button.colorBorderDefaultEnabledMono
                : theme.componentsTokens.button.colorBorderDefaultEnabled,
            width: theme.componentsTokens.button.borderWidthDefault);
    }
  }

  static BorderSide _getHoverBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface
            ? BorderSide(
                color: theme.componentsTokens.button.colorBorderStrongHoverMono, width: theme.componentsTokens.button.borderWidthDefaultInteraction)
            : BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return BorderSide(
            color:
                onColoredSurface ? theme.componentsTokens.button.colorBorderMinimalHoverMono : theme.componentsTokens.button.colorBorderMinimalHover,
            width: theme.componentsTokens.button.borderWidthMinimalInteraction);
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return BorderSide(
            color: onColoredSurface
                ? theme.componentsTokens.button.colorBorderDefaultEnabledMono
                : theme.componentsTokens.button.colorBorderDefaultHover,
            width: theme.componentsTokens.button.borderWidthDefaultInteraction);
    }
  }

  static BorderSide _getPressedBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface
            ? BorderSide(
                color: theme.componentsTokens.button.colorBorderStrongPressedMono, width: theme.componentsTokens.button.borderWidthDefaultInteraction)
            : BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return BorderSide(
            color: onColoredSurface
                ? theme.componentsTokens.button.colorBorderMinimalPressedMono
                : theme.componentsTokens.button.colorBorderMinimalPressed,
            width: theme.componentsTokens.button.borderWidthMinimalInteraction);
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return BorderSide(
            color: onColoredSurface
                ? theme.componentsTokens.button.colorBorderDefaultPressedMono
                : theme.componentsTokens.button.colorBorderDefaultPressed,
            width: theme.componentsTokens.button.borderWidthDefaultInteraction);
    }
  }

  static BorderSide _getDisabledBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.strong:
        return onColoredSurface
            ? BorderSide(color: theme.componentsTokens.button.colorBorderStrongDisabledMono, width: theme.componentsTokens.button.borderWidthDefault)
            : BorderSide.none;
      case OudsButtonHierarchy.minimal:
        return BorderSide(
            color: onColoredSurface
                ? theme.componentsTokens.button.colorBorderMinimalDisabledMono
                : theme.componentsTokens.button.colorBorderMinimalDisabled,
            width: theme.componentsTokens.button.borderWidthMinimalInteraction);
      case OudsButtonHierarchy.negative:
        return BorderSide.none;
      default:
        return BorderSide(
            color: onColoredSurface
                ? theme.componentsTokens.button.colorBorderDefaultDisabledMono
                : theme.componentsTokens.button.colorBorderDefaultDisabled,
            width: theme.componentsTokens.button.borderWidthDefault);
    }
  }
}
