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
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_style_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_actions_modifier.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/top_appbar/internal/ouds_topappbar_leading_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';

import '../button/internal/ouds_button_control_state.dart';

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

/// Defines the type of trailing action in the top app bar.
enum OudsTopAppBarActionType {
  icon, avatar, widget
}

/// Defines the avatar type for an avatar action.
enum OudsTopAppBarActionAvatar {
  image, monogram
}

/// The [SliverAppBar.toolbarHeight] value defined in [SliverAppBar.medium] for medium app bar
const double _mediumHeight = 112;

/// The [SliverAppBar.toolbarHeight] value defined in [SliverAppBar.large] for medium app bar
const double _largeHeight = 152;

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
/// - [actions]: The actions displayed at the end of the top app bar. These can be
///     type of [OudsTopAppBarActionConfig] or [OudsTopAppBarAvatarConfig].
///     The default layout here is a [Row], so actions will be placed horizontally.
///     The maximum recommended number of actions is three, it list of [OudsTopAppBarActionConfig],
///     Please use a dropdown menu if you need more than three actions.
/// - [centerTitle]: Whether to center the title. Defaults to false.
/// - [onLeadingPressed]: Callback when the leading icon is pressed.
/// - [translucent]: Whether the top app bar should be translucent.
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
///     navigationIcon: OudsTopAppBarNavigationLeadingIcon.back,
///     actions:[
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
  final List<OudsTopAppBarActionConfig>? actions;
  final bool? centerTitle;
  final VoidCallback? onLeadingPressed;
  final bool translucent;
  final String? customLeadingIcon;
  final String? leadingSemanticLabel;
  final double? expandedHeight;
  final int titleLineCount;

   const OudsTopAppBar({super.key,
    this.size = OudsTopAppBarSize.small,
    this.navigationIcon,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.onLeadingPressed,
    this.translucent = false,
    this.customLeadingIcon,
    this.leadingSemanticLabel,
    this.expandedHeight,
    this.titleLineCount = 1,
}) ;

  @override
  State<OudsTopAppBar> createState() =>_OudsTopAppBarState();

// Helper method to calculate the preferred height based on the AppBar size
static double getHeight(OudsTopAppBarSize size, double? expandedHeight) {
    if (size == OudsTopAppBarSize.medium) {
      // Use expandedHeight if provided and greater than or equal to _mediumHeight;
      // otherwise, default to _mediumHeight
      return (expandedHeight == null || expandedHeight < _mediumHeight)
          ? _mediumHeight
          : expandedHeight;
    }
    if (size == OudsTopAppBarSize.large) {
      // Use expandedHeight if provided and greater than or equal to _largeHeight;
      // otherwise, default to _largeHeight
      return (expandedHeight == null || expandedHeight < _largeHeight)
          ? _largeHeight
          : expandedHeight;
    }
    return kToolbarHeight;
  }

  @override
  Size get preferredSize => Size.fromHeight(getHeight(size, expandedHeight));

}

