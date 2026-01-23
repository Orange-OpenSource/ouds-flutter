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
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/utilities/theme_utils.dart';

class OudsNavigationBarStatusModifier {
  final BuildContext context;

  OudsNavigationBarStatusModifier(this.context);

  /// Returns the background color of the navigation bar depending on translucency and theme.
  Color getBackgroundColor(bool isTranslucent) {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    final isDark = ThemeUtils.isDarkTheme(context);
    if (isTranslucent) {
      return isDark ? barTheme.colorBgTranslucentDark.withValues(alpha: 0.5) : barTheme.colorBgTranslucentLight.withValues(alpha: 0.5);
    } else {
      return barTheme.colorBgOpaque.withValues(alpha: 0.5);
    }
  }

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

  /// Returns the text color of a navigation item based on its state and selection.
  Color getTextIconItemColor(OudsNavigationBarControlState state, [bool isSelected = false]) {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    switch (state) {
      case OudsNavigationBarControlState.enabled:
        return isSelected
            ? barTheme.colorContentSelectedEnabled
            : ThemeUtils.isDarkTheme(context) == false
                ? barTheme.colorContentUnselectedEnabledLight
                : barTheme.colorContentUnselectedEnabledDark;
      case OudsNavigationBarControlState.hovered:
        return isSelected ? barTheme.colorContentSelectedHover : barTheme.colorContentUnselectedHover;
      case OudsNavigationBarControlState.focused:
        return isSelected ? barTheme.colorContentSelectedFocus : barTheme.colorContentUnselectedFocus;
      case OudsNavigationBarControlState.pressed:
        return isSelected ? barTheme.colorContentSelectedPressed : barTheme.colorContentUnselectedPressed;
    }
  }

  /// Returns the color of the top indicator bar for a navigation item based on state.
  Color getIndicatorBarColor(OudsNavigationBarControlState state, [bool isSelected = false]) {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    switch (state) {
      case OudsNavigationBarControlState.enabled:
        return barTheme.colorActiveIndicatorCustomSelectedEnabled.withValues(alpha: barTheme.opacityActiveIndicatorCustom);
      case OudsNavigationBarControlState.hovered:
        return barTheme.colorActiveIndicatorCustomSelectedHover.withValues(alpha: barTheme.opacityActiveIndicatorCustom);
      case OudsNavigationBarControlState.focused:
        return barTheme.colorActiveIndicatorCustomSelectedFocus.withValues(alpha: barTheme.opacityActiveIndicatorCustom);
      case OudsNavigationBarControlState.pressed:
        return barTheme.colorActiveIndicatorCustomSelectedPressed.withValues(alpha: barTheme.opacityActiveIndicatorCustom);
    }
  }
}
