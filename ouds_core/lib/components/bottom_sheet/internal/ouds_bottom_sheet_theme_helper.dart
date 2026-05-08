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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Builds a [BottomSheetThemeData] from OUDS tokens so both modal and
/// persistent bottom sheets share the same visual configuration.
/// @nodoc
class OudsBottomSheetThemeHelper {
  OudsBottomSheetThemeHelper._();

  /// Creates a [BottomSheetThemeData] applying all OUDS design tokens.
  static BottomSheetThemeData buildThemeData(BuildContext context) {
    final theme = OudsTheme.of(context);
    final colorScheme = theme.colorScheme(context);
    final spaceScheme = theme.spaceScheme(context);

    return BottomSheetThemeData(
      backgroundColor: colorScheme.overlayModal,
      modalBackgroundColor: colorScheme.overlayModal,
      surfaceTintColor: Colors.transparent,
      modalBarrierColor: colorScheme.alwaysBlack.withAlpha(
        (0.64 * 255).round(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(spaceScheme.scaledExtraLarge),
        ),
      ),
      shadowColor: colorScheme.alwaysBlack,
      elevation: theme.elevationTokens.emphasized,
      modalElevation: theme.elevationTokens.emphasized,
      clipBehavior: Clip.antiAlias,
    );
  }
}
