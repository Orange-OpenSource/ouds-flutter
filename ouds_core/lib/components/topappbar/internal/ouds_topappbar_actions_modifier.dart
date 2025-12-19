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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/topappbar/ouds_topappbar.dart';

class OudsTopAppBarActionsModifier {

  OudsTopAppBarActionsModifier();

  /// Retrieves the widgets icon or avatar for the topappbar based on the provided [OudsTopAppBarAction] enum.
  List<Widget>? getTrailingActionList(BuildContext context, List<OudsTopAppBarAction>? actionsList, String? avatarIcon) {
    if (actionsList == null) return null;

    // limited at 3 actions
    final limitedActions = actionsList.take(3);

    List<Widget> actionWidgets =  limitedActions.map((action) {
      switch (action) {
        case OudsTopAppBarAction.icon:
          return OudsButton(
            appearance: OudsButtonAppearance.minimal,
            icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
            package: OudsTheme.of(context).packageName,
            onPressed: (){},
          );
        case OudsTopAppBarAction.avatar:
          return SizedBox.shrink();
        }
    }).toList();
    //add a widget to force avatar at the end of list
    return [
      ...actionWidgets,
      Padding(
        padding: EdgeInsetsDirectional.all(OudsTheme.of(context).componentsTokens(context).button.spaceInsetIconOnly),
        child: InkWell(
          onTap: () {},
          child: CircleAvatar(
            radius: 13,
            backgroundImage: avatarIcon != null ? AssetImage(avatarIcon) : null,
          ),
        ),
      ),
    ];
  }

}
