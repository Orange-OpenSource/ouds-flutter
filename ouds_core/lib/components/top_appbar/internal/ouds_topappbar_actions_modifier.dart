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
import 'package:ouds_core/components/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/avatar/ouds_avatar.dart';

class OudsTopAppBarActionsModifier {

  OudsTopAppBarActionsModifier();

  /// Retrieves the widgets icon or avatar for the top_appbar based on the provided [OudsTopAppBarActionType] enum.
  List<Widget>? getTrailingActionList(
      BuildContext context,
      List<OudsTopAppBarActionConfig>? actionsList,
      bool showAvatar) {
    if (actionsList == null) return null;

    final theme = OudsTheme.of(context);
    String? monogramText;
    String? avatarIcon;
    Color? monogramColor;
    Color? monogramBackgroundColor;
    String? avatarSemanticLabel;

    List<Widget> actionWidgets =  actionsList.map((action) {
      switch (action.type) {
        case OudsTopAppBarActionType.icon:
          return OudsButton(
            appearance: OudsButtonAppearance.minimal,
            icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
            package: theme.packageName,
            badge: action.badge? _buildOudsBadge(action) : null,
            semanticLabel: action.semanticLabel,
            onPressed: (){
              action.onActionPressed;
            },
          );
        case OudsTopAppBarActionType.avatar :{
          monogramText = action.avatarConfig?.monogramText;
          avatarIcon = action.avatarConfig?.avatarIcon;
          monogramBackgroundColor = action.avatarConfig?.monogramBackgroundColor;
          monogramColor = action.avatarConfig?.monogramColor;
          avatarSemanticLabel = action.semanticLabel;
          return SizedBox.shrink();
        }
        }
    }).toList();

    //add a widget to force avatar at the end of list
    return [
      ...actionWidgets,
      showAvatar ? Padding(
        padding: EdgeInsetsDirectional.all(OudsTheme.of(context).componentsTokens(context).button.spaceInsetIconOnly),
        child: Semantics(
          label: avatarSemanticLabel,
          button: true,
          child:  OudsAvatar(
              image: avatarIcon,
              monogramBackgroundColor: monogramBackgroundColor ?? theme.colorScheme(context).surfaceInverseHigh,
              monogram: monogramText,
              monogramColor: monogramColor ?? theme.colorScheme(context).contentOnActionEnabled,
          ),
        ),
      ) : SizedBox.shrink(),
    ];
  }

  OudsBadge _buildOudsBadge(OudsTopAppBarActionConfig actionConfig){

    return OudsBadge(
      status: OudsBadgeStatus.negative,
      size: actionConfig.standard ? OudsBadgeSize.xsmall : OudsBadgeSize.medium,
      label: actionConfig.standard? null : actionConfig.count,
      semanticsLabel: actionConfig.count != null
          ? "${actionConfig.count} ${actionConfig.badgeSemanticLabel}"
          : actionConfig.badgeSemanticLabel,
    );
  }
}
