
//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

/// @nodoc
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsToolbarTopActionModifier {

  /// Generates a row of action widgets based on the provided actions configuration.
  ///
  /// This method applies business rules to limit the number of visible actions:
  /// - If an action of type 'back' is present, only one action is shown.
  /// - If the actions are leading and include a text action, up to three actions are allowed.
  ///
  ///
  /// Parameters:
  /// - [context]: The build context used to access theme and localization.
  /// - [isLeadingAction]: A boolean indicating whether these actions are on the leading side.
  /// - [actionsConfig]: The list of [OudsTopBarActionConfig] to render.
  /// - [actions]: The list of pre-built action widgets corresponding to [actionsConfig]
  ///
  /// Returns:
  /// - A [Row] widget containing the action widgets, or null if no actions are provided.
  List<Widget>? getToolBarActions(
      BuildContext context,
      bool isLeadingAction,
      List<OudsTopBarActionConfig>? actionsConfig,
      List<Widget> actions
      ) {

    if (actionsConfig == null || actionsConfig.isEmpty) return null;

    /// Set maximum actions
    int maxActions = 3;

    /// If an action of type 'back' is present, limit to 1
    bool hasBackAction = actionsConfig.any((action) => action.type == OudsTopBarActionType.back);
    if (hasBackAction) {
      maxActions = 1;
    }

    bool hasTextAction = actionsConfig.any((action) => action.type == OudsTopBarActionType.text);
    if (isLeadingAction && hasTextAction) {
      maxActions = 3;
    }
    /// Limit the actions list
    return actions.take(maxActions).toList();
  }

  Widget buildActionIcon(BuildContext context, String? customIcon, bool enabled){

    final enabledColorToken = OudsTheme.of(context).colorScheme(context).actionSelected;
    final disabledColorToken = OudsTheme.of(context).colorScheme(context).contentDisabled;

    return SvgPicture.asset(
      alignment: AlignmentDirectional.center,
      width: 26,
      height: 26,
      excludeFromSemantics: true,
      matchTextDirection: true,
      customIcon ?? AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
      fit: BoxFit.fill,
      colorFilter: ColorFilter.mode(
        enabled? enabledColorToken : disabledColorToken,
        BlendMode.srcIn,
      ),
    );
  }

  Widget buildBackIcon(BuildContext context, bool enabled){

    final enabledColorToken = OudsTheme.of(context).colorScheme(context).actionSelected;
    final disabledColorToken = OudsTheme.of(context).colorScheme(context).contentDisabled;

    return SvgPicture.asset(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      excludeFromSemantics: true,
      matchTextDirection: true,
      AppAssets.icons.componentLinkPrevious,
      package: OudsTheme.of(context).packageName,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        enabled ? enabledColorToken : disabledColorToken,
        BlendMode.srcIn,
      ),
    );
  }
}