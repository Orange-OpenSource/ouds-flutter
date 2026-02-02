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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsNavigationBarBorderModifier {
  final BuildContext context;

  OudsNavigationBarBorderModifier(this.context);

  /// Returns the top border applied to the navigation bar (color/width derived from theme border tokens).
  Border getBorderNavigationBar() {
    final theme = OudsTheme.of(context);
    return Border(
      top: BorderSide(
        color: theme.colorScheme(context).borderMinimal,
        width: 1,
      ),
    );
  }

  /// Returns an [ImageFilter] blur applied behind the navigation bar (sigma values derived from bar tokens).
  ImageFilter getBlurNavigationBar() {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    return ImageFilter.blur(
      sigmaX: barTheme.effectBgBlur.toDouble(),
      sigmaY: barTheme.effectBgBlur.toDouble(),
    );
  }
}
