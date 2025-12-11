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
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsNavigationBarStatusModifier {
  final BuildContext context;

  OudsNavigationBarStatusModifier(this.context);

  /// Returns the text a nd icon color based on the link status.
  Color getTextItemColor(OudsNavigationBarControlState state, [bool isSelected = false]) {
    final barTheme = OudsTheme.of(context).componentsTokens(context).bar;

    switch (state) {
      case OudsNavigationBarControlState.enabled:
        return isSelected ? barTheme.colorContentSelectedEnabled : barTheme.colorContentUnselectedEnabledLight;
      case OudsNavigationBarControlState.hovered:
        return isSelected ? barTheme.colorContentSelectedHover : barTheme.colorContentUnselectedHover;
      case OudsNavigationBarControlState.focused:
        return isSelected ? barTheme.colorContentSelectedFocus : barTheme.colorContentUnselectedFocus;
      case OudsNavigationBarControlState.pressed:
        return isSelected ? barTheme.colorContentSelectedPressed : barTheme.colorContentUnselectedPressed;
    }
  }
}
