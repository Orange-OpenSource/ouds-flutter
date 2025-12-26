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

import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/navigation_bars/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_core/components/navigation_bars/top_appbar/internal/ouds_topappbar_navigation_icon_modifier.dart';

class OudsTopAppBarLeadingModifier {

  OudsTopAppBarLeadingModifier();


  Widget? getLeadingWidget(
      BuildContext context,
      OudsTopAppBarNavigationLeadingIcon? navigationIcon,
      String? customLeadingIcon,
      VoidCallback? onLeadingPressed
      ){
    final topAppBarNavigationIconModifier = OudsTopAppBarNavigationIconModifier();
    if(navigationIcon != OudsTopAppBarNavigationLeadingIcon.none) {
      return OudsButton(
        appearance: OudsButtonAppearance.minimal,
        icon: topAppBarNavigationIconModifier.getNavigationIcon(navigationIcon,customLeadingIcon),
        package: navigationIcon == OudsTopAppBarNavigationLeadingIcon.custom ? null : OudsTheme.of(context).packageName,
        onPressed: () => onLeadingPressed,
      );
    }else {
      return null;
    }

  }

}