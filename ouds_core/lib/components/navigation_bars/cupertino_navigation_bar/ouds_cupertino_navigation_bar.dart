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

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/navigation_bars/internal/ouds_common_background_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/navigation_bars/cupertino_navigation_bar/internal/ouds_cupertino_navigation_bar_action_modifier.dart';

/// needed for iOS devices
enum OudsCupertinoNavigationBarActionType {
  none,
  back, // only leading
  icon,
  text
}

enum OudsCupertinoNavigationBarStyle {
  defaultStyle, large
}

//TODO update DSM link when available
///
/// **Reference design version : 1.0.0**
///
/// Top app bars display information and actions at the top of a screen.
///
/// This small top app bar has slots for a title, navigation icon, and actions.
///
/// [OudsCupertinoNavigationBar] default appearance is opaque but, if you need a **translucent blurred top app bar** as specified on OUDS design
/// side, you can implement it in your app with the help of [Haze](https://chrisbanes.github.io/haze/latest/) library. To do this, use [OudsTopAppBar] with
/// [translucent] parameter set to true and follow these steps:
/// 1. Add Haze dependency
/// 2. Follow Haze basic usage instructions:
/// - Define Haze state in the screen containing the top app bar: `val hazeState = rememberHazeState()`
/// - Use `hazeEffect` Modifier on [OudsCupertinoNavigationBar] providing OUDS blur radius: `Modifier.hazeEffect(state = hazeState, style = HazeStyle(tint = null, blurRadius = OudsTheme.components.bar.blurRadius.dp)),`
/// - Apply `hazeSource` Modifier on the content that scrolls behind the top app bar: `Modifier.hazeSource(state = hazeState)`
/// 3. As your screen content needs to scroll behind the top app bar, you'll probably need to add an additional bottom padding
/// that will have the height of [OudsCupertinoNavigationBar].
///
///
class OudsCupertinoNavigationBar extends StatefulWidget {
  final OudsCupertinoNavigationBarStyle? style;
  final String? title;
  final bool centerTitle;
  final bool backgroundColor;
  final OudsCupertinoNavigationBarActionConfig? leadingAction;
  final OudsCupertinoNavigationBarActionConfig? trailingAction;

  const OudsCupertinoNavigationBar({super.key,
    this.style = OudsCupertinoNavigationBarStyle.defaultStyle,
    this.title,
    this.centerTitle = false,
    this.backgroundColor = false,
    this.leadingAction,
    this.trailingAction,
});

  @override
  State<OudsCupertinoNavigationBar> createState() =>_OudsCupertinoNavigationState();

}

class _OudsCupertinoNavigationState extends State<OudsCupertinoNavigationBar>{

  @override
  Widget build(BuildContext context) {
    final leadingModifier = OudsCupertinoNavigationBarActionModifier();
    final backgroundModifier = OudsCommonBackgroundColorModifier(context);

    if(widget.style == OudsCupertinoNavigationBarStyle.large){
      return _buildLargeCupertinoNavigationBar(leadingModifier,backgroundModifier);
    }else{
     return _buildDefaultCupertinoNavigationBar(leadingModifier,backgroundModifier);
    }
  }

  Widget _buildDefaultCupertinoNavigationBar(
      OudsCupertinoNavigationBarActionModifier actionModifier,
      OudsCommonBackgroundColorModifier backgroundModifier
      ) {
    final colorToken = OudsTheme.of(context).colorScheme(context);
      return CupertinoNavigationBar(
        middle: Text(
            widget.title ?? "",
            maxLines: 1,
            style: TextStyle(
              color: colorToken.contentDefault,
              overflow: TextOverflow.ellipsis,
              fontFamily: OudsTheme.of(context).fontFamily,
            )
        ),
        backgroundColor: backgroundModifier.getBackgroundColor(
            widget.backgroundColor),
        border: Border.all(color: colorToken.borderMinimal),
        leading: actionModifier.getActionWidget(context, widget.leadingAction),
        trailing: actionModifier.getActionWidget(context, widget.trailingAction),
        automaticallyImplyLeading: false,

      );
  }

  Widget _buildLargeCupertinoNavigationBar(
      OudsCupertinoNavigationBarActionModifier actionModifier,
      OudsCommonBackgroundColorModifier backgroundModifier
      ) {
    final colorToken = OudsTheme.of(context).colorScheme(context);

    return CupertinoNavigationBar.large(

      largeTitle: Text(
          widget.title ?? "",
          maxLines: 1,
          style: TextStyle(
            color: colorToken.contentDefault,
            overflow: TextOverflow.ellipsis,
            fontFamily: OudsTheme.of(context).fontFamily,
          )
      ),
      backgroundColor: backgroundModifier.getBackgroundColor(
          widget.backgroundColor),
      border: Border.all(color: colorToken.borderMinimal),
      leading: actionModifier.getActionWidget(context, widget.leadingAction),
      trailing: actionModifier.getActionWidget(context, widget.trailingAction),
      automaticallyImplyLeading: false,
    );
  }

}

/// Configuration class for actions in the Ouds Cupertino Navigation Bar.
///
/// [actionType]: The type of trailing or leading should be [OudsCupertinoNavigationBarActionType]
///  or [] .
/// [onActionPressed]: The callback function invoked when the action is pressed (required).
/// [trailingLabel]: An optional label for the trailing element.
class OudsCupertinoNavigationBarActionConfig {
  final OudsCupertinoNavigationBarActionType actionType ;
  final VoidCallback? onActionPressed;
  final String? actionLabel;
  final String? customIcon;

  OudsCupertinoNavigationBarActionConfig({
    required this.actionType,
    required this.onActionPressed,
    this.actionLabel,
    this.customIcon
  });

}