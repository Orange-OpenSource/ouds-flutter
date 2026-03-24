
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
/// TopBar (Cupertino implementation).
///
/// {@category TopBar}
library;

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/top_bar/internal/ouds_toolbar_top_action_modifier.dart';
import 'package:ouds_core/components/top_bar/internal/ouds_top_bar_style_modifier.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';


/// [OUDS iOS tool bar top design guidelines](https://r.orange.fr/r/S-ouds-doc-ios-tool-bar-top)
///
/// **Reference design version : 1.0.0**
///
/// The Toolbar top sits at the top of the screen and provides contextual information
/// and controls related to the current view. It typically displays the page title,
/// and may include navigation actions such as “Back,” as well as supplementary actions like menus.
///
/// OudsToolbarTop default appearance is opaque but, if you need a translucent blurred toolbar top as specified on OUDS design side.
/// To do this, use OudsToolbarTop with translucent parameter set to true and avoid wrapping the body in a [SafeArea] as the content
/// must scroll behind the toolbar top to be visible through the blur.
///
/// ### Parameters:
/// - [style]: The style of the the toolbar top, only supports `small` and `large` sizes.
/// Defaults to [OudsTopBarSize.small]. Throws [AssertionError] if `medium` is used.
///
/// - [title]: The title displayed in the toolbar top. Optional.
/// - [translucent]: Whether the toolbar top should be translucent.. Defaults to false.
/// - [leadingActions]: A list of actions [OudsTopBarActionConfig] displayed on the leading side (left). Optional.
/// - [trailingActions]: A list of actions [OudsTopBarActionConfig] displayed on the trailing side (right). Optional.
///
/// ### Example of code:
///
/// ```dart
/// OudsToolbarTop(
///   style: OudsTopBarSize.small,
///   title: 'Profile',
///   translucent: true,
///   leadingActions: [
///       OudsTopBarActionConfig.back(
///         previousPageTitle: 'Settings', // Shows: "← Settings"
///         onActionPressed: () => Navigator.of(context).pop(),
///       ),
///     ],
///     trailingActions: [
///       OudsTopBarActionConfig.icon(
///         customIcon: "assets/icons/settings.svg",
///         contentDescription: "Settings",
///         onActionPressed: () {
///           // Handle settings action
///         },
///       ),
///     ],
/// )
/// ```
///
class OudsToolbarTop extends StatefulWidget implements PreferredSizeWidget{
  final OudsTopBarSize? style;
  final String? title;
  final bool translucent;
  final List<OudsTopBarActionConfig>? leadingActions;
  final List<OudsTopBarActionConfig>? trailingActions;

  const OudsToolbarTop({super.key,
    this.style = OudsTopBarSize.small,
    this.title,
    this.translucent = false,
    this.leadingActions,
    this.trailingActions,
  }) : assert (
    style != OudsTopBarSize.medium,
  'OudsToolbarTop does not support the medium style. Use small or large.'
  );

  @override
  State<OudsToolbarTop> createState() =>_OudsToolbarTopState();

  @override
  Size get preferredSize => CupertinoNavigationBar().preferredSize;
  static Size get getPreferredSize => CupertinoNavigationBar().preferredSize;
}

class _OudsToolbarTopState extends State<OudsToolbarTop>{

  @override
  Widget build(BuildContext context) {
    final leadingModifier =OudsToolbarTopActionModifier();
    final styleModifier = OudsTopBarStyleModifier(context);
    final leadingActions = widget.leadingActions?.map((config) => config.buildToolbarTopAction(context, true)).toList() ?? [];
    final trailingActions = widget.trailingActions?.map((config) => config.buildToolbarTopAction(context, false)).toList() ?? [];

    if(widget.style == OudsTopBarSize.large){
      return _buildLargeToolbarTop(leadingModifier,styleModifier,leadingActions,trailingActions);
    }else{
      return _buildDefaultToolbarTop(leadingModifier,styleModifier,leadingActions,trailingActions);
    }
  }

