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
import 'package:ouds_core/components/card/ouds_card_style.dart';
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
          : null,
    );
  }

  /// Returns the background color based on the alert message status.
  Color getBackgroundColor(
    OudsCardStyle style,
    bool backgroundColor,
    bool enabled,
  ) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);
    if (style != OudsCardStyle.outlined && !backgroundColor && enabled) {
      return Colors.transparent;
    }
    switch (style) {
      case OudsCardStyle.filled:
      case OudsCardStyle.elevated:
        return enabled
            ? colorTheme.actionSupportEnabled
            : colorTheme.actionSupportDisabled;
      case OudsCardStyle.outlined:
        return enabled ? Colors.transparent : colorTheme.actionDisabled;
    }
  }
}
