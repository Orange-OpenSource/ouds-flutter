
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
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/button/ouds_button.dart';

class OudsTopAppBarActionsModifier {

  /// Retrieves and reorders the trailing action widgets to ensure avatar is positioned last.
  ///
  /// Parameters:
  /// - [context]: The build context for accessing theme and localization
  /// - [actionsList]: The list of action configurations used to identify the avatar.
  /// - [actions]: The list of pre-built action widgets corresponding to [actionsList]
  ///
  /// Returns:
  /// - A reordered list of [Widget] with avatar positioned last (if present)
  /// - `null` if [actionsList] is null
  /// - The original [actions] list if no avatar is found
  ///
  List<Widget>? getTrailingActionList(
      BuildContext context,
      List<OudsTopBarActionConfig>? actionsList,
      List<Widget> actions) {
    if (actionsList == null) return null;

    final avatarIndex = actionsList
        .indexWhere((a) => a.type == OudsTopBarActionType.avatar);

    final orderedList = List<Widget>.from(actions);

    if (avatarIndex != -1) {
      final avatar = orderedList.removeAt(avatarIndex);
      orderedList.add(avatar);
    }
    return orderedList;
  }

  /// Retrieves the leading icon button for the topAppbar based on the provided action configuration.
  ///
  /// Returns `null` if [action] is null or has type [OudsTopBarActionType.none].
  Widget? getLeadingIconButton(
      BuildContext context,
      OudsTopBarActionConfig? action,
      ) {
    if (action == null || action.type == OudsTopBarActionType.none) return null;

    final modifier = OudsTopAppBarNavigationIconModifier();
    final isCustom = action.type == OudsTopBarActionType.custom;

    final button = OudsButton(
      appearance: OudsButtonAppearance.minimal,
      icon: modifier.getNavigationIcon(action.type, action.customLeadingIcon),
      package: isCustom ? null : OudsTheme.of(context).packageName,
      onPressed: () {
        action.onActionPressed?.call();
      },
    );

    return Center(
      child: isCustom
          ? button
          : Semantics(
        label: modifier.getNavigationIconLabel(
          context,
          action.type,
          action.contentDescription,
        ),
        button: true,
        child: ExcludeSemantics(child: button),
      ),
    );
  }
}
