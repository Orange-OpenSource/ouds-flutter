/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 *
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 *
 * // Software description: Flutter library of reusable graphical components
 *
 */

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Resolves the background color for [OudsListItem] from its state and
/// [OudsListItemDecoration].
class OudsListItemBackgroundModifier {
  final BuildContext context;

  OudsListItemBackgroundModifier(this.context);

  /// Resolves the background color from [state] and [decoration].
  Color getBackgroundColor(
    OudsListItemControlState state,
    OudsListItemDecoration decoration,
  ) {
    final colorScheme = OudsTheme.of(context).colorScheme(context);

    final isBackground = decoration is OudsListItemDecorationBackground;
    final showsInteractionBackground =
        decoration is OudsListItemDecorationBackgroundOnInteraction ||
        decoration is OudsListItemDecorationOutlined ||
        decoration is OudsListItemDecorationOutlinedOnInteraction;
    final hasBackground = isBackground || showsInteractionBackground;

    if (!hasBackground) return Colors.transparent;

    return switch (state) {
      // Persistent background uses the same base fill for enabled and disabled.
      OudsListItemControlState.enabled || OudsListItemControlState.disabled =>
        isBackground ? colorScheme.actionSupportEnabled : Colors.transparent,
      OudsListItemControlState.hovered => colorScheme.actionSupportHover,
      OudsListItemControlState.pressed => colorScheme.actionSupportPressed,
      OudsListItemControlState.focused => colorScheme.actionSupportFocus,
    };
  }
}
