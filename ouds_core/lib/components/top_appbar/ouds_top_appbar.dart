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

/// {@category Navigation bars}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_background_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_actions_modifier.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_navigation_icon_modifier.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_leading_modifier.dart';

/// Defines the icon type for the leading (left) part of the top app bar.
enum OudsTopAppBarNavigationLeadingIcon {
  none,
  back,
  close,
  menu,
  custom
}

/// Specifies the size of the top app bar.
enum _OudsTopAppBarSize {
 medium, large
}

/// Defines the type of action in the top app bar.
enum OudsTopAppBarActionType {
  icon, avatar
}

/// Specifies the badge type displayed on an icon action.
enum OudsTopAppBarActionIconBadge {
  none, standard, count
}

/// Defines the avatar type for an avatar action.
enum OudsTopAppBarActionAvatar {
  image, monogram
}

/// [OUDS Android Top app bar design guidelines](https://r.orange.fr/r/S-ouds-doc-android-app-bar)
///
/// **Reference design version : 1.0.0**
///
/// Top app bars display information and actions at the top of a screen.
///
/// The [OudsTopAppBar] provides a flexible app bar with various sizes, icons, titles, and actions.
/// It supports different leading icons, avatar, and custom actions to suit your app's needs.
///
/// The [OudsTopAppBar] typically used in the [Scaffold.appBar] property, which places
/// the app bar as a fixed-height widget at the top of the screen. For a scrollable
/// app bar, you can use [OudsSilverTopAppBar.medium] or [OudsSilverTopAppBar.large] see [SliverAppBar],
/// which embeds an [AppBar] in a sliver for use in
/// a [CustomScrollView].
///
///
/// Parameters:
/// - [navigationIcon]: The navigation icon displayed at the start of the top app bar.
/// - [title]: The title to be displayed in the top app bar..
/// - [appBarActions]: The actions displayed at the end of the top app bar, it list of [OudsTopAppBarActionConfig]
/// - [centerTitle]: Whether to center the title. Defaults to false.
/// - [onLeadingPressed]: Callback when the leading icon is pressed.
/// - [backgroundColor]: Whether to display a background color. Defaults to false.
/// - [customLeadingIcon]: Path or identifier for a custom leading icon. Optional.
/// - [showAvatar]: Whether to display an avatar. Defaults to false.
/// - [leadingSemanticLabel]: Content description of the leading, needed for accessibility support
///
/// ```dart
/// OudsTopAppBar(
///       title: "Title",
///        centerTitle: true,
///        backgroundColor: true,
///        navigationIcon: OudsTopAppBarNavigationLeadingIcon.back,
///        onLeadingPressed: () {
///               // Action for navigation button
///               Navigator.of(context).pop();
///             },
///        appBarActions: [
///            OudsTopAppBarActionConfig(
///                type: OudsTopAppBarActionType.icon,
///                iconPath: 'assets/icons/settings.svg',
///                onPressed: () {
///                  // do something
///                },
///               ),
///             OudsTopAppBarActionConfig(
///                type: OudsTopAppBarActionType.avatar,
///                avatarPath: 'assets/images/user.svg',
///                onPressed: () {
///                  // do something
///                },
///              ),
///            ],
///          ),
/// ```
///
class OudsTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  final OudsTopAppBarNavigationLeadingIcon? navigationIcon;
  final String? title;
  final List<OudsTopAppBarActionConfig>? appBarActions;
  final bool? centerTitle;
  final VoidCallback? onLeadingPressed;
  final bool backgroundColor;
  final String? customLeadingIcon;
  final bool showAvatar;
  final String? leadingSemanticLabel;


  const OudsTopAppBar({super.key,
    this.navigationIcon,
    this.title,
    this.appBarActions,
    this.centerTitle = false,
    this.onLeadingPressed,
    this.backgroundColor = false,
    this.customLeadingIcon,
    this.showAvatar = false,
    this.leadingSemanticLabel
});


  @override
  State<OudsTopAppBar> createState() =>_OudsTopAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;

}

class _OudsTopAppBarState extends State<OudsTopAppBar>{
  @override
  PreferredSizeWidget build(BuildContext context) {
    final leadingModifier = OudsTopAppBarLeadingModifier();
    final topAppBarActionsModifier = OudsTopAppBarActionsModifier();
    final topAppBarBackgroundColorModifier = OudsCommonBackgroundColorModifier(context);

    return AppBar(
      centerTitle: widget.centerTitle,
      title: Text(
          widget.title ?? "",
          maxLines: 1,
          style: TextStyle(
            color: OudsTheme.of(context).colorScheme(context).contentDefault,
            overflow: TextOverflow.ellipsis,
            fontFamily: OudsTheme.of(context).fontFamily,
          )
      ),
      automaticallyImplyLeading: false,
      leading: leadingModifier.getLeadingWidget(
          context, widget.navigationIcon, widget.customLeadingIcon,
          widget.leadingSemanticLabel,
          widget.onLeadingPressed),
      actions: topAppBarActionsModifier.getTrailingActionList(
          context, widget.appBarActions, widget.showAvatar)
          ?.map((action) => Center(child: action)).toList(),
      backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(
          widget.backgroundColor),
    );
  }
}

