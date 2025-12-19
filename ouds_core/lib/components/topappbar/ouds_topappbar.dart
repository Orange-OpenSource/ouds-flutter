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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/topappbar/internal/ouds_topappbar_actions_modifier.dart';
import 'package:ouds_core/components/topappbar/internal/ouds_topappbar_navigation_icon_modifier.dart';

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

enum OudsTopAppBarAction {
  icon,
  avatar
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
  final List<OudsTopAppBarAction>? appBarActions;
  final bool centerTitle;
  final VoidCallback? onLeadingPressed;
  final bool backgroundColor;
  final String? customLeadingIcon;
  final String? avatarIcon;


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
});

  @override
  State<OudsTopAppBar> createState() =>_OudsTopAppBarState();

}

class _OudsTopAppBarState extends State<OudsTopAppBar>{
  @override
  Widget build(BuildContext context) {
    final appBarNavigationIconModifier = OudsTopAppBarNavigationIconModifier();
    final appBarActionsModifier = OudsTopAppBarActionsModifier();

      switch(widget.size){
        case OudsTopAppBarSize.medium:
          return buildMediumTopAppBar(appBarNavigationIconModifier,appBarActionsModifier);
        case OudsTopAppBarSize.large:
          return buildLargeTopAppBar(appBarNavigationIconModifier,appBarActionsModifier);
        default:
          return buildSmallTopAppBar(appBarNavigationIconModifier,appBarActionsModifier);
      }
  }


  Widget buildSmallTopAppBar(
      OudsTopAppBarNavigationIconModifier appBarNavigationIconModifier,
      OudsTopAppBarActionsModifier appBarActionsModifier,
      ){
    final appBarToken = OudsTheme.of(context).componentsTokens(context).bar;

    return AppBar(
      centerTitle: widget.centerTitle,
      title:  Text(widget.title ?? ""),
      automaticallyImplyLeading: false,
      leading: widget.navigationIcon != OudsTopAppBarNavigationIcon.none ?
      OudsButton(
        appearance: OudsButtonAppearance.minimal,
        icon: appBarNavigationIconModifier.getNavigationIcon(widget.navigationIcon,widget.customLeadingIcon),
        package: widget.navigationIcon == OudsTopAppBarNavigationIcon.custom ? null : OudsTheme.of(context).packageName,
        onPressed: () => widget.onLeadingPressed,
      ) : null,
      actions: appBarActionsModifier.getTrailingActionList(context,widget.appBarActions, widget.avatarIcon),
      backgroundColor: appBarToken.colorBgTranslucentLight,
    );
  }

  Widget buildMediumTopAppBar(OudsTopAppBarNavigationIconModifier appBarNavigationIconModifier, OudsTopAppBarActionsModifier appBarActionsModifier) {

    return  SizedBox(
      height: 100,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title:  Text(widget.title ?? ""),
            automaticallyImplyLeading: false,
            leading: widget.navigationIcon != OudsTopAppBarNavigationIcon.none ?
            OudsButton(
              appearance: OudsButtonAppearance.minimal,
              icon: appBarNavigationIconModifier.getNavigationIcon(widget.navigationIcon,widget.customLeadingIcon),
              package: widget.navigationIcon == OudsTopAppBarNavigationIcon.custom ? null : OudsTheme.of(context).packageName,
              onPressed: () => widget.onLeadingPressed,
            ) : null,
            actions: appBarActionsModifier.getTrailingActionList(context,widget.appBarActions, widget.avatarIcon),
          ),
          //const SliverFillRemaining(),
        ],
      ),
    );
  }

  Widget buildLargeTopAppBar(OudsTopAppBarNavigationIconModifier appBarNavigationIconModifier, OudsTopAppBarActionsModifier appBarActionsModifier) {

    return SizedBox(
      height: 150,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title:  Text(widget.title ?? ""),
            automaticallyImplyLeading: false,
            leading: widget.navigationIcon != OudsTopAppBarNavigationIcon.none ?
            OudsButton(
              appearance: OudsButtonAppearance.minimal,
              icon: appBarNavigationIconModifier.getNavigationIcon(widget.navigationIcon,widget.customLeadingIcon),
              package: widget.navigationIcon == OudsTopAppBarNavigationIcon.custom ? null : OudsTheme.of(context).packageName,
              onPressed: () => widget.onLeadingPressed,
            ) : null,
            actions: appBarActionsModifier.getTrailingActionList(context,widget.appBarActions, widget.avatarIcon),
          ),
         // const SliverFillRemaining(),
        ],
      ),
    );
  }

}