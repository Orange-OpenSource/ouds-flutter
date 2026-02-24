
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
/// {@category TopBar}
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/top_bar/ouds_toolbar_top.dart';
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';

/// Alias for [OudsTopBar].
///
/// Use this if you prefer a more explicit name that matches Flutter's
/// `OudsAppBar` terminology.
typedef OudsAppBar = OudsTopBar;

/// Specifies the size of the bar top.
enum OudsTopBarSize {
  small, medium, large
}

/// Defines the type of leading and trailing actions in the bar top.
enum OudsTopBarActionType {
  //common
  none,
  icon,
  widget,
  //Material only
  back,
  text,
  avatar,
  custom,
  close,
  menu,
}

/// A platform-adaptive bar top component.
///
/// **Reference design version : 1.0.0**
///
/// The Bar top is a top-aligned component that displays the screen title
/// and provides access to key actions and navigation elements.
///
/// This widget renders:
/// - [OudsToolbarTop] on iOS (backed by Cupertino's [CupertinoNavigationBar]),
/// - [OudsTopAppBar] on Android (backed by the Material 3 [AppBar]).
///
/// It provides a single, shared API so consumers don't have to branch on platform.
///
/// ### Parameters:
///
/// #### Common parameters
///
/// * [title]: The title to be displayed in the bar top.
/// * [size]: The size of the Bar Top defined by [OudsTopBarSize].
///   - Medium size is only supported in the Material variant.
/// * [translucent]: Whether the Bar Top should be translucent.

/// * [leadingActions] - Actions displayed at the start of the Bar Top.
///   - Material: Supports a single leading action.
///   - Cupertino: Supports multiple leading actions.
///
/// * [trailingActions]: The actions displayed at the end of the Bar Top. These can be
///     type of [OudsTopBarActionConfig].
///     The default layout here is a [Row], so actions will be placed horizontally.
///     The maximum recommended number of actions is three, it list of [OudsTopBarActionConfig],
///     Please use a dropdown menu if you need more than three actions.
///
/// #### Material variant only (ignored on Cupertino)
///
/// * [centerTitle]: Whether to center the title. Defaults to false.
/// * [expandedHeight]: This Bar Top's height. Should be applied only for
///     [OudsTopBarSize.medium] and [OudsTopBarSize.large] for [OudsTopBarSize.small] wll be ignored,
///     this value will represent the maximum height that the bar will be allowed to expand.
/// * [titleMaxLines]: Specifies the number of lines the title can span for medium and large Bar Tops.
/// * [showAvatar] - Whether avatar support is enabled in the Bar Top.
///
///
/// ### Example usage:
///
/// **Using [OudsAppBar]:**
/// ```dart
/// OudsAppBar(
///   size: OudsTopBarSize.small,
///    title: "Title",
///    leadingActions: [
///       OudsTopBarActionConfig(
///         type: OudsTopBarActionType.back,
///         actionLabel: "Label",
///         onActionPressed: (){},
///       )],
///    trailingActions: [
///       OudsTopBarActionConfig(
///         type: OudsTopBarActionType.icon,
///         customIcon: "assets/functional-social-and-engagement-heart-empty.svg",
///         onActionPressed: (){},
///       )],
///)
/// ```
///
/// **Using the alias [OudsTopBar]:**
/// ```dart
/// OudsTopBar(
///   size: OudsTopBarSize.small,
///    title: "Title",
///    leadingActions: [
///       OudsTopBarActionConfig(
///         type: OudsTopBarActionType.back,
///         actionLabel: "Label",
///         onActionPressed: (){},
///       )],
///    trailingActions: [
///       OudsTopBarActionConfig(
///         type: OudsTopBarActionType.icon,
///         customIcon: "assets/functional-social-and-engagement-heart-empty.svg",
///         onActionPressed: (){},
///       )],
///)
/// ```
///
/// See also:
///
/// * [OudsTopAppBar] — Material implementation.
/// * [OudsToolbarTop] — Cupertino implementation.
///
class OudsTopBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {

