// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components

import 'package:flutter/material.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the background color for [OudsListItem] based on its
/// state and [OudsListItemDecoration].
///
/// Behavior aligned with the Android implementation:
/// - [OudsListItemDecorationBackground]: persistent background in all states.
///   Enabled and Disabled share the same `actionSupportEnabled` background.
/// - [OudsListItemDecorationBackgroundOnInteraction]: background only on
///   hover / press / focus. Transparent when enabled or disabled.
/// - All other decorations: transparent background.
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
    final hasBackground =
        isBackground ||
        decoration is OudsListItemDecorationBackgroundOnInteraction;

    if (!hasBackground) return Colors.transparent;

    return switch (state) {
      // Both Enabled and Disabled use actionSupportEnabled when background is
      // persistent (matches Android behaviour).
      OudsListItemControlState.enabled || OudsListItemControlState.disabled =>
        isBackground ? colorScheme.actionSupportEnabled : Colors.transparent,
      OudsListItemControlState.hovered => colorScheme.actionSupportHover,
      OudsListItemControlState.pressed => colorScheme.actionSupportPressed,
      OudsListItemControlState.focused => colorScheme.actionSupportFocus,
    };
  }
}
