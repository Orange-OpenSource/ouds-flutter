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

/// {@category Top app bars}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_background_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_actions_modifier.dart';
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
enum OudsTopAppBarSize {
 small, medium, large
}

/// Defines the type of action in the top app bar.
enum OudsTopAppBarActionType {
  icon, avatar
}

/// Defines the avatar type for an avatar action.
enum OudsTopAppBarActionAvatar {
  image, monogram
}

/// [OUDS Android Top app bar design guidelines](https://r.orange.fr/r/S-ouds-doc-android-app-bar)
///
/// **Reference design version : 1.0.0**
///
/// Top app bars display information and actions at the top of the screen.
///
/// The [OudsTopAppBar] is a flexible app bar that can be customized with different sizes, icons, titles, and actions.
/// It supports leading icons, avatars, and custom action widgets to fit your app's requirements.
///
/// Typically, [OudsTopAppBar] is used in the [Scaffold.appBar] property.
/// For the [OudsTopAppBarSize.small] size, the app bar has a fixed height.
/// If you need a variable height, you can use [OudsTopAppBarSize.medium] or [OudsTopAppBarSize.large],
/// allowing you to adjust the top app bar's height as needed.
///
/// Parameters:
/// - [title]: The title to be displayed in the top app bar.
/// - [navigationIcon]: The navigation icon displayed at the start of the top app bar.
/// - [size]: The different size for top app bar [OudsTopAppBarSize] it can be smal, medium or large.
/// - [appBarActions]: The actions displayed at the end of the top app bar. These can be
///     type of [OudsTopAppBarAction.Icon] or [OudsTopAppBarAction.Avatar].
///     The default layout here is a [Row], so actions will be placed horizontally.
///     The maximum recommended number of actions is three, it list of [OudsTopAppBarActionConfig]
/// - [centerTitle]: Whether to center the title. Defaults to false.
/// - [onLeadingPressed]: Callback when the leading icon is pressed.
/// - [backgroundColor]: Whether to display a background color. Defaults to false.
/// - [customLeadingIcon]: Path or identifier for a custom leading icon. Optional.
/// - [leadingSemanticLabel]: Content description of the leading, needed for accessibility support
/// - [expandedHeight]: This top app bar's height. Should be applied only for
///     [OudsTopAppBarSize.medium] and [OudsTopAppBarSize.large] for [OudsTopAppBarSize.small] wll be ignored,
///     this value will represent the maximum height that the bar will be allowed to expand.
/// - [titleLineCount]: Specifies the number of lines the title can span for medium and large top app bars.
///
/// ```dart
/// OudsTopAppBar(
///     title: "Title",
///     backgroundColor: true,
///     navigationIcon: OudsTopAppBarNavigationLeadingIcon.none,
///     appBarActions:[
///           OudsTopAppBarActionConfig(
///           type: OudsTopAppBarActionType.icon,
///            onActionPressed: () {}
///            ),
///           OudsTopAppBarActionConfig(
///           type: OudsTopAppBarActionType.avatar,
///           avatarConfig: OudsTopAppBarAvatarConfig(
///              avatarIcon: AppAssets.images.ilTopAppBarAvatar,
///              monogramText: null,
///     ),
///           onActionPressed: () {}
///           )
///           ],
///   centerTitle: false
///     )
///
/// ```
///
class OudsTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  final OudsTopAppBarSize size;
  final OudsTopAppBarNavigationLeadingIcon? navigationIcon;
  final String? title;
  final List<OudsTopAppBarActionConfig>? appBarActions;
  final bool? centerTitle;
  final VoidCallback? onLeadingPressed;
  final bool backgroundColor;
  final String? customLeadingIcon;
  final String? leadingSemanticLabel;
  final double? expandedHeight;
  final int titleLineCount;

  const OudsTopAppBar({super.key,
    this.size = OudsTopAppBarSize.small,
    this.navigationIcon,
    this.title,
    this.appBarActions,
    this.centerTitle = false,
    this.onLeadingPressed,
    this.backgroundColor = false,
    this.customLeadingIcon,
    this.leadingSemanticLabel,
    this.expandedHeight,
    this.titleLineCount = 1,
});

  @override
  State<OudsTopAppBar> createState() =>_OudsTopAppBarState();

  @override
  Size get preferredSize {
    if (size == OudsTopAppBarSize.medium) {
      return Size.fromHeight(expandedHeight?? 112);
    }
    if (size == OudsTopAppBarSize.large) {
      return Size.fromHeight(expandedHeight?? 152);
    }
    return AppBar().preferredSize;
  }

}

