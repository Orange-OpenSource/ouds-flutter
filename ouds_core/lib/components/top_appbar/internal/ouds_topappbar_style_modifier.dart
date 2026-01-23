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

/// @nodoc
library;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/utilities/theme_utils.dart';

/// Used to apply the right style(background, border, blur) associated to the theme mode
class OudsStyleModifier {

  final BuildContext context;

  OudsStyleModifier(this.context);

  /// Returns the background color of the navigation bar depending on translucency and theme.
  Color getBackgroundColor(bool isTranslucent) {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    final isDark = ThemeUtils.isDarkTheme(context);
    if (isTranslucent) {
      return isDark ? barTheme.colorBgTranslucentDark.withValues(alpha: 0.5)
          : barTheme.colorBgTranslucentLight.withValues(alpha: 0.5);
    } else {
      return barTheme.colorBgOpaque.withValues(alpha: 0.5);
    }
  }

  /// Returns a Border applied to the bottom of the top app bar.
  /// The BorderSide's color and width are derived from the current theme's border tokens.
  Border getBorder() {
    final theme = OudsTheme.of(context);
    return Border(
      bottom: BorderSide(
        color: theme.colorScheme(context).borderMinimal,
        width: 1,
      ),
    );
  }

  /// Returns an ImageFilter that applies a background blur for the top app bar.
  ImageFilter getBlurEffect() {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    return ImageFilter.blur(
      sigmaX: barTheme.effectBgBlur.toDouble(),
      sigmaY: barTheme.effectBgBlur.toDouble(),
    );
  }

}