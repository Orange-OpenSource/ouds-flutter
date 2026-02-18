
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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';

class OudsToolbarTopActionModifier {

  OudsToolbarTopActionModifier();

  /// Builds and returns the widget that displays toolbar actions
  /// (leading or trailing) for the OudsToolbarTop component.
  ///
  /// This method:
  /// - Applies business rules to limit the number of visible actions
  /// - Builds the correct widget depending on each action type
  /// - Returns a horizontal list of actions or `null` if no action is provided
  ///
  /// Parameters:
  /// - [context]: Build context used to access theme and localization
  /// - [isLeadingAction]: Indicates whether these actions are on the leading side
  /// - [actionsConfig]: List of [OudsToolbarTopActionConfig] to render
  ///
  /// Returns:
  /// - A [Row] containing the action widgets
  /// - `null` if no actions are available
  ///
  Widget? getActions(
      BuildContext context,
      bool isLeadingAction,
      List<OudsTopBarActionConfig>? actionsConfig
      ) {

    if (actionsConfig == null || actionsConfig.isEmpty) return null;

    // Set maximum actions
    int maxActions = 3;

    // If an action of type 'back' is present, limit to 1
    bool hasBackAction = actionsConfig.any((action) => action.type == OudsTopBarActionType.back);
    if (hasBackAction) {
      maxActions = 1;
    }

    bool hasTextAction = actionsConfig.any((action) => action.type == OudsTopBarActionType.text);
    if (isLeadingAction && hasTextAction) {
      maxActions = 3;
    }
    // Limit the actions list
    final limitedActions = actionsConfig.take(maxActions).toList();

    final colorToken = OudsTheme.of(context).colorScheme(context).actionSelected;

    // Build the widgets corresponding to each action configuration
    List<Widget> actionWidgets = limitedActions.map((action) {
      switch (action.type) {
      // TEXT ACTION
        case OudsTopBarActionType.text:
          return CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                action.actionLabel ?? "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colorToken),
              )
              , onPressed:(){
            action.onActionPressed?.call();
          });
      // BACK ACTION (icon + optional label)
        case OudsTopBarActionType.back:
          return CupertinoButton(
            padding: EdgeInsetsDirectional.zero,
            onPressed: () {
              action.onActionPressed?.call();
            },
            child: Row(
              children: [
                Semantics(
                  label: action.contentDescription
                      ?? OudsLocalizations.of(context)?.core_topAppBar_backNavigationIcon_a11y,
                  child: SvgPicture.asset(
                    alignment: Alignment.centerLeft,
                    excludeFromSemantics: true,
                    matchTextDirection: true,
                    AppAssets.icons.componentLinkPrevious,
                    package: OudsTheme.of(context).packageName,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      colorToken,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                Text(action.actionLabel ?? "",
                  style: TextStyle(
                      color: colorToken
                  ),
                ),
              ],
            ),
          );
      // NO ACTION
        case OudsTopBarActionType.none:
          return SizedBox.shrink();
      // ICON ACTION
        case OudsTopBarActionType.icon:
          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () { action.onActionPressed?.call(); },
            child: SvgPicture.asset(
              alignment: AlignmentDirectional.centerStart,
              excludeFromSemantics: true,
              matchTextDirection: true,
              AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
              package: OudsTheme.of(context).packageName,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                colorToken,
                BlendMode.srcIn,
              ),
            ),
          );
      // CUSTOM ACTION (fully custom widget)
        case OudsTopBarActionType.widget:
          return action.widget!;
        case OudsTopBarActionType.avatar:
          throw UnimplementedError('OudsBarTop for iOS does not support avatar type',);
        case OudsTopBarActionType.custom:
          throw UnimplementedError('OudsBarTop for iOS does not support custom type',);
        case OudsTopBarActionType.close:
          throw UnimplementedError('OudsBarTop for iSO does not support close type',);
        case OudsTopBarActionType.menu:
          throw UnimplementedError('OudsBarTop for iOS does not support menu type',);

      }
    }).toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actionWidgets,
    );
  }
}
