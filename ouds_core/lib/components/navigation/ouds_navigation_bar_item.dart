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
/// {@category Navigation}
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_indicator_animation.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_status_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_bar_tokens.dart';

///
/// An OUDS navigation bar item.
///
/// An [OudsNavigationBarItem] represents a single destination displayed in an
/// OUDS bottom navigation component (e.g. [OudsNavigationBar] on Material, or
/// [OudsTabBar] on iOS).
///
/// Each item consists of an icon, a label, and optionally a badge.
/// Visual appearance can vary depending on selection and the resolved
/// [OudsNavigationBarControlState] (enabled/hovered/pressed/focused).
///
/// ### Parameters:
/// - [icon]: Asset path of the SVG icon to display.
/// - [label]: Text label of the item.
/// - [badge]: Optional [OudsNavigationBarItemBadge] displayed over the icon.
///
/// ### Example usage:
/// ```dart
/// OudsNavigationBarItem(
///   icon: 'assets/home.svg',
///   label: 'Home',
/// );
/// ```
///
/// With a badge:
/// ```dart
/// OudsNavigationBarItem(
///   icon: 'assets/home.svg',
///   label: 'Home',
///   badge: OudsNavigationBarItemBadge(
///     contentDescription: 'Notifications',
///     count: 3,
///   ),
/// );
/// ```
class OudsNavigationBarItem {
  /// Path to the SVG icon asset.
  final String icon;

  /// Text label of the navigation item.
  final String label;

  /// Optional badge displayed over the icon.
  final OudsNavigationBarItemBadge? badge;

  /// Creates a navigation bar item with an icon, a label, and an optional badge.
  const OudsNavigationBarItem({
    required this.icon,
    required this.label,
    this.badge,
  });

  /// Builds the destination icon for a Material 3 [NavigationDestination], optionally wrapped
  /// with an [OudsBadge].
  ///
  /// Parameters:
  /// - [context] : BuildContext to access theme tokens (sizes, colors).
  /// - [assetName] : The SVG asset path to render.
  /// - [modifier] : [OudsNavigationBarStatusModifier] used to resolve the icon color from state.
  /// - [controlState] : [OudsNavigationBarControlState] used to resolve colors for the icon.
  /// - [badge] : Optional [OudsNavigationBarItemBadge] displayed on top of the icon.
  /// - [isSelected] : Whether the destination is currently selected.
  ///
  /// Returns a [Widget] that contains the SVG icon, optionally wrapped with an [OudsBadge]
  /// when [badge] is provided.

  Widget _buildBadgeIconNavigationDestination(
    BuildContext context,
    String assetName,
    OudsNavigationBarStatusModifier modifier,
    OudsNavigationBarControlState controlState,
    final OudsNavigationBarItemBadge? badge, {
    required bool isSelected,
  }) {
    final widgetIcon = SvgPicture.asset(
      excludeFromSemantics: true,
      assetName,
      fit: BoxFit.contain,
      height: 26, //sizeIcon.iconDecorativeExtraSmall,
      width: 26, //sizeIcon.iconDecorativeExtraSmall,
      colorFilter: ColorFilter.mode(
        modifier.getTextIconItemColor(controlState, isSelected),
        BlendMode.srcIn,
      ),
    );

    return badge != null
        ? ExcludeSemantics(
            // Exclude badge semantics on Android to prevent duplicate announcements.
            // The badge info is already included in the composite NavigationDestination label,
            // so excluding semantics here ensures the correct reading order: "Label, Notification, Tab X of Y"
            child: OudsBadge.count(
              semanticsLabel: badge.contentDescription,
              label: badge.count.toString(),
              status: Negative(),
              size: badge.hasCount
                  ? OudsBadgeSize.medium
                  : OudsBadgeSize.xsmall,
              child: widgetIcon,
            ),
          )
        : widgetIcon;
  }

