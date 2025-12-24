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

/// {@category Top app bar}
library;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_background_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_actions_modifier.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_navigation_icon_modifier.dart';

import '../badge/ouds_badge.dart';
import 'internal/ouds_topappbar_platform_modifier.dart';

enum OudsTopAppBarNavigationIcon {
  none,
  back,
  close,
  menu,
  custom
}

enum OudsTopAppBarSize {
  small, medium, large
}

enum OudsTopAppBarActionType {
  icon, avatar
}

enum OudsTopAppBarActionIconBadge {
  none, standard, count
}

enum OudsTopAppBarActionAvatar {
  image, monogram
}
//TODO update DSM link when available
///
/// **Reference design version : 1.0.0**
///
/// Top app bars display information and actions at the top of a screen.
///
/// This small top app bar has slots for a title, navigation icon, and actions.
///
/// [OudsTopAppBar] default appearance is opaque but, if you need a **translucent blurred top app bar** as specified on OUDS design
/// side, you can implement it in your app with the help of [Haze](https://chrisbanes.github.io/haze/latest/) library. To do this, use [OudsTopAppBar] with
/// [translucent] parameter set to true and follow these steps:
/// 1. Add Haze dependency
/// 2. Follow Haze basic usage instructions:
/// - Define Haze state in the screen containing the top app bar: `val hazeState = rememberHazeState()`
/// - Use `hazeEffect` Modifier on [OudsTopAppBar] providing OUDS blur radius: `Modifier.hazeEffect(state = hazeState, style = HazeStyle(tint = null, blurRadius = OudsTheme.components.bar.blurRadius.dp)),`
/// - Apply `hazeSource` Modifier on the content that scrolls behind the top app bar: `Modifier.hazeSource(state = hazeState)`
/// 3. As your screen content needs to scroll behind the top app bar, you'll probably need to add an additional bottom padding
/// that will have the height of [OudsTopAppBar].
///
///
class OudsTopAppBar extends StatefulWidget {
  final OudsTopAppBarSize? size;
  final OudsTopAppBarNavigationIcon? navigationIcon;
  final String? title;
  final List<OudsTopAppBarActionConfig>? appBarActions;
  final bool centerTitle;
  final VoidCallback? onLeadingPressed;
  final bool backgroundColor;
  final String? customLeadingIcon;
  final String? avatarIcon;
  final String? monogramText;
  final bool showAvatar;


  const OudsTopAppBar({
    this.size = OudsTopAppBarSize.small,
    this.navigationIcon,
    this.title,
    this.appBarActions,
    this.centerTitle = false,
    this.onLeadingPressed,
    this.backgroundColor = false,
    this.customLeadingIcon,
    this.avatarIcon,
    this.monogramText,
    this.showAvatar = false
});

  @override
  State<OudsTopAppBar> createState() =>_OudsTopAppBarState();

}

class _OudsTopAppBarState extends State<OudsTopAppBar>{
  @override
  Widget build(BuildContext context) {
    final topAppBarNavigationIconModifier = OudsTopAppBarNavigationIconModifier();
    final topAppBarWidgetsModifier = OudsTopAppBarWidgetsPlatformModifier();
    final topAppBarActionsModifier = OudsTopAppBarActionsModifier();
    final topAppBarBackgroundColorModifier = OudsTopAppBarBackgroundColorModifier(context);

      switch(widget.size){
        case OudsTopAppBarSize.medium:
          return buildMediumTopAppBar(topAppBarNavigationIconModifier,topAppBarActionsModifier,topAppBarBackgroundColorModifier);
        case OudsTopAppBarSize.large:
          return buildLargeTopAppBar(topAppBarNavigationIconModifier,topAppBarActionsModifier,topAppBarBackgroundColorModifier);
        default:
          return buildSmallTopAppBar(
              topAppBarWidgetsModifier,
              topAppBarNavigationIconModifier,
              topAppBarActionsModifier,
              topAppBarBackgroundColorModifier,
          );
      }
  }

  Widget buildSmallTopAppBar(
      OudsTopAppBarWidgetsPlatformModifier topAppBarWidgetsModifier,
      OudsTopAppBarNavigationIconModifier topAppBarNavigationIconModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsTopAppBarBackgroundColorModifier topAppBarBackgroundColorModifier
      ){

       if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: topAppBarWidgetsModifier.getTitleWidget(context,widget.title),
        leading: topAppBarWidgetsModifier.getLeadingWidget(context,widget.navigationIcon,widget.customLeadingIcon,widget.onLeadingPressed),
        trailing: topAppBarActionsModifier.getTrailingActionList(context,widget.appBarActions, widget.avatarIcon,widget.monogramText,widget.showAvatar)?.first,
        backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(widget.backgroundColor),
      );
    } else {
      return AppBar(
        centerTitle: widget.centerTitle,
        title:  topAppBarWidgetsModifier.getTitleWidget(context,widget.title),
        automaticallyImplyLeading: false,
        leading: topAppBarWidgetsModifier.getLeadingWidget(context,widget.navigationIcon,widget.customLeadingIcon,widget.onLeadingPressed),
        actions: topAppBarActionsModifier.getTrailingActionList(context,widget.appBarActions, widget.avatarIcon,widget.monogramText,widget.showAvatar),
        backgroundColor: topAppBarBackgroundColorModifier.getBackgroundColor(widget.backgroundColor),
      );
    }

  }

  Widget buildMediumTopAppBar(
      OudsTopAppBarNavigationIconModifier topAppBarNavigationIconModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsTopAppBarBackgroundColorModifier topAppBarBackgroundColorModifier
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
            leading: widget.navigationIcon != OudsTopAppBarNavigationIcon.none ?
            OudsButton(
              appearance: OudsButtonAppearance.minimal,
              icon: topAppBarNavigationIconModifier.getNavigationIcon(widget.navigationIcon,widget.customLeadingIcon),
              package: widget.navigationIcon == OudsTopAppBarNavigationIcon.custom ? null : OudsTheme.of(context).packageName,
              onPressed: () => widget.onLeadingPressed,
            ) : null,
            actions: topAppBarActionsModifier.getTrailingActionList(context,widget.appBarActions, widget.avatarIcon,widget.monogramText,widget.showAvatar),
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
      OudsTopAppBarBackgroundColorModifier topAppBarBackgroundColorModifier,
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
            leading: widget.navigationIcon != OudsTopAppBarNavigationIcon.none ?
            OudsButton(
              appearance: OudsButtonAppearance.minimal,
              icon: topAppBarNavigationIconModifier.getNavigationIcon(widget.navigationIcon,widget.customLeadingIcon),
              package: widget.navigationIcon == OudsTopAppBarNavigationIcon.custom ? null : OudsTheme.of(context).packageName,
              onPressed: () => widget.onLeadingPressed,
            ) : null,
            actions: topAppBarActionsModifier.getTrailingActionList(context,widget.appBarActions, widget.avatarIcon,widget.monogramText,widget.showAvatar),
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
/// [type]: The type of action [OudsTopAppBarActionType](required).
/// [onActionPressed]: The callback invoked when the action is pressed.
/// [badge]: Whether to display a badge (default: false).
/// [count]: Optional label for the [OudsBadge].
/// [standard]: Whether the badge uses a standard style (default: false).
class OudsTopAppBarActionConfig {
  final OudsTopAppBarActionType type ;
  final VoidCallback? onActionPressed;
  bool badge;
  String? count;
  bool standard;

  OudsTopAppBarActionConfig({
    required this.type,
    required this.onActionPressed,
    this.badge = false,
    this.count,
    this.standard = false
  });

}