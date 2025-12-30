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
import 'package:flutter/material.dart';
import 'package:ouds_core/components/utilities/ouds_devices_utils.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/navigation_bars/cupertino_navigation_bar/ouds_cupertino_navigation_bar.dart';
import 'package:ouds_core/components/navigation_bars/cupertino_navigation_bar/internal/ouds_action_widget.dart';

class OudsCupertinoNavigationBarActionModifier {

  OudsCupertinoNavigationBarActionModifier();

  Widget? getActionsWidget(BuildContext context, bool isLeadingAction,
      List<OudsCupertinoNavigationBarActionConfig>? actionsConfig) {

    if (actionsConfig == null || actionsConfig.isEmpty) return null;

    // Set maximum actions based on device type
    int maxActions =  OudsDevicesUtils().getOSDeviceType(context) == OudsDeviceType.iPad
        ? 6 : 3;

   // If an action of type 'back' is present, limit to 1
    bool hasBackAction = actionsConfig.any((action) => action.actionType == OudsCupertinoNavigationBarActionType.back);
    if (hasBackAction) {
      maxActions = 1;
    }

    bool hasTextAction = actionsConfig.any((action) => action.actionType == OudsCupertinoNavigationBarActionType.text);
    if (isLeadingAction && hasTextAction) {
      maxActions = 3;
    }
    // Limit the actions list
    final limitedActions = actionsConfig.take(maxActions).toList();

    // Build the list of action widgets
    List<Widget> actionWidgets = limitedActions.map((action) {
      switch (action.actionType) {
        case OudsCupertinoNavigationBarActionType.back:
        case OudsCupertinoNavigationBarActionType.text:
          return ActionWidgetButton(
            onActionPressed: action.onActionPressed,
            label: action.actionLabel ?? "",
            semanticLabel: action.semanticLabel,
          );
        case OudsCupertinoNavigationBarActionType.none:
          return SizedBox.shrink();
        case OudsCupertinoNavigationBarActionType.icon:
          return OudsButton(
            appearance: OudsButtonAppearance.minimal,
            icon: action.customIcon ??
                AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
            onPressed: action.onActionPressed,
            iconColor: OudsTheme
                .of(context)
                .colorScheme(context)
                .actionSelected,
            // todo ouds/💠_navigation/bar/color/ios-accent,);
            package: action.customIcon != null ? null : OudsTheme
                .of(context)
                .packageName,
            semanticLabel: action.semanticLabel,
          );
      }
    }).toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actionWidgets,
    );
  }
}