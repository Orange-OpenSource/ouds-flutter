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
      List<OudsTopAppBarActionConfig>? actionsList,
      bool showAvatar) {
    if (actionsList == null) return null;
    final theme = OudsTheme.of(context);
    // Temporary holders used to build the avatar action
    // The avatar is rendered at the end of the trailing actions list
    VoidCallback? onAvatarPressed;
    OudsTopAppBarAvatarConfig? avatarConfig;

    // Map each action configuration to its corresponding widget
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
        case OudsTopAppBarActionType.avatar :
        {
          // Store avatar configuration to render it later
          // This ensures the avatar is always positioned at the end
          avatarConfig = action.avatarConfig;
          onAvatarPressed = action.onActionPressed;
          // Return an empty widget for now
          return SizedBox.shrink();
        }
        case OudsTopAppBarActionType.widget:
          return action.widget!;
        }
    }).toList();

    // Append the avatar widget at the end of the list if present
    return [
      ...actionWidgets,
      showAvatar ? Padding(
        padding: EdgeInsetsDirectional.all(OudsTheme.of(context).componentsTokens(context).button.spaceInsetIconOnly),
        child: Semantics(
          label: avatarConfig?.contentDescription,
          button: true,
          child:  OudsAvatar(
              image: avatarConfig?.image,
              monogramBackgroundColor: avatarConfig?.monogramBackgroundColor ?? theme.colorScheme(context).surfaceInverseHigh,
              monogram: avatarConfig?.monogram,
              monogramColor: avatarConfig?.monogramColor,
            onClick:  onAvatarPressed,
          ),
        ),
      ) : SizedBox.shrink(),
    ];
  }

}
