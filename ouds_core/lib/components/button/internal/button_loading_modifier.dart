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
import 'package:ouds_core/components/button/internal/button_style_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/ouds_theme.dart';

class ButtonLoadingModifier extends StatelessWidget {
  final OudsButtonLayout layout;
  final OudsButtonHierarchy hierarchy;
  final OudsButtonStyle? style;
  final String? label;

  const ButtonLoadingModifier({
    super.key,
    required this.layout,
    required this.hierarchy,
    this.style,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: null,
      style: ButtonStyleModifier.buildButtonStyle(context, hierarchy: hierarchy, layout: layout, style: style),
      icon: null,
      label: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: OudsTheme.of(context).opacityTokens.invisible,
            child: Text(label!),
          ),
          SizedBox(
            width: OudsTheme.of(context).componentsTokens.button.sizeIcon,
            height: OudsTheme.of(context).componentsTokens.button.sizeIcon,
            child: CircularProgressIndicator(
              color: getColorToken(context, hierarchy),
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }

  static Color getColorToken(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.Strong:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentStrongLoadingMono
            : theme.colorsScheme.contentOnActionLoading;
      case OudsButtonHierarchy.Minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentMinimalLoadingMono
            : theme.componentsTokens.button.colorContentMinimalLoading;
      case OudsButtonHierarchy.Negative:
        return theme.colorsScheme.contentOnStatusEmphasizedAlt;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorContentDefaultLoadingMono
            : theme.componentsTokens.button.colorContentDefaultLoading;
    }
  }

  static Color getBackgroundToken(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.Strong:
        return OudsTheme.onColoredSurfaceGlobal ? theme.componentsTokens.button.colorBgStrongLoadingMono : theme.colorsScheme.actionLoading;
      case OudsButtonHierarchy.Minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgMinimalLoadingMono
            : theme.componentsTokens.button.colorBgMinimalLoading;
      case OudsButtonHierarchy.Negative:
        return theme.colorsScheme.actionNegativeLoading;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? theme.componentsTokens.button.colorBgDefaultLoadingMono
            : theme.componentsTokens.button.colorBgDefaultLoading;
    }
  }

  static BorderSide getBorderColor(BuildContext context, OudsButtonHierarchy hierarchy) {
    final theme = OudsTheme.of(context);
    switch (hierarchy) {
      case OudsButtonHierarchy.Strong:
        return OudsTheme.onColoredSurfaceGlobal
            ? BorderSide(
                color: theme.componentsTokens.button.colorBorderStrongLoadingMono, width: theme.componentsTokens.button.borderWidthDefaultInteraction)
            : BorderSide.none;
      case OudsButtonHierarchy.Minimal:
        return OudsTheme.onColoredSurfaceGlobal
            ? BorderSide(
                color: theme.componentsTokens.button.colorBorderMinimalLoadingMono,
                width: theme.componentsTokens.button.borderWidthMinimalInteraction)
            : BorderSide(
                color: theme.componentsTokens.button.colorBorderMinimalLoading, width: theme.componentsTokens.button.borderWidthMinimalInteraction);
      case OudsButtonHierarchy.Negative:
        return BorderSide.none;
      default:
        return OudsTheme.onColoredSurfaceGlobal
            ? BorderSide(
                color: theme.componentsTokens.button.colorBorderDefaultLoadingMono,
                width: theme.componentsTokens.button.borderWidthDefaultInteraction)
            : BorderSide(
                color: theme.componentsTokens.button.colorBorderDefaultLoading, width: theme.componentsTokens.button.borderWidthDefaultInteraction);
    }
  }

  static EdgeInsets getPaddingLoading(BuildContext context, OudsButtonLayout layout) {
    final theme = OudsTheme.of(context);
    switch (layout) {
      case OudsButtonLayout.IconOnly:
        return EdgeInsets.zero;
      case OudsButtonLayout.IconAndText:
        return EdgeInsets.only(
          top: theme.componentsTokens.button.spacePaddingBlock,
          right: theme.componentsTokens.button.spacePaddingInlineIconNone,
          bottom: theme.componentsTokens.button.spacePaddingBlock,
          left: theme.componentsTokens.button.spacePaddingInlineIconNone,
        );
      case OudsButtonLayout.TextOnly:
        return EdgeInsets.only(
          top: theme.componentsTokens.button.spacePaddingBlock,
          right: theme.componentsTokens.button.spacePaddingInlineIconNone,
          bottom: theme.componentsTokens.button.spacePaddingBlock,
          left: theme.componentsTokens.button.spacePaddingInlineIconNone,
        );
    }
  }
}
