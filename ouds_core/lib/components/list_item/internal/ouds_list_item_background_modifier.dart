/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:flutter/material.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the background color for [OudsListItem] based on its state.
class OudsListItemBackgroundModifier {
  final BuildContext context;

  OudsListItemBackgroundModifier(this.context);

  /// Gets the background color based on the list item control state.
  Color? getBackgroundColor(OudsListItemControlState state, bool background) {
    final colorScheme = OudsTheme.of(context).colorScheme(context);

    return switch (state) {
      OudsListItemControlState.enabled => background
          ? colorScheme.actionSupportEnabled
          : Colors.transparent,
      OudsListItemControlState.disabled => background
          ? colorScheme.actionSupportDisabled
          : Colors.transparent,
      OudsListItemControlState.hovered => background
          ? colorScheme.actionSupportHover
          : Colors.transparent,
      OudsListItemControlState.pressed => background
          ? colorScheme.actionSupportPressed
          : Colors.transparent,
      OudsListItemControlState.focused => background
          ? colorScheme.actionSupportFocus
          : Colors.transparent,
    };
  }
}