  // common
  final String? title;
  final bool translucent;
  final OudsTopBarSize size;

  //only one leading action for Material
  final List<OudsTopBarActionConfig>? leadingActions;
  final List<OudsTopBarActionConfig>? trailingActions;

  //Material only
  final bool? centerTitle;
  final double? expandedHeight;
  final int titleMaxLines;
  final bool showAvatar;

  const OudsTopBar({
    super.key,

    this.title,
    this.translucent = false,
    this.size = OudsTopBarSize.small,
    this.leadingActions,
    this.trailingActions,

    //for material
    this.centerTitle = false,
    this.expandedHeight,
    this.titleMaxLines = 1,
    this.showAvatar = false
  });

  bool _isIOS(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS ;
  }

  @override
  Widget build(BuildContext context) {
    if (_isIOS(context)) {
      return OudsToolbarTop(
        title: title,
        translucent: translucent,
        style: size,
        leadingActions: leadingActions,
        trailingActions: trailingActions,
      );
    }else{
      return OudsTopAppBar(
        title: title,
        translucent: translucent,
        size: size,
        leadingActions: leadingActions,
        trailingActions: trailingActions,
        centerTitle: centerTitle,
        expandedHeight: expandedHeight,
        titleMaxLines: titleMaxLines,
        showAvatar: showAvatar,
      );
    }
  }

  /// Returns the preferred size based on the platform: OudsToolbarTop size for iOS,
  /// OudsTopAppBar size for Android and other platforms.
  @override
  Size get preferredSize => defaultTargetPlatform == TargetPlatform.iOS
      ? OudsToolbarTop().preferredSize
      : OudsTopAppBar().preferredSize;

  /// Determines whether the toolbar should fully obstruct the content behind it
  /// by delegating to OudsToolbarTop implementation.
  @override
  bool shouldFullyObstruct(BuildContext context) {
    return OudsToolbarTop().shouldFullyObstruct(context);
  }

}

/// Configuration class for actions in the Ouds Top Bar.
///
/// This class defines the properties for configuring individual actions
/// (such as icons, text or avatars) within the Bar Top component.
///
/// - [type]: The type of actions of [OudsTopBarActionType]
///  *   The default layout here is a [Row], so actions will be placed horizontally.
///  *   The maximum recommended number of actions is three.
/// - [actionLabel]: The label text for the action (used if actionType is [OudsTopBarActionType.text]). (iOS only)
/// - [customLeadingIcon]: Path or identifier for a custom icon (used if actionType is [OudsTopBarActionType.icon]). (for Android)
/// - [onActionPressed]: The callback invoked when the action is pressed.
/// - [widget]: Custom widget to display as the action (like a dropdown menu),
///   when [type] selected is [OudsTopBarActionType.widget],
///
///  **Android parameters**
/// - [badge]: The badge appearance in action [OudsTopAppBarActionBadge].
/// - [avatarConfig]: Configuration for the avatar displayed in the Bar Top [OudsTopAppBarAvatarConfig].
///
///
class OudsTopBarActionConfig {
  //common
  final OudsTopBarActionType type ;
  final VoidCallback? onActionPressed;
  final String? contentDescription;
  final Widget? widget;
  //Cupertino
  final String? actionLabel;
  final String? customIcon;

  //Material
  final OudsTopAppBarAvatarConfig? avatarConfig;
  final OudsTopAppBarActionBadge? badge;
  final String? customLeadingIcon;

  OudsTopBarActionConfig({
    required this.type,
    this.onActionPressed,
    this.widget,
    this.badge,
    this.contentDescription,
    this.avatarConfig,
    this.actionLabel,
    this.customIcon,
    this.customLeadingIcon
  }) : assert(
  type != OudsTopBarActionType.widget || widget != null,
  'Widget must not be null when type is widget',
  );
}
