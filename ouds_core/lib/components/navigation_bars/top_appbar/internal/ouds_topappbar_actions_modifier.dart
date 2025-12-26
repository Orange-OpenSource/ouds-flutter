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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/navigation_bars/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';

class OudsTopAppBarActionsModifier {

  OudsTopAppBarActionsModifier();

  /// Retrieves the widgets icon or avatar for the top_appbar based on the provided [OudsTopAppBarActionType] enum.
  List<Widget>? getTrailingActionList(
      BuildContext context,
      List<OudsTopAppBarActionConfig>? actionsList,
      String? avatarIcon,
      String? monogramText,
      bool showAvatar) {
    if (actionsList == null) return null;

    final theme = OudsTheme.of(context);

    if(Platform.isIOS) {
      return [
        OudsButton(
          appearance: OudsButtonAppearance.minimal,
          icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
          package: theme.packageName,
          iconColor: theme.colorScheme(context).actionSelected, // todo ouds/💠_navigation/bar/color/ios-accent
          onPressed: () {
            actionsList.first.onActionPressed;
          },
        )
      ];
    }

    List<Widget> actionWidgets =  actionsList.map((action) {
      switch (action.type) {
        case OudsTopAppBarActionType.icon:
          return OudsButton(
            appearance: OudsButtonAppearance.minimal,
            icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
            package: theme.packageName,
            badge: action.badge? _buildOudsBadge(action) : null,
            onPressed: (){
              action.onActionPressed;
            },
          );
        case OudsTopAppBarActionType.avatar:
          return SizedBox.shrink();
        }
    }).toList();

    bool isMonogram = monogramText != null && monogramText.isNotEmpty;
    //add a widget to force avatar at the end of list
    return [
      ...actionWidgets,
      showAvatar ? Padding(
        padding: EdgeInsetsDirectional.all(OudsTheme.of(context).componentsTokens(context).button.spaceInsetIconOnly),
        child: InkWell(
          onTap: () {},
          child: CircleAvatar(
            radius: 13,
            backgroundImage:  !isMonogram && avatarIcon != null? AssetImage(avatarIcon) : null,
          backgroundColor: isMonogram ? theme.colorScheme(context).surfaceInverseHigh : null,
          child: isMonogram ? Text(monogramText[0].toUpperCase(),
          style:  TextStyle(
            color: theme.colorScheme(context).contentInverse,
            fontFamily: theme.fontFamily,
          ),
            ) : null,
          ),
        ),
      ) : SizedBox.shrink(),
    ];
  }

  OudsBadge _buildOudsBadge(OudsTopAppBarActionConfig actionConfig){

    return OudsBadge(
      status: OudsBadgeStatus.negative,
      size: actionConfig.standard ? OudsBadgeSize.xsmall : OudsBadgeSize.medium,
      label: actionConfig.standard? null : actionConfig.count
    );
  }
}
