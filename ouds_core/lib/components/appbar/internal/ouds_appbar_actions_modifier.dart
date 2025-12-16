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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/appbar/ouds_appbar.dart';

class OudsAppBarActionsModifier {

  OudsAppBarActionsModifier();

  /// Retrieves the widgets icon or avatar for the appbar based on the provided [OudsAppBarAction] enum.
// Utilisation
  List<Widget>? getTrailingActionList(BuildContext context, List<OudsAppBarAction>? actionsList, String? avatarIcon) {
    if (actionsList == null) return null;

    return actionsList.map((action) {
      switch (action) {
        case OudsAppBarAction.icon:
          return OudsButton(
            appearance: OudsButtonAppearance.minimal,
            icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
            package: OudsTheme.of(context).packageName,
            onPressed: (){},
          );
        case OudsAppBarAction.avatar:
          return InkWell(
            onTap: () {},
            child: CircleAvatar(
              //radius: 40,
              child: SvgPicture.asset(
                excludeFromSemantics: true,
                avatarIcon ?? "",
                fit: BoxFit.contain,
              ),
            ),
          );
        }
    }).toList();
  }

}
