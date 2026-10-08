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
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Modifier class that resolves the color of an [OudsListItem] navigation
/// indicator (chevron next, chevron previous, external link icon) based on
/// the item's current [OudsListItemControlState].
///
/// When [OudsListItemControlState.disabled] the indicator color is set to
/// `actionDisabled` so it appears uniformly dimmed, consistent with the
/// leading and trailing slot behaviour.
///
/// Example usage:
/// ```dart
/// final color = OudsListItemIndicatorModifier(context)
///     .indicatorColor(listItemState);
/// ```
class OudsListItemIndicatorModifier {
  OudsListItemIndicatorModifier(this.context);

  final BuildContext context;

  /// Resolves the indicator color for the given [state].
  ///
  /// - [OudsListItemControlState.enabled]  → `colorChevronEnabled` from link tokens
  /// - [OudsListItemControlState.hovered]  → `actionHover` from color scheme
  /// - [OudsListItemControlState.pressed]  → `actionPressed` from color scheme
  /// - [OudsListItemControlState.focused]  → `actionFocus` from color scheme
  /// - [OudsListItemControlState.disabled] → `actionDisabled` from color scheme
  Color indicatorColor(OudsListItemControlState state) {
    final colorScheme = OudsTheme.of(context).colorScheme(context);
    final linkTokens = OudsTheme.of(context).componentsTokens(context).link;
    return switch (state) {
      OudsListItemControlState.enabled => linkTokens.colorChevronEnabled,
      OudsListItemControlState.hovered => colorScheme.actionHover,
      OudsListItemControlState.pressed => colorScheme.actionPressed,
      OudsListItemControlState.focused => colorScheme.actionFocus,
      OudsListItemControlState.disabled => colorScheme.actionDisabled,
    };
  }
}
