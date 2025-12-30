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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/navigation_bars/internal/ouds_common_background_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/navigation_bars/top_appbar/internal/ouds_topappbar_actions_modifier.dart';
import 'package:ouds_core/components/navigation_bars/top_appbar/internal/ouds_topappbar_navigation_icon_modifier.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/navigation_bars/top_appbar/internal/ouds_topappbar_leading_modifier.dart';

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
/// It supports different leading icons, avatars, and custom actions to suit your app's needs.
///
/// Parameters:
/// - [size]: The size of the app bar (small, medium, large). Defaults to [OudsTopAppBarSize.small].
/// - [navigationIcon]: The navigation icon displayed at the start of the top app bar.
/// - [title]: The title to be displayed in the top app bar..
/// - [appBarActions]: The actions displayed at the end of the top app bar.
/// - [centerTitle]: Whether to center the title. Defaults to false.
/// Can be applied only for the small size : [OudsTopAppBarSize.small]
/// - [onLeadingPressed]: Callback when the leading icon is pressed.
/// - [backgroundColor]: Whether to display a background color. Defaults to false.
/// - [customLeadingIcon]: Path or identifier for a custom leading icon. Optional.
/// - [showAvatar]: Whether to display an avatar. Defaults to false.
///
/// ```dart
/// OudsTopAppBar(
///       title: "Title",
///       size: OudsTopAppBarSize.small,
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

class OudsTopAppBar extends StatefulWidget {
  final OudsTopAppBarSize? size;
  final OudsTopAppBarNavigationLeadingIcon? navigationIcon;
  final String? title;
  final List<OudsTopAppBarActionConfig>? appBarActions;
  final bool? centerTitle;
  final VoidCallback? onLeadingPressed;
  final bool backgroundColor;
  final String? customLeadingIcon;
  final bool showAvatar;


  const OudsTopAppBar({super.key,
    this.size = OudsTopAppBarSize.small,
    this.navigationIcon,
    this.title,
    this.appBarActions,
    this.centerTitle = false,
    this.onLeadingPressed,
    this.backgroundColor = false,
    this.customLeadingIcon,
    this.showAvatar = false
});
  const OudsTopAppBar.medium(
      {super.key,
    this.size = OudsTopAppBarSize.medium,
    this.navigationIcon,
    this.title,
    this.appBarActions,
    this.centerTitle,
    this.onLeadingPressed,
    this.backgroundColor = false,
    this.customLeadingIcon,
    this.showAvatar = false
});
  const OudsTopAppBar.large(
      {super.key,
    this.size = OudsTopAppBarSize.large,
    this.navigationIcon,
    this.title,
    this.appBarActions,
    this.centerTitle,
    this.onLeadingPressed,
    this.backgroundColor = false,
    this.customLeadingIcon,
    this.showAvatar = false
});

  @override
  State<OudsTopAppBar> createState() =>_OudsTopAppBarState();

}

class _OudsTopAppBarState extends State<OudsTopAppBar>{
  @override
  Widget build(BuildContext context) {
    final topAppBarNavigationIconModifier = OudsTopAppBarNavigationIconModifier();
    final leadingModifier = OudsTopAppBarLeadingModifier();
    final topAppBarActionsModifier = OudsTopAppBarActionsModifier();
    final topAppBarBackgroundColorModifier = OudsCommonBackgroundColorModifier(context);

      switch(widget.size){
        case OudsTopAppBarSize.medium:
          return buildMediumTopAppBar(topAppBarNavigationIconModifier,topAppBarActionsModifier,topAppBarBackgroundColorModifier);
        case OudsTopAppBarSize.large:
          return buildLargeTopAppBar(topAppBarNavigationIconModifier,topAppBarActionsModifier,topAppBarBackgroundColorModifier);
        default:
          return buildSmallTopAppBar(
            leadingModifier,
              topAppBarNavigationIconModifier,
              topAppBarActionsModifier,
              topAppBarBackgroundColorModifier,
          );
      }
  }

