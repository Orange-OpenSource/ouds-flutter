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
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/utilities/theme_utils.dart';

class OudsNavigationBarStatusModifier {
  final BuildContext context;

  OudsNavigationBarStatusModifier(this.context);

  /// Returns the content color (icon and label) for a navigation destination,
  /// based on its interaction [state] and whether it is [isSelected].
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

  /// Returns the Material 3 "active indicator" and/or overlay color for a navigation destination,
  /// based on its interaction [state] and whether it is [isSelected].
  ///
  /// Note: in Material 3, `indicatorColor` paints the selected indicator behind the destination,
  /// while `overlayColor` is the transient pressed/hovered/focused overlay shown during interactions.
  Color getMaterialIndicatorBarColor(OudsNavigationBarControlState state, [bool isSelected = false]) {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;
    final oudsTheme = OudsTheme.of(context);
    switch (state) {
      case OudsNavigationBarControlState.enabled:
        return isSelected ? barTheme.colorActiveIndicatorAndroidSelectedEnabled : oudsTheme.colorScheme(context).opacityTransparent;
      case OudsNavigationBarControlState.hovered:
        return isSelected ? barTheme.colorActiveIndicatorAndroidSelectedHover : barTheme.colorActiveIndicatorAndroidUnselectedHover;
      case OudsNavigationBarControlState.focused:
        return isSelected ? barTheme.colorActiveIndicatorAndroidSelectedFocus : barTheme.colorActiveIndicatorAndroidUnselectedFocus;
      case OudsNavigationBarControlState.pressed:
        return isSelected ? barTheme.colorActiveIndicatorAndroidSelectedPressed : barTheme.colorActiveIndicatorAndroidUnselectedPressed;
    }
  }

  /// Returns the custom top indicator color (the small bar shown above the icon when selected),
  /// derived from the destination interaction [state].
  Color getIndicatorBarColor(OudsNavigationBarControlState state) {
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
