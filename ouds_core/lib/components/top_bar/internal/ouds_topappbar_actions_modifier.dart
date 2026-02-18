
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
import 'package:ouds_core/components/top_bar/internal/ouds_topappbar_navigation_icon_modifier.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/avatar/ouds_avatar.dart';
import 'package:ouds_core/components/button/ouds_button.dart';

class OudsTopAppBarActionsModifier {

  /// Retrieves the widgets icon or avatar for the bar_top based on the provided [OudsTopBarActionConfig] configuration.
  List<Widget>? getTrailingActionList(
      BuildContext context,
      List<OudsTopBarActionConfig>? actionsList,
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
        case OudsTopBarActionType.icon:
          return iconButtonWithBadge;
        case OudsTopBarActionType.avatar :{
          // Store avatar configuration to render it later
          // This ensures the avatar is always positioned at the end
          avatarConfig = action.avatarConfig;
          onAvatarPressed = action.onActionPressed;
          // Return an empty widget for now
          return SizedBox.shrink();
        }
        case OudsTopBarActionType.widget:
          return action.widget!;
        case OudsTopBarActionType.none:
          throw UnimplementedError('OudsBarTop for android does not support none type trailing action');
        case OudsTopBarActionType.back:
          throw UnimplementedError('OudsBarTop for android does not support back type trailing action');
        case OudsTopBarActionType.text:
          throw UnimplementedError('OudsBarTop for android does not support text type trailing action');
        case OudsTopBarActionType.custom:
          throw UnimplementedError('OudsBarTop for android does not support custom type trailing action');
        case OudsTopBarActionType.close:
          throw UnimplementedError('OudsBarTop for android does not support close type trailing action');
        case OudsTopBarActionType.menu:
          throw UnimplementedError('OudsBarTop for android does not support menu type trailing action');
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
            monogramColor: avatarConfig?.monogramColor ?? theme.colorScheme(context).contentOnActionEnabled,
            onClick: onAvatarPressed,
          ),
        ),
      ) : SizedBox.shrink(),
    ];
  }

  /// Retrieves the leading icon for the bar_top based on the provided [OudsTopBarActionType] enum.
  Widget? getLeadingIconButton(
      BuildContext context,
      OudsTopBarActionConfig? action
      ) {
    if (action != null) {
      final topAppBarNavigationIconModifier = OudsTopAppBarNavigationIconModifier();
      if (action.type != OudsTopBarActionType.none) {
        return Center(
          child: action.type == OudsTopBarActionType.custom
              ? OudsButton(
            appearance: OudsButtonAppearance.minimal,
            icon: topAppBarNavigationIconModifier.getNavigationIcon(
                action.type, action.customLeadingIcon),
            package: action.type == OudsTopBarActionType.custom
                ? null
                : OudsTheme
                .of(context)
                .packageName,
            onPressed: () {
              action.onActionPressed?.call();
            },
          ) : Semantics(
            label: topAppBarNavigationIconModifier.getNavigationIconLabel(
                context, action.type, action.contentDescription),
            button: true,
            child: ExcludeSemantics(
              child: OudsButton(
                appearance: OudsButtonAppearance.minimal,
                icon: topAppBarNavigationIconModifier.getNavigationIcon(
                    action.type, action.customLeadingIcon),
                package: action.type == OudsTopBarActionType.custom
                    ? null
                    : OudsTheme
                    .of(context)
                    .packageName,
                onPressed: () {
                  action.onActionPressed?.call();
                },
              ),
            ),
          ),
        );
      } else {
        return null;
      }
    }else {
      return null;
    }
  }
}
