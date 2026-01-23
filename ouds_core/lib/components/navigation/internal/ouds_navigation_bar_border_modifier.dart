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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsNavigationBarBorderModifier {
  final BuildContext context;

  OudsNavigationBarBorderModifier(this.context);

  /// Returns a Border applied to the top edge of the navigation bar.
  /// The BorderSide's color and width are derived from the current theme's border tokens.
  Border getBorderNavigationBar() {
    final theme = OudsTheme.of(context);
    return Border(
      top: BorderSide(
        color: theme.colorScheme(context).borderMinimal,
        width: theme.borderTokens.widthDefault,
      ),
    );
  }

  /// Returns an ImageFilter that applies a background blur for the navigation bar.
  ImageFilter getBlurNavigationBar() {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    return ImageFilter.blur(
      sigmaX: barTheme.effectBgBlur.toDouble(),
      sigmaY: barTheme.effectBgBlur.toDouble(),
    );
  }
}
