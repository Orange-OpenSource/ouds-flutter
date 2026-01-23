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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_status_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_bar_tokens.dart';

///
///
/// An OUDS Navigation Bar Item represents a single clickable element within an [OudsNavigationBar].
/// Each item consists of an icon, a label, and optionally a badge.
/// The item can reflect various states like enabled, hovered, pressed, or focused, and updates
/// its appearance based on selection and interaction state.
/// It is typically used in combination with [OudsNavigationBar] to navigate between top-level views.
///
/// ### Classes
///
/// **OudsNavigationBarItemBadge**
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
///
/// **OudsNavigationBarItem**
/// Represents a single item in the navigation bar.
///
/// Parameters:
/// - [icon] : Asset path of the SVG icon to display.
/// - [label] : Text label of the item.
/// - [badge] : Optional [OudsNavigationBarItemBadge] to show a badge on the icon.
/// - [isSelected] : Whether the item is currently selected.
/// - [state] : The interaction state of the item ([OudsNavigationBarControlState]).
///
/// Example usage:
/// ```dart
/// OudsNavigationBarItem(
///       icon: 'assets/home.svg',
///       label: 'Home',
///       badge: OudsNavigationBarItemBadge(contentDescription: 'Notifications', count: 3),
///       isSelected: true,
/// );
/// ```
///

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

class OudsNavigationBarItem {
  /// Path to the SVG icon asset.
  final String icon;

  /// Text label of the navigation item.
  final String label;

  /// Optional badge displayed over the icon.
  final OudsNavigationBarItemBadge? badge;

  /// Whether the item is currently selected.
  final bool isSelected;

  /// Creates a navigation bar item with icon, label, optional badge, selection, and state.
  const OudsNavigationBarItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.badge,
  });

  /// Builds the visual representation of the navigation item.
  ///
  /// Parameters:
  /// - [context] : BuildContext to access theme and layout.
  /// - [isSelected] : Whether this item is currently selected.
  ///
  /// Returns a [Column] containing the optional top indicator and the [NavigationDestination].
  Column build(
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
            icon: _buildBadgeIcon(context, icon, modifier, controlState, badge, isSelected: isSelected),
            selectedIcon: _buildBadgeIcon(context, icon, modifier, controlState, badge, isSelected: isSelected),
          ),
        )
      ],
    );
  }

  /// Builds the top indicator bar shown above the icon when selected.
  Container _buildTopIndicatorBar(BuildContext context, OudsBarTokens bar, bool isSelected, OudsNavigationBarControlState controlState) {
    final navigationBarStatusModifier = OudsNavigationBarStatusModifier(context);

    return Container(
      height: bar.sizeHeightActiveIndicatorCustom, // thickness of the bar
      width: bar.sizeWidthActiveIndicatorCustomTop, // width of the bar (adjust)
      decoration: BoxDecoration(
        color: isSelected ? navigationBarStatusModifier.getIndicatorBarColor(controlState) : Colors.transparent,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(bar.borderRadiusActiveIndicatorCustomTop),
          right: Radius.circular(bar.borderRadiusActiveIndicatorCustomTop),
        ),
      ),
    );
  }

  /// Builds the SVG icon with optional badge overlay.
  ///
  /// Parameters:
  /// - [context] : BuildContext to access theme tokens.
  /// - [assetName] : Path to the SVG asset.
  /// - [modifier] : [OudsNavigationBarStatusModifier] for dynamic coloring.
  /// - [badge] : Optional badge to overlay on the icon.
  /// - [isSelected] : Whether this item is selected.
  ///
  /// Returns a [Widget] containing the icon (with badge if applicable).
  Widget _buildBadgeIcon(
    BuildContext context,
    String assetName,
    OudsNavigationBarStatusModifier modifier,
    OudsNavigationBarControlState controlState,
    final OudsNavigationBarItemBadge? badge, {
    required bool isSelected,
  }) {
    final sizeIcon = OudsTheme.of(context).sizeScheme(context);
    final widgetIcon = SvgPicture.asset(
      excludeFromSemantics: true,
      assetName,
      fit: BoxFit.contain,
      height: sizeIcon.iconDecorativeExtraSmall,
      width: sizeIcon.iconDecorativeExtraSmall,
      colorFilter: ColorFilter.mode(
        modifier.getTextIconItemColor(
          controlState,
          isSelected,
        ),
        BlendMode.srcIn,
      ),
    );

    return badge != null
        ? OudsBadge(
            semanticsLabel: badge.contentDescription,
            label: badge.count.toString(),
            status: OudsBadgeStatus.negative,
            size: badge.hasCount ? OudsBadgeSize.medium : OudsBadgeSize.xsmall,
            child: widgetIcon,
          )
        : widgetIcon;
  }
}