  /// Builds the default (small) toolbar top using a Cupertino navigation bar.
  ///
  /// This version is used when the large title style is not required and provides:
  /// - A blur effect behind the app bar
  /// - A centered title with ellipsis overflow handling
  /// - Custom background color and bottom border styling
  /// - Leading and trailing actions provided by the action modifier
  ///
  Widget _buildDefaultToolbarTop(
      OudsToolbarTopActionModifier actionModifier,
      OudsTopBarStyleModifier styleModifier,
      List<Widget> leadingActions,
      List<Widget> trailingActions
      ) {
    final colorToken = OudsTheme.of(context).colorScheme(context);
    return ClipRect(
      child: BackdropFilter(
        filter: styleModifier.getBlurEffect(),
        child: SizedBox(
          child: CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            padding: EdgeInsetsDirectional.zero,
            middle: Text(
                textAlign: TextAlign.center,
                widget.title ?? "",
                style: TextStyle(
                  color: OudsTheme.of(context).colorScheme(context).contentDefault,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: OudsTheme.of(context).fontFamily,
                ).copyWith(
                  letterSpacing: -0.43
                )
            ),
            automaticBackgroundVisibility: false,
            automaticallyImplyLeading: false,
            backgroundColor: styleModifier.getBackgroundColor(widget.translucent),
            border: Border(
                bottom: BorderSide(
                    color: colorToken.borderMinimal
                )
            ),
            leading: _buildActionSection(actionModifier, true, widget.leadingActions, leadingActions),
            trailing: _buildActionSection(actionModifier, false, widget.trailingActions, trailingActions),
          ),
        ),
      ),
    );
  }

  /// Builds a large-style toolbar top using a Cupertino navigation bar.
  ///
  /// This widget is mainly used for iOS-style large titles and supports:
  /// - A blur effect behind the app bar
  /// - Custom background color and border styling
  /// - Leading and trailing actions provided by the action modifier
  /// - A large title
  ///
  Widget _buildLargeToolbarTop(
      OudsToolbarTopActionModifier actionModifier,
      OudsTopBarStyleModifier styleModifier,
      List<Widget> leadingActions,
      List<Widget> trailingActions
      ) {
    final colorToken = OudsTheme.of(context).colorScheme(context);
    final typography = OudsTheme.of(context).typographyTokens;

    final leadingActions =  List.generate(
      widget.leadingActions!.length,
          (index) => widget.leadingActions![index].buildToolbarTopAction(
          context,
          true
      ),
    );

    final trailingActions =  List.generate(
      widget.trailingActions!.length,
          (index) => widget.trailingActions![index].buildToolbarTopAction(
          context,
          false
      ),
    );
    return ClipRect(
      child: BackdropFilter(
        filter: styleModifier.getBlurEffect(),
        child: CupertinoNavigationBar.large(
          padding: EdgeInsetsDirectional.zero,
          transitionBetweenRoutes: false,
          largeTitle: Text(
              widget.title ?? "",
              style: typography.typeDisplayMedium(context).copyWith(
                  color: colorToken.contentDefault,
                fontSize: 34,
                letterSpacing: 0.4
              )
          ),
          automaticBackgroundVisibility: false,
          backgroundColor: styleModifier.getBackgroundColor(widget.translucent),
          border: styleModifier.getBorder(),
          leading: _buildActionSection(actionModifier, true, widget.leadingActions, leadingActions),
          trailing: _buildActionSection(actionModifier, false, widget.trailingActions, trailingActions),
          automaticallyImplyLeading: false,
        ),
      ),
    );
  }

  /// Builds an action section for the toolbar with position-specific padding.
  ///
  /// Creates a padded row of toolbar actions based on their position (leading or trailing).
  /// The padding differs depending on the position: 8px for leading, 16px for trailing.
  ///
  /// Parameters:
  /// - [actionModifier]: Modifier that generates the toolbar actions
  /// - [isLeading]: Whether actions are positioned at the start (true) or end (false)
  /// - [configs]: Optional list of action configurations
  /// - [actions]: List of action widgets to display
  ///
  /// Returns a [Widget] containing the positioned and padded actions.
  Widget _buildActionSection(
      OudsToolbarTopActionModifier actionModifier,
      bool isLeading,
      List<OudsTopBarActionConfig>? configs,
      List<Widget> actions,
      ) {
    return Padding(
      padding: isLeading
          ? const EdgeInsetsDirectional.only(start: 8)
          : const EdgeInsetsDirectional.only(end: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: actionModifier.getToolBarActions(context, isLeading, configs, actions) ?? [],
      ),
    );
  }
}