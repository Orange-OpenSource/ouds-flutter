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
///@nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/card/internal/ouds_card_style.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Handles card surface colors.
class OudsCardModifier {
  final BuildContext context;

  OudsCardModifier(this.context);

  /// Returns border and overlay colors in interaction-state priority order.
  ({Color? borderColor, Color? overlayColor}) getInteractionColors({
    required OudsCardStyle style,
    required bool enabled,
    required bool loading,
    required bool pressed,
    required bool focused,
    required bool hovered,
    required bool backgroundColor,
  }) {
    final colors = OudsTheme.of(context).colorScheme(context);
    if (style == OudsCardStyle.outlined) {
      return (
        borderColor: !enabled
            ? colors.actionDisabled
            : loading
            ? colors.actionLoading
            : pressed
            ? colors.actionPressed
            : focused
            ? colors.actionFocus
            : hovered
            ? colors.actionHover
            : colors.borderDefault,
        overlayColor: null,
      );
    }
    return (
      borderColor: null,
      overlayColor: !enabled
          ? colors.actionSupportDisabled
          : loading
          ? colors.actionSupportLoading
          : pressed
          ? colors.actionSupportPressed
          : focused
          ? colors.actionSupportFocus
          : hovered
          ? colors.actionSupportHover
          : backgroundColor
          ? colors.actionSupportEnabled
          : null,
    );
  }

  /// Returns the background color based on the card.
  Color getBackgroundColor(OudsCardStyle style) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);
    if (style == OudsCardStyle.elevated) {
      return colorTheme.surfacePrimary;
    }
    return Colors.transparent;
  }

  /// Static method to get the border radius for an action card in focus state based on the border parameter.
  /// Returns a [BorderRadius] object with the appropriate radius value.
  static BorderRadius getBorderRadiusFocus(BuildContext context) {
    //todo will changed with the tokens of card when available 2.8
    final button = OudsTheme.of(context).componentsTokens(context).button;
    final buttonRounded =
        OudsThemeConfigModel.of(context)?.card?.rounded ?? false;
    switch (buttonRounded) {
      case true:
        return BorderRadius.circular(
          button.borderRadiusRounded +
              (OudsTheme.of(context).borderTokens.widthFocus / 1.2),
        );
      case false:
        return BorderRadius.circular(button.borderRadiusDefault);
    }
  }
}