  /// Builds the top indicator shown above the icon when the destination is selected.
  /// Uses an animated indicator that expands from the center when selected and collapses when deselected.
  /// Reserves space for the indicator even when not selected to prevent item shifting.
  Widget _buildTopIndicatorBar(
    BuildContext context,
    OudsBarTokens bar,
    bool isSelected,
    OudsNavigationBarControlState controlState,
  ) {
    final navigationBarStatusModifier = OudsNavigationBarStatusModifier(
      context,
    );

    final indicator = OudsAnimatedIndicator(
      isSelected: isSelected,
      color: navigationBarStatusModifier.getIndicatorBarColor(controlState),
      thickness: bar.sizeHeightActiveIndicatorCustom,
      tabWidth: bar.sizeWidthActiveIndicatorCustomTop,
      borderRadius: bar.borderRadiusActiveIndicatorCustomTop,
      animationDuration: const Duration(milliseconds: 300),
    );

    // Reserve space for the indicator even when not selected to prevent vertical shift
    return SizedBox(
      height: bar.sizeHeightActiveIndicatorCustom,
      child: isSelected ? indicator : const SizedBox.expand(),
    );
  }

  /// Creates the destination widget tree for this [OudsNavigationBarItem].
  ///
  /// This is intended to be used by [OudsNavigationBar] on Android with Material.
  /// Internally, [OudsNavigationBar] is backed by the Material 3 [NavigationBar]
  /// and [NavigationDestination] widgets.
  ///
  /// The indicator is automatically managed by [NavigationBar] when the item is selected.
  /// Text scaling constraints (maxScaleFactor: 1.08 = 108%) are applied at the bar level
  /// by the parent [OudsNavigationBar] to prevent item overflow at high zoom.
  ///
  /// - [context] is used to access theme tokens and layout values.
  /// - [controlState] drives icon/top-indicator colors according to the current
  ///   OUDS navigation control state.
  /// - [isSelected] indicates whether this destination is currently selected.
  Widget toNavigationDestination(
    BuildContext context,
    OudsNavigationBarControlState controlState, {
    required bool isSelected,
  }) {
    final modifier = OudsNavigationBarStatusModifier(context);

    // Build composite label that includes badge information for accessibility.
    // The label and badge description are combined into a single string so that
    // accessibility tools announce both pieces of information in the correct order.
    String destinationLabel = label;
    if (badge != null) {
      destinationLabel = '$label, ${badge!.contentDescription}';
    }

    // Return NavigationDestination directly without Column wrapper.
    // The indicator is automatically managed by NavigationBar for selected items.
    // Navigation bar applies text scaling constraints at the bar level (maxScaleFactor: 1.08 = 108%)
    // to prevent item overflow at high zoom and ensure the 26px icon stays at 28.08px maximum.
    return NavigationDestination(
      label: destinationLabel,
      icon: _buildBadgeIconNavigationDestination(
        context,
        icon,
        modifier,
        controlState,
        badge,
        isSelected: isSelected,
      ),
      selectedIcon: _buildBadgeIconNavigationDestination(
        context,
        icon,
        modifier,
        controlState,
        badge,
        isSelected: isSelected,
      ),
    );
  }

  /// Creates a [BottomNavigationBarItem] for this [OudsNavigationBarItem].
  ///
  /// This is intended to be used by [OudsTabBar], which is backed by Cupertino's
  /// [CupertinoTabBar] (iOS-style tab bar) and therefore expects a list of
  /// [BottomNavigationBarItem].
  ///
  /// - [context] : BuildContext to access theme and layout.
  /// - [controlState] to drive icon/top-indicator colors,
  /// - [isSelected] for the destination selection state.
  BottomNavigationBarItem toBottomNavigationBarItem(
    BuildContext context,
    OudsNavigationBarControlState controlState, {
    required bool isSelected,
  }) {
    final modifier = OudsNavigationBarStatusModifier(context);

    final tooltip = badge != null
        ? '$label, ${badge!.contentDescription}'
        : label;

    return BottomNavigationBarItem(
      label: label,
      tooltip: tooltip,
      icon: _buildBadgeIconBottomNavigationBarItemScaled(
        context,
        icon,
        modifier,
        controlState,
        badge,
        isSelected: isSelected,
      ),
      activeIcon: _buildBadgeIconBottomNavigationBarItemScaled(
        context,
        icon,
        modifier,
        controlState,
        badge,
        isSelected: isSelected,
      ),
    );
  }

