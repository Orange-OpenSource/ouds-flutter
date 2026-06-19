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
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_a11y.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_indicator_animation.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_status_modifier.dart';
import 'package:ouds_core/components/utilities/badge_border_utils.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_bar_tokens.dart';

/// A single destination in an OUDS bottom navigation component.
///
/// Used by [OudsNavigationBar] (Material/Android) and [OudsTabBar] (iOS).
/// Each item has an icon, a label, and an optional badge. Visual appearance
/// adapts to the [OudsNavigationBarControlState] (enabled/hovered/pressed/focused).
///
/// ```dart
/// OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home');
///
/// // With badge:
/// OudsNavigationBarItem(
///   icon: 'assets/home.svg',
///   label: 'Home',
///   badge: OudsNavigationBarItemBadge(contentDescription: 'Notifications', count: 3),
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
      height: 26,
      width: 26,
      colorFilter: ColorFilter.mode(
        modifier.getTextIconItemColor(controlState, isSelected),
        BlendMode.srcIn,
      ),
    );

    if (badge == null) return widgetIcon;

    return buildBadgeWithBorder(
      context: context,
      hasCount: badge.hasCount,
      child: OudsBadge.count(
        // The badge semantic label is handled by the parent Semantics node
        // in toNavigationDestination to control the TalkBack reading order.
        semanticsLabel: null,
        label: badge.count.toString(),
        status: Negative(),
        size: badge.hasCount ? OudsBadgeSize.medium : OudsBadgeSize.xsmall,
        child: widgetIcon,
      ),
    );
  }

  /// Builds the top indicator shown above the icon.
  ///
  /// [index] is used to generate a unique [ValueKey] per item.
  /// [externalController] is optional and used on iOS to survive tab rebuilds.
  Widget _buildTopIndicatorBar(
    BuildContext context,
    OudsBarTokens bar,
    bool isSelected,
    OudsNavigationBarControlState controlState,
    int index, {
    AnimationController? externalController, // Optional for iOS
  }) {
    final navigationBarStatusModifier = OudsNavigationBarStatusModifier(
      context,
    );

    return OudsAnimatedIndicator(
      key: ValueKey('indicator_$index'),
      isSelected: isSelected,
      color: navigationBarStatusModifier.getIndicatorBarColor(controlState),
      thickness: bar.sizeHeightCurrentIndicatorCustom,
      tabWidth: bar.sizeWidthCurrentIndicatorCustomTop,
      borderRadius: bar.borderRadiusCurrentIndicatorCustomTop,
      animationDuration: const Duration(milliseconds: 300),
      externalController: externalController, // Pass external controller
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
  /// - [index] zero-based position of this item in the navigation bar.
  /// - [total] total number of destinations in the navigation bar.
  Column toNavigationDestination(
    BuildContext context,
    OudsNavigationBarControlState controlState, {
    required bool isSelected,
    required int index,
    required int total,
    VoidCallback? onTap,
  }) {
    final modifier = OudsNavigationBarStatusModifier(context);
    final bar = OudsTheme.of(context).componentsTokens(context).bar;

    // Builds the full TalkBack label: "Label[, badge], Tab X of Y"
    final localizations = MaterialLocalizations.of(context);
    final contentLabel = OudsNavigationBarA11y.buildTabSemanticLabel(
      label,
      badge,
    );
    final fullSemanticLabel =
        '$contentLabel, ${localizations.tabLabel(tabIndex: index + 1, tabCount: total)}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Android: no external controller, uses internal animation
        _buildTopIndicatorBar(context, bar, isSelected, controlState, index),
        Flexible(
          child: Semantics(
            // Override NavigationDestination's internal semantics to enforce
            // the correct reading order: "Label[, badge], Tab X of Y".
            // onTap restores the activation action lost by ExcludeSemantics.
            label: fullSemanticLabel,
            selected: isSelected,
            onTap: onTap,
            child: ExcludeSemantics(
              // Suppresses NavigationDestination's own semantic nodes,
              // which would otherwise produce a wrong TalkBack reading order.
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
  /// Semantics for VoiceOver are intentionally **not** set here.
  /// They are managed at the [OudsTabBar] level via a [Stack] overlay of
  /// transparent [Semantics] widgets positioned over each tab item, so that
  /// VoiceOver sees exactly one node per tab announcing:
  /// "Label[, badge], Tab X of Y".
  ///
  /// - [context] : BuildContext to access theme and layout.
  /// - [controlState] to drive icon/top-indicator colors.
  /// - [isSelected] for the destination selection state.
  /// - [index] zero-based position of this item in the tab bar.
  /// - [externalController] optional [AnimationController] managed by the
  ///   parent [OudsTabBar] to survive tab rebuilds on iOS.
  BottomNavigationBarItem toBottomNavigationBarItem(
    BuildContext context,
    OudsNavigationBarControlState controlState, {
    required bool isSelected,
    required int index,
    AnimationController? externalController,
  }) {
    final modifier = OudsNavigationBarStatusModifier(context);

    // Build the raw icon widget.
    // All semantics are suppressed here — VoiceOver nodes are managed by
    // the OudsTabBar Stack overlay to guarantee a single node per tab.
    final iconWidget = ExcludeSemantics(
      child: _buildBadgeIconBottomNavigationBarItem(
        context,
        icon,
        modifier,
        controlState,
        badge,
        isSelected: isSelected,
        index: index,
        externalController: externalController,
      ),
    );

    return BottomNavigationBarItem(
      // Keep the real label for visual display under the icon.
      label: label,
      // All semantics suppressed — managed by OudsTabBar Stack overlay.
      icon: iconWidget,
      activeIcon: iconWidget,
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
    required int index,
    AnimationController? externalController, // Optional for iOS
  }) {
    final bar = OudsTheme.of(context).componentsTokens(context).bar;
    final widgetIcon = SvgPicture.asset(
      excludeFromSemantics: true,
      assetName,
      fit: BoxFit.contain,
      height: 26,
      width: 26,
      colorFilter: ColorFilter.mode(
        modifier.getTextIconItemColor(controlState, isSelected),
        BlendMode.srcIn,
      ),
    );

    final children = <Widget>[
      // iOS: pass external controller to survive rebuilds
      _buildTopIndicatorBar(
        context,
        bar,
        isSelected,
        controlState,
        index,
        externalController: externalController,
      ),
      const SizedBox(height: 2),
      badge != null
          ? buildBadgeWithBorder(
              context: context,
              hasCount: badge.hasCount,
              child: OudsBadge.count(
                // All semantics suppressed — managed by OudsTabBar Stack overlay.
                semanticsLabel: null,
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

/// An optional badge attached to a navigation item.
///
/// [contentDescription] is the semantic text announced by screen readers.
/// [count] is the optional numeric value displayed inside the badge.
///
/// ```dart
/// OudsNavigationBarItemBadge(contentDescription: 'Unread messages', count: 5);
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
