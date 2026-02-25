
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
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';

/// Alias for [OudsTopBar].
///
/// Use this if you prefer a more explicit name that matches Flutter's
/// `OudsAppBar` terminology.
typedef OudsAppBar = OudsTopBar;

/// Specifies the size of the top bar.
enum OudsTopBarSize {
  /// Small top bar (standard height).
  small,
  /// Medium top bar (Material only - expanded height).
  medium,
  /// Large top bar (maximum expanded height).
  large
}

/// Defines the type of leading and trailing actions in the top bar.
enum OudsTopBarActionType {
  /// ========== Common Variables ==========
  /// No action is displayed.
  none,
  /// Displays a single icon button.
  icon,
  /// Displays a custom widget.
  widget,
  /// ========== Material-Only Variables ==========
  /// Displays a back arrow (Material only).
  back,
  /// Displays a text-based action button (Material only).
  text,
  /// Displays an avatar (Material only).
  avatar,
  /// Fully customized action (Material only).
  custom,
  /// Displays a close (X) button (Material only).
  close,
  /// Displays a menu icon (Material only).
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
/// - [title]: The title to be displayed in the top bar.
/// - [size]: The size of the Bar Top defined by [OudsTopBarSize].
///   - Medium size is only supported in the Material variant.
/// - [translucent]: Whether the Bar Top should be translucent.

/// - [leadingActions]: Actions displayed at the start of the Bar Top.
///   - Material: Supports a single leading action.
///   - Cupertino: Supports multiple leading actions.
///
/// - [trailingActions]: The actions displayed at the end of the Bar Top. These can be
///     type of [OudsTopBarActionConfig].
///     The default layout here is a [Row], so actions will be placed horizontally.
///     The maximum recommended number of actions is three, it list of [OudsTopBarActionConfig],
///     Please use a dropdown menu if you need more than three actions.
///
/// #### Material variant only (ignored on Cupertino)
///
/// - [centerTitle]: Whether to center the title. Defaults to false.
/// - [expandedHeight]: This Bar Top's height. Should be applied only for
///     [OudsTopBarSize.medium] and [OudsTopBarSize.large] for [OudsTopBarSize.small] wll be ignored,
///     this value will represent the maximum height that the bar will be allowed to expand.
/// - [titleMaxLines]: Specifies the number of lines the title can span for medium and large Bar Tops.
/// - [showAvatar]: Whether avatar support is enabled in the Bar Top.
///
///
/// ### Example usage:
///
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
class OudsTopBar extends StatelessWidget implements PreferredSizeWidget{

  /// Common parameters mixed with Material-only
  final String? title;
  final bool translucent;
  final OudsTopBarSize size;
  final List<OudsTopBarActionConfig>? leadingActions;
  final List<OudsTopBarActionConfig>? trailingActions;

  /// Material only - but not visually separated
  final bool? centerTitle;
  final double? expandedHeight;
  final int titleMaxLines;
  final bool showAvatar;

  const OudsTopBar({
    super.key,

    /// ========== Common Parameters ==========
    this.title,
    this.translucent = false,
    this.size = OudsTopBarSize.small,
    this.leadingActions,
    this.trailingActions,

    /// ========== Material-Only Parameters ==========
    /// These parameters are ignored on iOS/Cupertino
    this.centerTitle = false,
    this.expandedHeight,
    this.titleMaxLines = 1,
    this.showAvatar = false
  });

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return OudsToolbarTop(
        title: title,
        translucent: translucent,
        style: size,
        leadingActions: leadingActions,
        trailingActions: trailingActions,
      );
    }else{
      // Material only supports single leading action
      assert(
      leadingActions == null || leadingActions!.length <= 1,
      'Material variant only supports a single leading action. '
          'Received ${leadingActions?.length} actions.',
      );
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
      ? OudsToolbarTop.getPreferredSize
      : OudsTopAppBar.getPreferredSize(size: size,expandedHeight: expandedHeight);

  /// Returns the preferred size based on the platform: OudsToolbarTop size for iOS,
  /// OudsTopAppBar size for Android and other platforms.
  ///
  /// This method is static, so it can be called outside this class without instantiating the widget.
  /// Note: The parameters is only required for Android; it is ignored on iOS.
  ///
  /// Parameters:
  /// - [size]: The size of the top bar.
  /// - [expandedHeight]: The expanded height of the bar.
  ///
  /// Returns:
  /// - A [Size] object representing the preferred size.
  static Size getPreferredSize({OudsTopBarSize? size, double? expandedHeight}){
   return defaultTargetPlatform == TargetPlatform.iOS
        ? OudsToolbarTop.getPreferredSize
        : OudsTopAppBar.getPreferredSize(size: size!,expandedHeight: expandedHeight);
  }

}

