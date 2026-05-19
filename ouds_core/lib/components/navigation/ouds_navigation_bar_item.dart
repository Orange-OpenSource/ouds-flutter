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
        ? OudsBadge.count(
            semanticsLabel: badge.contentDescription,
            label: badge.count.toString(),
            status: Negative(),
            size: badge.hasCount ? OudsBadgeSize.medium : OudsBadgeSize.xsmall,
            child: widgetIcon,
          )
        : widgetIcon;
  }

  /// Builds the top indicator shown above the icon when the destination is selected.
  Container _buildTopIndicatorBar(
    BuildContext context,
    OudsBarTokens bar,
    bool isSelected,
    OudsNavigationBarControlState controlState,
  ) {
    final navigationBarStatusModifier = OudsNavigationBarStatusModifier(
      context,
    );

    return Container(
      height: bar.sizeHeightCurrentIndicatorCustom, // thickness of the bar
      width:
          bar.sizeWidthCurrentIndicatorCustomTop, // width of the bar (adjust)
      decoration: BoxDecoration(
        color: isSelected
            ? navigationBarStatusModifier.getIndicatorBarColor(controlState)
            : Colors.transparent,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(bar.borderRadiusCurrentIndicatorCustomTop),
          right: Radius.circular(bar.borderRadiusCurrentIndicatorCustomTop),
        ),
      ),
    );
  }

  /// Creates the destination widget tree for this [OudsNavigationBarItem].
  ///
  /// This is intended to be used by [OudsNavigationBar] on Android with Material.
  /// Internally, [OudsNavigationBar] is backed by the Material 3 [NavigationBar]
  /// and [NavigationDestination] widgets.
  ///
  /// - [context] is used to access theme tokens and layout values.
  /// - [controlState] drives icon/top-indicator colors according to the current
  ///   OUDS navigation control state.
  /// - [isSelected] indicates whether this destination is currently selected.
  Column toNavigationDestination(
    BuildContext context,
    OudsNavigationBarControlState controlState, {
    required bool isSelected,
  }) {
    final modifier = OudsNavigationBarStatusModifier(context);
    final bar = OudsTheme.of(context).componentsTokens(context).bar;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top active indicator bar (optional visual indicator for selection)
        _buildTopIndicatorBar(context, bar, isSelected, controlState),
        Flexible(
          child: NavigationDestination(
            label: label,
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
          ),
        ),
      ],
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
  ///
  BottomNavigationBarItem toBottomNavigationBarItem(
    BuildContext context,
    OudsNavigationBarControlState controlState, {
    required bool isSelected,
  }) {
    final modifier = OudsNavigationBarStatusModifier(context);

    return BottomNavigationBarItem(
      label: label,
      icon: _buildBadgeIconBottomNavigationBarItem(
        context,
        icon,
        modifier,
        controlState,
        badge,
        isSelected: isSelected,
      ),
      activeIcon: _buildBadgeIconBottomNavigationBarItem(
        context,
        icon,
        modifier,
        controlState,
        badge,
        isSelected: isSelected,
      ),
    );
  }

  /// Builds the tab bar icon for a [BottomNavigationBarItem] (used by [CupertinoTabBar]),
  /// including the optional top indicator and an optional [OudsBadge].
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

    return badge != null
        ? Column(
            children: [
              _buildTopIndicatorBar(context, bar, isSelected, controlState),
              SizedBox(height: 2),
              OudsBadge.count(
                semanticsLabel: badge.contentDescription,
                label: badge.count.toString(),
                status: Negative(),
                size: badge.hasCount
                    ? OudsBadgeSize.medium
                    : OudsBadgeSize.xsmall,
                child: widgetIcon,
              ),
            ],
          )
        : Column(
            children: [
              _buildTopIndicatorBar(context, bar, isSelected, controlState),
              SizedBox(height: 2),
              widgetIcon,
            ],
          );
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
