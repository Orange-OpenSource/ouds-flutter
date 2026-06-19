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
/// TopBar (Material implementation).
///
/// {@category TopBar}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/internal/ouds_button_control_state.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/top_bar/internal/ouds_top_bar_style_modifier.dart';
import 'package:ouds_core/components/top_bar/internal/ouds_topappbar_actions_modifier.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Defines the avatar type for an avatar action.
enum OudsTopAppBarActionAvatar { image, monogram }

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
///
/// OudsTopAppBar default appearance is opaque but, if you need a translucent blurred top app bar as specified on OUDS design side.
/// To do this, use OudsTopAppBar with translucent parameter set to true and :
/// * Avoid wrapping the body in a [SafeArea] as the content must scroll behind the app bar to be visible through the blur.
/// * Set the [Scaffold.extendBodyBehindAppBar] property to `true`.
///
/// ### Example of code:
///
/// ```dart
/// Scaffold(
///   extendBodyBehindAppBar: true,
///   appBar: OudsTopAppBar(...),
///   body: MyScrollableContent(),
/// );
/// ```
///
///
/// For the [OudsTopBarSize.small] size, the app bar has a fixed height.
/// If you need a variable height, you can use [OudsTopBarSize.medium] or [OudsTopBarSize.large],
/// allowing you to adjust the top app bar's height as needed.
///
/// ### Parameters:
/// - [title]: The title to be displayed in the top app bar.
/// - [size]: The different size for top app bar [OudsTopBarSize] it can be smal, medium or large.
/// - [trailingActions]: The actions displayed at the end of the top app bar. These can be
///     type of [OudsTopBarActionConfig] or [OudsTopAppBarAvatarConfig].
///     The default layout here is a [Row], so actions will be placed horizontally.
///     The maximum recommended number of actions is three, it list of [OudsTopBarActionConfig],
///     Please use a dropdown menu if you need more than three actions.
/// - [centerTitle]: Whether to center the title. Defaults to false.
/// - [translucent]: Whether the top app bar should be translucent.
/// - [expandedHeight]: This top app bar's height. Should be applied only for
///     [OudsTopBarSize.medium] and [OudsTopBarSize.large] for [OudsTopBarSize.small] wll be ignored,
///     this value will represent the maximum height that the bar will be allowed to expand.
/// - [titleMaxLines]: Specifies the number of lines the title can span for medium and large top app bars.
/// - [showAvatar]: Whether to show an avatar as action at the left side of the top app bar. Defaults to false.
///
/// ```dart
/// OudsTopAppBar(
///   size: OudsTopBarSize.small,
///   title: 'Profile',
///   translucent: true,
///   centerTitle: true,
///   showAvatar: true,
///   leadingActions: [
///       OudsTopBarActionConfig.back(
///         onActionPressed: () => Navigator.of(context).pop(),
///       ),
///     ],
///   trailingActions: [
///       OudsTopBarActionConfig.icon(
///         customIcon: "assets/icons/search.svg",
///         contentDescription: "Search",
///         onActionPressed: () {
///           // Handle search action
///         },
///       ),
///     OudsTopBarActionConfig.avatar(
///       avatarConfig: OudsTopAppBarAvatarConfig(
///         monogram: 'A',
///       ),
///     ),
///    ],
/// )
/// ```

class OudsTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final OudsTopBarSize size;
  final String? title;
  final List<OudsTopBarActionConfig>? leadingActions;
  final List<OudsTopBarActionConfig>? trailingActions;
  final bool? centerTitle;
  final bool translucent;
  final double? expandedHeight;
  final int titleMaxLines;
  final bool showAvatar;
  final String? icon;

  const OudsTopAppBar({
    super.key,
    this.size = OudsTopBarSize.small,
    this.leadingActions,
    this.title,
    this.trailingActions,
    this.centerTitle = false,
    this.translucent = false,
    this.expandedHeight,
    this.titleMaxLines = 1,
    this.showAvatar = false,
    this.icon,
  });

  @override
  State<OudsTopAppBar> createState() => _OudsTopAppBarState();

  // Helper method to calculate the preferred height based on the AppBar size
  static double getHeight(OudsTopBarSize size, double? expandedHeight) {
    if (size == OudsTopBarSize.medium) {
      // Use expandedHeight if provided and greater than or equal to _mediumHeight;
      // otherwise, default to _mediumHeight
      return (expandedHeight == null || expandedHeight < _mediumHeight)
          ? _mediumHeight
          : expandedHeight;
    }
    if (size == OudsTopBarSize.large) {
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
  static Size getPreferredSize({
    OudsTopBarSize size = OudsTopBarSize.small,
    double? expandedHeight,
  }) {
    return Size.fromHeight(getHeight(size, expandedHeight));
  }
}

class _OudsTopAppBarState extends State<OudsTopAppBar> {
  @override
  PreferredSizeWidget build(BuildContext context) {
    final topAppBarActionsModifier = OudsTopAppBarActionsModifier();
    final topAppBarBackgroundColorModifier = OudsTopBarStyleModifier(context);

    final trailingActions = widget.trailingActions != null
        ? List.generate(
            widget.trailingActions!.length,
            (index) => widget.trailingActions![index]
                .buildTopAppbarTrailingAction(context, widget.showAvatar),
          )
        : null;

    switch (widget.size) {
      case OudsTopBarSize.small:
        return _buildSmallTopAppBar(
          topAppBarActionsModifier,
          topAppBarBackgroundColorModifier,
          trailingActions,
        );
      case OudsTopBarSize.medium:
        return _buildMediumTopAppBar(
          topAppBarActionsModifier,
          topAppBarBackgroundColorModifier,
          trailingActions,
        );
      case OudsTopBarSize.large:
        return _buildLargeTopAppBar(
          topAppBarActionsModifier,
          topAppBarBackgroundColorModifier,
          trailingActions,
        );
    }
  }

  /// Builds a small top app bar with custom styling and modifiers.
  ///
  /// This method creates a [PreferredSize] widget that contains a styled [AppBar]
  /// with optional leading and action widgets, background blur effect, and border decoration.
  PreferredSize _buildSmallTopAppBar(
    OudsTopAppBarActionsModifier actionsModifier,
    OudsTopBarStyleModifier styleModifier,
    List<Widget>? trailingActions,
  ) {
    final backgroundColor = styleModifier.getBackgroundColor(
      widget.translucent,
    );
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.preferredSize.height),
      child: ClipRect(
        child: BackdropFilter(
          filter: styleModifier.getBlurEffect(),
          child: Container(
            decoration: BoxDecoration(border: styleModifier.getBorder()),
            child: AppBar(
              centerTitle: widget.centerTitle,
              title: Text(
                widget.title ?? "",
                maxLines: 1,
                style: TextStyle(
                  color: OudsTheme.of(
                    context,
                  ).colorScheme(context).contentDefault,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: OudsTheme.of(context).fontFamily,
                ),
              ),
              automaticallyImplyLeading: false,
              leading: actionsModifier.getLeadingIconButton(
                context,
                widget.leadingActions?.first,
              ),
              actions: trailingActions,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a medium-sized top app bar with custom styling and modifiers.
  ///
  /// This method creates a [PreferredSize] widget containing a [CustomScrollView]
  /// with a [SliverAppBar] that supports expanded height, custom title, leading widget,
  /// actions, and styling options such as background blur and border decoration.
  PreferredSize _buildMediumTopAppBar(
    OudsTopAppBarActionsModifier actionsModifier,
    OudsTopBarStyleModifier styleModifier,
    List<Widget>? trailingActions,
  ) {
    final backgroundColor = styleModifier.getBackgroundColor(
      widget.translucent,
    );
    // Determine the height: if expandedHeight is null or less than _mediumHeight,
    // use _mediumHeight; otherwise, use expandedHeight entered by user
    final height =
        (widget.expandedHeight == null ||
            widget.expandedHeight! < _mediumHeight)
        ? _mediumHeight
        : widget.expandedHeight!;
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: ClipRect(
        child: BackdropFilter(
          filter: styleModifier.getBlurEffect(),
          child: Container(
            decoration: BoxDecoration(border: styleModifier.getBorder()),
            child: CustomScrollView(
              slivers: [
                SliverAppBar.medium(
                  expandedHeight: height,
                  title: Text(
                    widget.title ?? "",
                    style: TextStyle(
                      color: OudsTheme.of(
                        context,
                      ).colorScheme(context).contentDefault,
                      fontFamily: Theme.of(
                        context,
                      ).appBarTheme.titleTextStyle?.fontFamily,
                    ),
                    maxLines: widget.titleMaxLines,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  automaticallyImplyLeading: false,
                  leading: widget.leadingActions?.isNotEmpty == true
                      ? actionsModifier.getLeadingIconButton(
                          context,
                          widget.leadingActions!.first,
                        )
                      : null,
                  actions: trailingActions != null
                      ? actionsModifier
                            .getTrailingActionList(
                              context,
                              widget.trailingActions,
                              trailingActions,
                            )
                            ?.map((action) => Center(child: action))
                            .toList()
                      : null,
                  backgroundColor: backgroundColor,
                ),
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
    OudsTopAppBarActionsModifier actionsModifier,
    OudsTopBarStyleModifier styleModifier,
    List<Widget>? trailingActions,
  ) {
    final backgroundColor = styleModifier.getBackgroundColor(
      widget.translucent,
    );
    // Determine the height: if expandedHeight is null or less than _largeHeight,
    // use _largeHeight; otherwise, use expandedHeight entered by user
    final height =
        (widget.expandedHeight == null || widget.expandedHeight! < _largeHeight)
        ? _largeHeight
        : widget.expandedHeight!;
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: ClipRect(
        child: BackdropFilter(
          filter: styleModifier.getBlurEffect(),
          child: Container(
            decoration: BoxDecoration(border: styleModifier.getBorder()),
            child: CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  expandedHeight: height,
                  title: Text(
                    widget.title ?? "",
                    style: TextStyle(
                      color: OudsTheme.of(
                        context,
                      ).colorScheme(context).contentDefault,
                      fontFamily: Theme.of(
                        context,
                      ).appBarTheme.titleTextStyle?.fontFamily,
                    ),
                    maxLines: widget.titleMaxLines,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  automaticallyImplyLeading: false,
                  leading: actionsModifier.getLeadingIconButton(
                    context,
                    widget.leadingActions!.first,
                  ),
                  actions: trailingActions != null
                      ? actionsModifier
                            .getTrailingActionList(
                              context,
                              widget.trailingActions,
                              trailingActions,
                            )
                            ?.map((action) => Center(child: action))
                            .toList()
                      : null,
                  backgroundColor: backgroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Configuration class for the Avatar component within the [OudsTopAppBar].
///
/// This class defines the visual and accessibility properties of an avatar,
/// supporting two main modes:
/// 1. **Icon/Image Mode**: Using [image] to display as an image.
/// 2. **Monogram Mode**: Using [monogram] to display initials (e.g., "A").
///
/// ### Parameters:
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
    this.monogramColor,
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
  final OudsTopBarActionBadge? badge;
  final VoidCallback? onPressed;

  const BadgeIconButton({super.key, this.icon, this.badge, this.onPressed});

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
            onPressed: widget.onPressed,
          ).buildIconButtonWithBadge(context, widget.badge, buttonState),
        ),
      ),
    );
  }
}