class _OudsTopAppBarState extends State<OudsTopAppBar>{
  @override
  PreferredSizeWidget build(BuildContext context) {
    final leadingModifier = OudsTopAppBarLeadingModifier();
    final topAppBarActionsModifier = OudsTopAppBarActionsModifier();
    final topAppBarBackgroundColorModifier = OudsStyleModifier(context);

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

  /// Builds a small top app bar with custom styling and modifiers.
  ///
  /// This method creates a [PreferredSize] widget that contains a styled [AppBar]
  /// with optional leading and action widgets, background blur effect, and border decoration.
  PreferredSize _buildSmallTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsStyleModifier topAppBarStyleModifier
      ){
    final backgroundColor = topAppBarStyleModifier.getBackgroundColor(widget.translucent);
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.preferredSize.height),
      child: ClipRect(
        child: BackdropFilter(filter: topAppBarStyleModifier.getBlurEffect(),
          child: Container(
            decoration: BoxDecoration(
              border: topAppBarStyleModifier.getBorder(),
            ),
          child: AppBar(
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
            leading: leadingModifier.getLeadingIconButton(
                context, widget.navigationIcon, widget.customLeadingIcon,
                widget.leadingSemanticLabel,
                widget.onLeadingPressed),
            actions: topAppBarActionsModifier.getTrailingActionList(
                context, widget.actions)
                ?.map((action) => Center(child: action)).toList(),
            backgroundColor: backgroundColor,
          ),
          ),
        ) ,
      ),
    );
  }

  /// Builds a medium-sized top app bar with custom styling and modifiers.
  ///
  /// This method creates a [PreferredSize] widget containing a [CustomScrollView]
  /// with a [SliverAppBar] that supports expanded height, custom title, leading widget,
  /// actions, and styling options such as background blur and border decoration.
  PreferredSize _buildMediumTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsStyleModifier topAppBarStyleModifier
      ) {
    final backgroundColor = topAppBarStyleModifier.getBackgroundColor(
        widget.translucent);
    // Determine the height: if expandedHeight is null or less than _mediumHeight,
    // use _mediumHeight; otherwise, use expandedHeight entered by user
    final height = (widget.expandedHeight == null || widget.expandedHeight! < _mediumHeight)
        ? _mediumHeight
        : widget.expandedHeight!;
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: ClipRect(
        child: BackdropFilter(filter: topAppBarStyleModifier.getBlurEffect(),
          child: Container(
            decoration: BoxDecoration(
              border: topAppBarStyleModifier.getBorder(),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar.medium(
                  expandedHeight: height,
                  title: Text(
                    widget.title ?? "",
                    style: TextStyle(
                      color: OudsTheme
                          .of(context)
                          .colorScheme(context)
                          .contentDefault,
                      fontFamily: Theme
                          .of(context)
                          .appBarTheme
                          .titleTextStyle
                          ?.fontFamily,
                    ),
                    maxLines: widget.titleLineCount,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  automaticallyImplyLeading: false,
                  leading: leadingModifier.getLeadingIconButton(
                      context, widget.navigationIcon, widget.customLeadingIcon,
                      widget.leadingSemanticLabel,
                      widget.onLeadingPressed),
                  actions: topAppBarActionsModifier
                      .getTrailingActionList(context, widget.actions)
                      ?.map((action) => Center(child: action)).toList(),
                  backgroundColor: backgroundColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a large-sized top app bar with custom styling and modifiers.
  ///
  /// This method creates a [PreferredSize] widget containing a [CustomScrollView]
  /// with a [SliverAppBar] configured for large display, supporting expanded height,
  /// custom title, leading widget, actions, and styling options such as background blur and border decoration.
  PreferredSize _buildLargeTopAppBar(
      OudsTopAppBarLeadingModifier leadingModifier,
      OudsTopAppBarActionsModifier topAppBarActionsModifier,
      OudsStyleModifier topAppBarStyleModifier,
      ) {
    final backgroundColor = topAppBarStyleModifier.getBackgroundColor(widget.translucent);
    // Determine the height: if expandedHeight is null or less than _largeHeight,
    // use _largeHeight; otherwise, use expandedHeight entered by user
    final height = (widget.expandedHeight == null || widget.expandedHeight! < _largeHeight)
        ? _largeHeight
        : widget.expandedHeight!;
    return  PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: ClipRect(
            child: BackdropFilter(filter: topAppBarStyleModifier.getBlurEffect(),
              child: Container(
                decoration: BoxDecoration(
                  border: topAppBarStyleModifier.getBorder(),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar.large(
                      expandedHeight: height,
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
                      leading: leadingModifier.getLeadingIconButton(
                          context, widget.navigationIcon, widget.customLeadingIcon,
                          widget.leadingSemanticLabel,
                          widget.onLeadingPressed),
                      actions: topAppBarActionsModifier.getTrailingActionList(context,widget.actions)
                          ?.map((action) => Center(child: action)).toList(),
                      backgroundColor: backgroundColor,
                    ),
                  ],
                ),
        ),
            ),
        )
    );
  }
}

/// Configuration class for actions in the Ouds Top App Bar.
///
/// This class defines the properties for configuring individual actions
/// (such as icons or avatars) within the top app bar component.
///
/// - [type]: The type of actions, it can be [OudsTopAppBarActionType.icon],
/// [OudsTopAppBarActionType.avatar] or [OudsTopAppBarActionType.widget].
///  *   The default layout here is a [Row], so actions will be placed horizontally.
///  *   The maximum recommended number of actions is three.
/// - [onActionPressed]: The callback invoked when the action is pressed.
/// - [badge]: The badge appearance in action [OudsTopAppBarActionBadge].
/// - [avatarConfig]: Configuration for the avatar displayed in the top app bar [OudsTopAppBarAvatarConfig].
/// - [widget]: Custom widget to display as the action (like a dropdown menu),
///   when [type] selected is [OudsTopAppBarActionType.widget],
///
///
class OudsTopAppBarActionConfig {
  final OudsTopAppBarActionType type ;
  final VoidCallback? onActionPressed;
  final OudsTopAppBarActionBadge? badge;
  final String? contentDescription;
  final OudsTopAppBarAvatarConfig? avatarConfig;
  final Widget? widget;

  OudsTopAppBarActionConfig({
    required this.type,
    this.onActionPressed,
    this.widget,
    this.badge,
    this.contentDescription,
    this.avatarConfig
  }) : assert(
      type != OudsTopAppBarActionType.widget || widget != null,
      'Widget must not be null when type is widget',
      );

}

/// Configuration class for the Avatar component within the [OudsTopAppBar].
///
/// This class defines the visual and accessibility properties of an avatar,
/// supporting two main modes:
/// 1. **Icon/Image Mode**: Using [image] to display a an image.
/// 2. **Monogram Mode**: Using [monogram] to display initials (e.g., "A").
///
/// Parameters:
/// - [image]: Provides the graphical asset.
/// - [monogram]: The single letter monogram for this avatar.
/// - [contentDescription]: Ensures accessibility compliance.
/// - [monogramBackgroundColor]: The background color of the monogram.
/// - [monogramColor]: The color of the monogram.
///
class OudsTopAppBarAvatarConfig {
  final String? image;
  final String? monogram;
  final String? contentDescription;
  final Color? monogramBackgroundColor;
  final Color? monogramColor;

  OudsTopAppBarAvatarConfig({
    this.image,
    this.monogram,
    this.contentDescription,
    this.monogramBackgroundColor,
    this.monogramColor
  });
}

///@nodoc
/// This class is a custom widget designed to incorporate a badge into an icon button.
///
/// It was created because the `OudsButton` does not yet support badges directly.
///
/// The widget manages its own pressed state internally to provide visual feedback
/// when the button is pressed, ensuring a better user experience.
///
/// Usage:
/// - Wrap the icon button with this widget to display a badge (e.g., notification count).
/// - The widget handles tap events and updates its visual state accordingly.
class BadgeIconButton extends StatefulWidget {
  final String? icon;
  final OudsTopAppBarActionBadge? badge;
  final VoidCallback? onPressed;

  const BadgeIconButton({
    super.key,
    this.icon,
    this.badge,
    this.onPressed,
  });

  @override
  State<BadgeIconButton> createState() => _BadgeIconButtonState();
}

class _BadgeIconButtonState extends State<BadgeIconButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {

    final buttonStateDeterminer = OudsButtonControlStateDeterminer(
      enabled: widget.onPressed != null,
      isPressed: _isPressed,
      isHovered: _isHovered,
      isLoading: false,
    );
    final buttonState = buttonStateDeterminer.determineControlState();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Center(
          child: OudsButton(
            appearance: OudsButtonAppearance.minimal,
            icon: widget.icon,
            package: OudsTheme.of(context).packageName,
            onPressed: widget.onPressed,
          ).buildIconButtonWithBadge(
              context,
              widget.badge,
             buttonState,
          ),
        ),
      ),
    );
  }
}

/// A badge in top app bar action
///
/// * See [OudsBadge]
///
/// - [contentDescription]: Content description of the badge, needed for accessibility support.
/// - [count]: Optional number displayed in the badge. If not null, the badge has an [OudsBadgeSize.medium] size.
///  Otherwise, it has an [OudsBadgeSize.xsmall] size.
///
class OudsTopAppBarActionBadge {
  final String contentDescription;
  final String? count;

  const OudsTopAppBarActionBadge({
    required this.contentDescription,
    this.count,
  });

  bool get hasCount => count != null;
}
