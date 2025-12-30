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

/// Defines the types of actions that can be used in a Cupertino navigation bar.
enum OudsCupertinoNavigationBarActionType {
  none,
  back,
  icon,
  text
}

/// Defines the style of the Cupertino navigation bar.
enum OudsCupertinoNavigationBarStyle {
  defaultStyle, large
}

/// [OUDS iOS tool bar top design guidelines](https://r.orange.fr/r/S-ouds-doc-ios-tool-bar-top)
///
/// **Reference design version : 1.0.0**
///
/// A custom Cupertino-style navigation bar widget.
///
/// This widget provides a customizable navigation bar similar to iOS's Cupertino style,
///  supporting different styles, titles, and actions on the leading and trailing sides.
/// The Toolbar top (aka Navigation bar on iOS and iPadOS 18)
///
/// Parameters:
/// - [style]: The style of the navigation bar, either default or large. Defaults to [OudsCupertinoNavigationBarStyle.defaultStyle].
/// - [title]: The title displayed in the navigation bar. Optional.
/// - [backgroundColor]: Whether to show a background color. Defaults to false.
/// - [leadingActions]: A list of actions (buttons) displayed on the leading side (left). Optional.
/// - [trailingActions]: A list of actions (buttons) displayed on the trailing side (right). Optional.
///
///
/// ### You can use [OudsCupertinoNavigationBar] component in your project, customizing parameters as needed :
///
/// **Default Cupertino Navigation Bar:**
///
/// This is the default layout of the component.
///
/// ```dart
/// OudsCupertinoNavigationBar(
///             title: "Title",
///             style: OudsCupertinoNavigationBarStyle.defaultStyle,
///             leadingActions: [
///               OudsCupertinoNavigationBarActionConfig(
///                 type: OudsCupertinoNavigationBarActionType.back,
///                 onPressed: () {
///                   // do something
///                 },
///               ),
///             ],
///             trailingActions: [
///               OudsCupertinoNavigationBarActionConfig(
///                 type: OudsCupertinoNavigationBarActionType.text,
///                 label: "Edit",
///                 onPressed: () {
///                   // do something
///                 },
///               ),
///             ],
///           ),
///
/// ```
class OudsCupertinoNavigationBar extends StatefulWidget {
  final OudsCupertinoNavigationBarStyle? style;
  final String? title;
  final bool backgroundColor;
  final List<OudsCupertinoNavigationBarActionConfig>? leadingActions;
  final List<OudsCupertinoNavigationBarActionConfig>? trailingActions;

  const OudsCupertinoNavigationBar({super.key,
    this.style = OudsCupertinoNavigationBarStyle.defaultStyle,
    this.title,
    this.backgroundColor = false,
    this.leadingActions,
    this.trailingActions
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
        leading: actionModifier.getActionsWidget(context,true, widget.leadingActions),
        trailing: actionModifier.getActionsWidget(context, false,widget.trailingActions),
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
      leading: actionModifier.getActionsWidget(context, true, widget.leadingActions),
      trailing: actionModifier.getActionsWidget(context, false, widget.trailingActions),
      automaticallyImplyLeading: false,
    );
  }

}

/// Configuration for an action in the Cupertino navigation bar.
///
/// This class defines the properties for an action button, which can be either
/// a text button, an icon, or a custom icon, along with its callback.
///
/// Parameters:
/// - [actionType]: The type of action [OudsCupertinoNavigationBarActionType] (icon or text).
/// - [onActionPressed]: The callback invoked when the action is pressed.
/// - [actionLabel]: The label text for the action (used if actionType is text).
/// - [customIcon]: Path or identifier for a custom icon (used if actionType is icon).
///
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