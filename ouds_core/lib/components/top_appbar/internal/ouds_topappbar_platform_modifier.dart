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

import '../../button/ouds_button.dart';
import '../ouds_topappbar.dart';
import 'ouds_topappbar_navigation_icon_modifier.dart';

class OudsTopAppBarWidgetsPlatformModifier {

  OudsTopAppBarWidgetsPlatformModifier();

  Widget getTitleWidget(BuildContext context, String? title){

   return Text(
        title ?? "",
        maxLines: 1,
        style: TextStyle(
          color: OudsTheme.of(context).colorScheme(context).contentDefault,
          overflow: TextOverflow.ellipsis,
          fontFamily: OudsTheme.of(context).fontFamily,
        )
    );
  }

  Widget? getLeadingWidget(
      BuildContext context,
      OudsTopAppBarNavigationIcon? navigationIcon,
      String? customLeadingIcon,
      VoidCallback? onLeadingPressed
      ){
    final topAppBarNavigationIconModifier = OudsTopAppBarNavigationIconModifier();
    if(navigationIcon != OudsTopAppBarNavigationIcon.none) {
      return OudsButton(
        appearance: OudsButtonAppearance.minimal,
        icon: topAppBarNavigationIconModifier.getNavigationIcon(navigationIcon,customLeadingIcon),
        package: navigationIcon == OudsTopAppBarNavigationIcon.custom ? null : OudsTheme.of(context).packageName,
        onPressed: () => onLeadingPressed,
      );
    }else {
      return null;
    }

  }

}