  /// Builds the tab bar icon for [BottomNavigationBarItem].
  ///
  /// This method is a wrapper for consistency with Android implementation.
  /// Text scaling is applied by the parent [OudsTabBar].
  Widget _buildBadgeIconBottomNavigationBarItemScaled(
    BuildContext context,
    String assetName,
    OudsNavigationBarStatusModifier modifier,
    OudsNavigationBarControlState controlState,
    final OudsNavigationBarItemBadge? badge, {
    required bool isSelected,
  }) {
    return _buildBadgeIconBottomNavigationBarItem(
      context,
      assetName,
      modifier,
      controlState,
      badge,
      isSelected: isSelected,
    );
  }

  /// Builds the tab bar icon for a [BottomNavigationBarItem] (used by [CupertinoTabBar]),
  /// including the optional top indicator and an optional [OudsBadge].
  ///
  /// This method constructs a vertical layout with:
  /// 1. A fixed-height indicator bar for visual consistency
  /// 2. A spacer to maintain gap between indicator and icon
  /// 3. The SVG icon with optional badge overlay
  ///
  /// Parameters:
  /// - [context] : BuildContext to access theme tokens (sizes, bar tokens).
  /// - [assetName] : The SVG asset path to render.
  /// - [modifier] : [OudsNavigationBarStatusModifier] used to resolve icon color from state.
  /// - [controlState] : [OudsNavigationBarControlState] used to resolve colors for the icon
  ///   and the top indicator.
  /// - [badge] : Optional [OudsNavigationBarItemBadge] displayed on top of the icon.
  /// - [isSelected] : Whether the item is currently selected.
  ///
  /// Returns a [Widget] that contains:
  /// - the top indicator (visible only when [isSelected] is true),
  /// - a fixed spacer (2px),
  /// - and the SVG icon, optionally wrapped with an [OudsBadge].
  Widget _buildBadgeIconBottomNavigationBarItem(
    BuildContext context,
    String assetName,
    OudsNavigationBarStatusModifier modifier,
    OudsNavigationBarControlState controlState,
    final OudsNavigationBarItemBadge? badge, {
    required bool isSelected,
  }) {
    final bar = OudsTheme.of(context).componentsTokens(context).bar;
    final widgetIcon = SvgPicture.asset(
      excludeFromSemantics: true,
      assetName,
      fit: BoxFit.contain,
      height: 26, //sizeIcon.iconDecorativeExtraSmall,
      width: 26, //sizeIcon.iconDecorativeExtraSmall,
      colorFilter: ColorFilter.mode(
        modifier.getTextIconItemColor(controlState, isSelected),
        BlendMode.srcIn,
      ),
    );

    // Build consistent layout with fixed-height indicator space.
    // The top indicator reserves space even when unselected to maintain stable positioning
    // throughout the selection animation, preventing layout shifts.
    final children = <Widget>[
      _buildTopIndicatorBar(context, bar, isSelected, controlState),
      // Fixed 2px spacing between indicator and icon to ensure consistent layout
      const SizedBox(height: 2),
      badge != null
          ? ExcludeSemantics(
              // Exclude badge semantics on iOS to prevent duplicate announcements.
              // The badge info is included in the BottomNavigationBarItem tooltip, so excluding here
              // ensures accessibility tools don't announce the notification twice.
              child: OudsBadge.count(
                semanticsLabel: badge.contentDescription,
                label: badge.count.toString(),
                status: Negative(),
                size: badge.hasCount
                    ? OudsBadgeSize.medium
                    : OudsBadgeSize.xsmall,
                child: widgetIcon,
              ),
            )
          : widgetIcon,
    ];

    return Column(children: children);
  }
}

/// Represents an optional badge attached to a navigation item.
///
/// Parameters:
/// - [contentDescription] : Semantic description for accessibility.
/// - [count] : Optional integer to display as badge count.
///
/// Example usage:
/// ```dart
/// OudsNavigationBarItemBadge(
///       contentDescription: 'Unread messages',
///       count: 5,
/// );
/// ```

class OudsNavigationBarItemBadge {
  /// Semantic description for accessibility.
  final String contentDescription;

  /// Optional count displayed inside the badge.
  final int? count;

  /// Creates a badge for a navigation bar item.
  const OudsNavigationBarItemBadge({
    required this.contentDescription,
    this.count,
  });

  /// Returns true if the badge has a numeric count.
  bool get hasCount => count != null;
}