/// [OudsSliverTopAppBar] is typically used as the first child of a
/// [CustomScrollView], which lets the app bar integrate with the scroll view so
/// that it can vary in height according to the scroll offset or float above the
/// other content in the scroll view.
///

class OudsSliverTopAppBar extends StatefulWidget{
  final _OudsTopAppBarSize _size;
  final OudsTopAppBarNavigationLeadingIcon? navigationIcon;
  final String? title;
  final List<OudsTopAppBarActionConfig>? appBarActions;
  final VoidCallback? onLeadingPressed;
  final bool backgroundColor;
  final String? customLeadingIcon;
  final bool showAvatar;
  final String? leadingSemanticLabel;
  final double? expandedHeight;
  final int titleLineCount;

  /// Creates a Material Design medium top app bar that can be placed
  /// in a [CustomScrollView].
  ///
  /// Returns a [OudsSilverTopAppBar] configured with appropriate defaults
  /// for a medium top app bar as defined in Material 3. It starts fully
  /// expanded with the title in an area underneath the main row of icons.
  /// When the [CustomScrollView] is scrolled, the title will be scrolled
  /// under the main row. When it is fully collapsed, a smaller version of the
  /// title will fade in on the main row. The reverse will happen if it is
  /// expanded again.
  ///
  /// ```dart
  /// OudsSliverTopAppBar.medium(
  ///     title: "Title",
  ///     backgroundColor: true,
  ///     showAvatar: true,
  ///     navigationIcon: OudsTopAppBarNavigationLeadingIcon.back,
  ///     titleLineCount: 2,
  ///     expandedHeight: 150,
  ///     appBarActions:[
  ///           OudsTopAppBarActionConfig(
  ///           type: OudsTopAppBarActionType.icon,
  ///           badge: false,
  ///           onActionPressed: () {}
  ///           ),
  ///           OudsTopAppBarActionConfig(
  ///           type: OudsTopAppBarActionType.avatar,
  ///           avatarIcon: "AppAssets.images.ilTopAppBarAvatar",
  ///           onActionPressed: () {}
  ///           )
  ///          ]
  ///        )
  /// ```
  ///
  const OudsSliverTopAppBar.medium(
      {super.key,
        this.navigationIcon,
        this.title,
        this.appBarActions,
        this.onLeadingPressed,
        this.backgroundColor = false,
        this.customLeadingIcon,
        this.showAvatar = false,
        this.leadingSemanticLabel,
        this.expandedHeight = 112,
        this.titleLineCount = 1,
      }) : _size = _OudsTopAppBarSize.medium;

  ///
  /// ```dart
  ///   OudsSliverTopAppBar.large(
  ///     title: "Title",
  ///     backgroundColor: true,
  ///     showAvatar: false,
  ///     navigationIcon: OudsTopAppBarNavigationLeadingIcon.menu,
  ///     appBarActions:[
  ///           OudsTopAppBarActionConfig(
  ///           type: OudsTopAppBarActionType.icon,
  ///           badge: true,
  ///           standard: true,
  ///            onActionPressed: () {}
  ///            )
  ///           ]
  ///     )
  /// ```
  ///
  const OudsSliverTopAppBar.large(
      {super.key,
        this.navigationIcon,
        this.title,
        this.appBarActions,
        this.onLeadingPressed,
        this.backgroundColor = false,
        this.customLeadingIcon,
        this.showAvatar = false,
        this.leadingSemanticLabel,
        this.expandedHeight = 120,
        this.titleLineCount = 1
      }) : _size = _OudsTopAppBarSize.large;


  @override
  State<OudsSliverTopAppBar> createState() =>_OudsSliverTopAppBarState();
}

class _OudsSliverTopAppBarState extends State<OudsSliverTopAppBar> {

  @override
  Widget build(BuildContext context) {

    final topAppBarNavigationIconModifier = OudsTopAppBarNavigationIconModifier();
    final leadingModifier = OudsTopAppBarLeadingModifier();
    final topAppBarActionsModifier = OudsTopAppBarActionsModifier();
    final topAppBarBackgroundColorModifier = OudsCommonBackgroundColorModifier(context);

    switch (widget._size) {
      case _OudsTopAppBarSize.medium:
        return buildMediumTopAppBar(
            leadingModifier,
            topAppBarNavigationIconModifier,
            topAppBarActionsModifier,
            topAppBarBackgroundColorModifier
        );
      case _OudsTopAppBarSize.large:
        return buildLargeTopAppBar(
            leadingModifier,
            topAppBarNavigationIconModifier,
            topAppBarActionsModifier,
            topAppBarBackgroundColorModifier
        );
    }
  }

