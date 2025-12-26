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
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/navigation_bars/cupertino_navigation_bar/ouds_cupertino_navigation_bar.dart';
import 'package:ouds_core/components/navigation_bars/cupertino_navigation_bar/internal/ouds_action_widget.dart';

class OudsCupertinoNavigationBarActionModifier {

  OudsCupertinoNavigationBarActionModifier();

  Widget? getActionWidget(BuildContext context, OudsCupertinoNavigationBarActionConfig? actionConfig){

    switch(actionConfig?.actionType) {
      case OudsCupertinoNavigationBarActionType.back:
        return ActionWidgetButton(
          onActionPressed: actionConfig?.onActionPressed,
          label: actionConfig?.actionLabel ?? "",
        );
      case OudsCupertinoNavigationBarActionType.none:
        return null;
      case OudsCupertinoNavigationBarActionType.icon:
        return OudsButton(
          appearance: OudsButtonAppearance.minimal,
          icon: actionConfig?.customIcon ?? AppAssets.icons.componentLinkPrevious,
          onPressed: actionConfig?.onActionPressed,
          iconColor: OudsTheme.of(context).colorScheme(context)
              .actionSelected, // todo ouds/💠_navigation/bar/color/ios-accent,);
          package: actionConfig?.customIcon != null ? null : OudsTheme
              .of(context).packageName,
        );
      case OudsCupertinoNavigationBarActionType.text:
        return ActionWidgetButton(
          onActionPressed: actionConfig?.onActionPressed,
          label: actionConfig?.actionLabel ?? "",
          actionType: actionConfig!.actionType,
        );

      case null:
        return null;
    }
  }
}