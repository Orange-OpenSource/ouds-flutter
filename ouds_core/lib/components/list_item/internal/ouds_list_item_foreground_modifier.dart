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
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Resolves foreground (text / icon) colors for [OudsListItem] based on its
/// current [OudsListItemControlState].
///
/// Two color roles are exposed:
/// - [contentColor] — used for the primary label, extra label and overline.
/// - [mutedColor]   — used for secondary text (overline, description).
///
/// When the item is [OudsListItemControlState.disabled], **both** roles return
/// `contentDisabled` so every piece of content appears uniformly dimmed.
class OudsListItemForegroundModifier {
  OudsListItemForegroundModifier(this.context);

  final BuildContext context;

  /// Primary foreground color (label, extra label).
  /// Returns [contentDisabled] when the item is disabled.
  Color contentColor(bool enable) {
    final colorScheme = OudsTheme.of(context).colorScheme(context);
    return enable ? colorScheme.contentDefault : colorScheme.contentDisabled;
  }

  /// Muted foreground color (overline, description).
  /// Returns [contentDisabled] when the item is disabled.
  Color mutedColor(bool enable) {
    final colorScheme = OudsTheme.of(context).colorScheme(context);
    return enable ? colorScheme.contentMuted : colorScheme.contentDisabled;
  }
}