class _OudsTopAppBarState extends State<OudsTopAppBar>{
  @override
  PreferredSizeWidget build(BuildContext context) {
    final leadingModifier = OudsTopAppBarLeadingModifier();
    final topAppBarActionsModifier = OudsTopAppBarActionsModifier();
    final topAppBarBackgroundColorModifier = OudsCommonBackgroundColorModifier(context);

    switch (widget.size){
      case OudsTopAppBarSize.small:
        return _buildSmallTopAppBar(
            leadingModifier,
            topAppBarActionsModifier,
            topAppBarBackgroundColorModifier);
      case OudsTopAppBarSize.medium:
        return _buildMediumTopAppBar(
            leadingModifier,
            topAppBarActionsModifier,
            topAppBarBackgroundColorModifier);
      case OudsTopAppBarSize.large:
        return _buildLargeTopAppBar(
            leadingModifier,
            topAppBarActionsModifier,
            topAppBarBackgroundColorModifier);
    }
  }

  AppBar _buildSmallTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsCommonBackgroundColorModifier topAppBarBackgroundColorModifier
      ){

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
          context, widget.appBarActions)
          ?.map((action) => Center(child: action)).toList(),
      backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(
          widget.backgroundColor),
    );
  }

  PreferredSize _buildMediumTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsCommonBackgroundColorModifier topAppBarBackgroundColorModifier
      ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.expandedHeight ?? 112),
      child: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            expandedHeight: widget.expandedHeight ?? 112,
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
                .getTrailingActionList(context,widget.appBarActions)
                ?.map((action) => Center(child: action)).toList(),
            backgroundColor:topAppBarBackgroundColorModifier.getBackgroundColor(widget.backgroundColor),
          )
        ],
      ),
    );
  }

  PreferredSize _buildLargeTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsCommonBackgroundColorModifier topAppBarBackgroundColorModifier,
      ) {
    return  PreferredSize(
        preferredSize: Size.fromHeight(widget.expandedHeight ?? 152),
        child: CustomScrollView(
          slivers: [
      SliverAppBar.large(
      expandedHeight: widget.expandedHeight ?? 152,
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
      actions: topAppBarActionsModifier.getTrailingActionList(context,widget.appBarActions)
          ?.map((action) => Center(child: action)).toList(),
      backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(widget.backgroundColor),
    ),
        ],
        ),
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
/// - [count]: Optional label for the [OudsBadge]
/// The badge appearance is determined as follows:
/// * **null**: No badge is displayed.
/// * **empty string ("")**: A **standard** badge is displayed (a small red dot without number).
/// * **non-empty string**: A **count** badge is displayed (showing the provided number)..
/// - [semanticLabel]: Content description of the trailing, needed for accessibility support
/// - [badgeSemanticLabel]: Content description of the badge, needed for accessibility support
/// - [avatarConfig]: Configuration for the avatar displayed in the top app bar [OudsTopAppBarAvatarConfig].
///
class OudsTopAppBarActionConfig {
  final OudsTopAppBarActionType type ;
  final VoidCallback? onActionPressed;
  final String? count;
  final String? badgeSemanticLabel;
  final String? semanticLabel;
  final OudsTopAppBarAvatarConfig? avatarConfig;

  OudsTopAppBarActionConfig({
    required this.type,
    required this.onActionPressed,
    this.count,
    this.badgeSemanticLabel,
    this.semanticLabel,
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
/// - [avatarIcon]: Provides the graphical asset.
/// - [monogramText]: Provides the initials to display.
/// - [semanticLabel]: Ensures accessibility compliance.
/// - [monogramBackgroundColor]: The background color of the avatar circle when in monogram mode.
/// - [monogramColor]: The text color of the initials when in monogram mode.
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