  Widget buildSmallTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarNavigationIconModifier topAppBarNavigationIconModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsCommonBackgroundColorModifier topAppBarBackgroundColorModifier
      ) {
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
            widget.onLeadingPressed),
        actions: topAppBarActionsModifier.getTrailingActionList(
            context, widget.appBarActions, widget.showAvatar),
        backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(
            widget.backgroundColor),
      );
  }

  Widget buildMediumTopAppBar(
      OudsTopAppBarNavigationIconModifier topAppBarNavigationIconModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsCommonBackgroundColorModifier topAppBarBackgroundColorModifier
      ) {

    return  SizedBox(
      height: 100,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            centerTitle: widget.centerTitle,
            title:  Text(
                widget.title ?? "",
                style: TextStyle(
                    color: OudsTheme.of(context).colorScheme(context).contentDefault,
                    fontFamily: OudsTheme.of(context).fontFamily,
                )
            ),
            automaticallyImplyLeading: false,
            leading: widget.navigationIcon != OudsTopAppBarNavigationLeadingIcon.none ?
            OudsButton(
              appearance: OudsButtonAppearance.minimal,
              icon: topAppBarNavigationIconModifier.getNavigationIcon(widget.navigationIcon,widget.customLeadingIcon),
              package: widget.navigationIcon == OudsTopAppBarNavigationLeadingIcon.custom ? null : OudsTheme.of(context).packageName,
              onPressed: () => widget.onLeadingPressed,
            ) : null,
            actions: topAppBarActionsModifier.getTrailingActionList(context,widget.appBarActions,widget.showAvatar),
            backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(widget.backgroundColor),
          ),
         // const SliverFillRemaining(),
        ],
      ),
    );
  }

  Widget buildLargeTopAppBar(
      OudsTopAppBarNavigationIconModifier topAppBarNavigationIconModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsCommonBackgroundColorModifier topAppBarBackgroundColorModifier,
      ) {

    return SizedBox(
      height: 150,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            centerTitle: widget.centerTitle,
            title:  Text(
                widget.title ?? "",
                style: TextStyle(
                    color: OudsTheme.of(context).colorScheme(context).contentDefault,
                  fontFamily: OudsTheme.of(context).fontFamily,
                )
            ),
            automaticallyImplyLeading: false,
            leading: widget.navigationIcon != OudsTopAppBarNavigationLeadingIcon.none ?
            OudsButton(
              appearance: OudsButtonAppearance.minimal,
              icon: topAppBarNavigationIconModifier.getNavigationIcon(widget.navigationIcon,widget.customLeadingIcon),
              package: widget.navigationIcon == OudsTopAppBarNavigationLeadingIcon.custom ? null : OudsTheme.of(context).packageName,
              onPressed: () => widget.onLeadingPressed,
            ) : null,
            actions: topAppBarActionsModifier.getTrailingActionList(context,widget.appBarActions,widget.showAvatar),
            backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(widget.backgroundColor),
          ),
         // const SliverFillRemaining(),
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
/// - [badge]: Whether to display a badge (default: false).
/// - [count]: Optional label for the [OudsBadge].
/// - [standard]: Whether the badge uses a standard style (default: false).
/// - [avatarIcon]: Path or identifier for the avatar icon. Optional.
/// - [monogramText]: Text for the monogram avatar. Optional.
///
class OudsTopAppBarActionConfig {
  final OudsTopAppBarActionType type ;
  final VoidCallback? onActionPressed;
  bool badge;
  String? count;
  bool standard;
  final String? avatarIcon;
  final String? monogramText;

  OudsTopAppBarActionConfig({
    required this.type,
    required this.onActionPressed,
    this.badge = false,
    this.count,
    this.standard = false,
    this.avatarIcon,
    this.monogramText,
  });

}