  Widget buildMediumTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarNavigationIconModifier topAppBarNavigationIconModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsCommonBackgroundColorModifier topAppBarBackgroundColorModifier
      ) {
    return SliverAppBar.medium(
     expandedHeight: widget.expandedHeight,
      title: Text(
            widget.title ?? "",
            style: TextStyle(
                color: OudsTheme.of(context).colorScheme(context).contentDefault,
                fontFamily: Theme.of(context).appBarTheme.titleTextStyle?.fontFamily,
            ),
        maxLines: widget.titleLineCount,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
          ),
      automaticallyImplyLeading: false,
      leading: leadingModifier.getLeadingWidget(
          context, widget.navigationIcon, widget.customLeadingIcon,
          widget.leadingSemanticLabel,
          widget.onLeadingPressed),
      actions: topAppBarActionsModifier
          .getTrailingActionList(context,widget.appBarActions,widget.showAvatar)
          ?.map((action) => Center(child: action)).toList(),
      backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(widget.backgroundColor),
    );
  }

  Widget buildLargeTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarNavigationIconModifier topAppBarNavigationIconModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsCommonBackgroundColorModifier topAppBarBackgroundColorModifier,
      ) {
    return  SliverAppBar.large(
      expandedHeight: widget.expandedHeight,
      title: Text(
      widget.title ?? "",
      style: TextStyle(
        color: OudsTheme.of(context).colorScheme(context).contentDefault,
        fontFamily: Theme.of(context).appBarTheme.titleTextStyle?.fontFamily,
      ),
      maxLines: widget.titleLineCount,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    ),
      automaticallyImplyLeading: false,
      leading: leadingModifier.getLeadingWidget(
          context, widget.navigationIcon, widget.customLeadingIcon,
          widget.leadingSemanticLabel,
          widget.onLeadingPressed),
      actions: topAppBarActionsModifier.getTrailingActionList(context,widget.appBarActions,widget.showAvatar)
          ?.map((action) => Center(child: action)).toList(),
      backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(widget.backgroundColor),
    );
  }
}

/// Configuration class for actions in the Ouds Top App Bar.
///
/// This class defines the properties for configuring individual actions
/// (such as icons or avatars) within the top app bar component.
///
/// - [type]: The type of actions, it can be
///  *   instances of [OudsTopAppBarActionType.Icon] or [OudsTopAppBarActionType.Avatar].
///  *   The default layout here is a [Row], so actions will be placed horizontally.
///  *   The maximum recommended number of actions is three.
/// - [onActionPressed]: The callback invoked when the action is pressed.
/// - [badge]: Whether to display a badge (default: false).
/// - [count]: Optional label for the [OudsBadge].
/// - [standard]: Whether the badge uses a standard style (default: false).
/// - [semanticLabel]: Content description of the trailing, needed for accessibility support
/// - [badgeSemanticLabel]: Content description of the badge, needed for accessibility support
/// - [avatarConfig]:
///
class OudsTopAppBarActionConfig {
  final OudsTopAppBarActionType type ;
  final VoidCallback? onActionPressed;
  final bool badge;
  final String? count;
  final bool standard;
  final String? semanticLabel;
  final String? badgeSemanticLabel;
  final OudsTopAppBarAvatarConfig? avatarConfig;

  OudsTopAppBarActionConfig({
    required this.type,
    required this.onActionPressed,
    this.badge = false,
    this.count,
    this.standard = false,
    this.semanticLabel,
    this.badgeSemanticLabel,
    this.avatarConfig
  });

}

/// Configuration class for the Avatar component within the [OudsTopAppBar].
///
/// This class defines the visual and accessibility properties of an avatar,
/// supporting two main modes:
/// 1. **Icon/Image Mode**: Using [avatarIcon] to display a an image.
/// 2. **Monogram Mode**: Using [monogramText] to display initials (e.g., "A").
///
/// Parameters:
/// [avatarIcon] provides the graphical asset.
/// [monogramText] provides the initials to display.
/// [semanticLabel] ensures accessibility compliance.
/// [monogramBackgroundColor] the background color of the avatar circle when in monogram mode.
/// [monogramColor] the text color of the initials when in monogram mode.
///
class OudsTopAppBarAvatarConfig {
  final String? avatarIcon;
  final String? monogramText;
  final String? semanticLabel;
  final Color? monogramBackgroundColor;
  final Color? monogramColor;

  OudsTopAppBarAvatarConfig({
    this.avatarIcon,
    this.monogramText,
    this.semanticLabel,
    this.monogramBackgroundColor,
    this.monogramColor
  });

}