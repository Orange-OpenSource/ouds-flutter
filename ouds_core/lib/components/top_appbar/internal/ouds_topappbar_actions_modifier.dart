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
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_core/components/avatar/ouds_avatar.dart';

class OudsTopAppBarActionsModifier {

  /// Retrieves the widgets icon or avatar for the top_appbar based on the provided [OudsTopAppBarActionType] enum.
  List<Widget>? getTrailingActionList(
      BuildContext context,
      List<OudsTopAppBarActionConfig>? actionsList) {
    if (actionsList == null) return null;

    final theme = OudsTheme.of(context);
    String? monogramText;
    String? image;
    Color? monogramColor;
    Color? monogramBackgroundColor;
    String? contentDescription;
    OudsTopAppBarActionType? actionType;

    List<Widget> actionWidgets =  actionsList.map((action) {
      final iconButtonWithBadge =
      MergeSemantics(
        child: Semantics(
          label: action.contentDescription,
          child: BadgeIconButton(
            icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
            badge: action.badge,
            onPressed: () {
              action.onActionPressed?.call();
            },
          ),
        ),
      );

      switch (action.type) {
        case OudsTopAppBarActionType.icon:
          return iconButtonWithBadge;
        case OudsTopAppBarActionType.avatar :{
          monogramText = action.avatarConfig?.monogram;
          image = action.avatarConfig?.image;
          monogramBackgroundColor = action.avatarConfig?.monogramBackgroundColor;
          monogramColor = action.avatarConfig?.monogramColor;
          actionType = action.type;
          contentDescription = action.contentDescription;
          return SizedBox.shrink();
        }
        case OudsTopAppBarActionType.widget:
          return action.widget!;
        }
    }).toList();

    //add a widget to force avatar at the end of list
    return [
      ...actionWidgets,
      actionType == OudsTopAppBarActionType.avatar ? Padding(
        padding: EdgeInsetsDirectional.all(OudsTheme.of(context).componentsTokens(context).button.spaceInsetIconOnly),
        child: Semantics(
          label: contentDescription,
          button: true,
          child:  OudsAvatar(
              image: image,
              monogramBackgroundColor: monogramBackgroundColor ?? theme.colorScheme(context).surfaceInverseHigh,
              monogram: monogramText,
              monogramColor: monogramColor ?? theme.colorScheme(context).contentOnActionEnabled,
          ),
        ),
      ) : SizedBox.shrink(),
    ];
  }

}
