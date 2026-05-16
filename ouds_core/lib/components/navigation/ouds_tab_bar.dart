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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_a11y.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_background_modifier.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_border_modifier.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_status_modifier.dart';
import 'package:ouds_core/components/navigation/ouds_navigation_bar_item.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// [OUDS Tab Bar design guidelines](https://r.orange.fr/r/S-ouds-doc-ios-tab-bar)
///
/// **Reference design version: 1.0.0**
///
/// The Tab bar is a system navigation component positioned at the bottom of the screen.
/// It allows users to switch between the primary sections of an app.
/// Each tab is represented by an icon, optionally paired with a label,
/// and maintains persistent visibility across top-level destinations.
///
/// This widget is backed by Cupertino's [CupertinoTabBar] (iOS-style bottom tab bar)
/// and expects a list of [BottomNavigationBarItem] built from OUDS destinations
/// (see [OudsNavigationBarItem.toBottomNavigationBarItem]).
///
/// The bar can be **opaque or translucent**. [OudsTabBar] default appearance is opaque.
/// If you need a translucent blurred background as specified by OUDS design:
/// * Avoid wrapping the body in a [SafeArea] as the content must scroll behind the bar
///   to be visible through the blur.
/// * Set the [Scaffold.extendBody] property to `true`.
///
/// Example of code:
///
/// ```dart
/// return Scaffold(
///   extendBody: true,
///   bottomNavigationBar: OudsTabBar(...),
///   body: MyScrollableContent(),
/// );
/// ```
///
/// ### Parameters:
/// - [items]: The list of [OudsNavigationBarItem] to display.
/// - [translucent]: If true, renders a translucent background; otherwise opaque.
/// - [currentIndex]: The index of the initially selected item.
/// - [onTap]: Callback triggered when a destination is tapped, returns the index.
///
/// ### Example usage:
///
/// **Default tab bar with 3 items:**
/// ```dart
/// OudsTabBar(
///   destinations: [
///     OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home'),
///     OudsNavigationBarItem(icon: 'assets/search.svg', label: 'Search'),
///     OudsNavigationBarItem(icon: 'assets/profile.svg', label: 'Profile'),
///   ],
///   selectedIndex: 0,
///   translucent: true,
///   onDestinationSelected: (index) {
///     print('Selected item: $index');
///   },
/// );
/// ```
///
/// **Tab bar without translucency:**
/// ```dart
/// OudsTabBar(
///   destinations: [
///     OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home'),
///     OudsNavigationBarItem(icon: 'assets/search.svg', label: 'Search'),
///   ],
///   selectedIndex: 0,
///   translucent: false,
///   ,
///   onDestinationSelected: (index) {
///     print('Selected item: $index');
///   },
/// );
/// ```
class OudsTabBar extends StatefulWidget {
  /// The list of items displayed in the bar (icons, labels, optional badge).
  final List<OudsNavigationBarItem> items;

  /// If true, the navigation bar has a translucent background.
  final bool translucent;

  /// The index of the initially selected item.
  final int currentIndex;

  /// Callback invoked when a navigation item is tapped.
  final ValueChanged<int>? onTap;

  /// Creates an OUDS Navigation Bar with configurable items, transparency, and callbacks.
  const OudsTabBar({
    super.key,
    required this.items,
    this.translucent = false,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  State<OudsTabBar> createState() => _OudsTabBarState();
}

class _OudsTabBarState extends State<OudsTabBar> {
  int _selectedIndex = 0;

  /// Initializes the selected index from the widget's [currentIndex].
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex.clamp(0, widget.items.length - 1);
  }

  /// Updates the selected index if [currentIndex] changes.
  @override
  void didUpdateWidget(covariant OudsTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _selectedIndex = widget.currentIndex.clamp(0, widget.items.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(
      context,
      InteractionAspect.hover,
    );
    final interactionModelPressed = OudsInheritedInteractionModel.of(
      context,
      InteractionAspect.pressed,
    );
    final interactionModelFocused = OudsInheritedInteractionModel.of(
      context,
      InteractionAspect.focused,
    );

    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;
    final isFocused = interactionModelFocused?.state.isFocused ?? false;

    final barStateDeterminer = OudsNavigationBarControlStateDeterminer(
      enabled: widget.onTap != null,
      isPressed: isPressed,
      isHovered: isHovered,
      isFocused: isFocused,
    );

    final barControlState = barStateDeterminer.determineControlState();
    final navigationBarModifier = OudsNavigationBarStatusModifier(context);
    final navigationBarBgModifier = OudsNavigationBarBackgroundColorModifier(
      context,
    );
    final navigationBarBorderModifier = OudsNavigationBarBorderModifier(
      context,
    );

    final safeIndex = _selectedIndex.clamp(0, widget.items.length - 1);

    // Get the existing Cupertino theme to avoid overwriting other styles.
    final existingCupertinoTheme = CupertinoTheme.of(context);

    // Build the tab bar with accessibility text scaling constraints.
    // The maxScaleFactor of 1.08 (108%) limits text and icon enlargement to prevent overflow
    // at high zoom levels. At 108%, the 26px icon scales to 28.08px, maintaining proper spacing
    // within the Cupertino tab bar container.
    final tabBar = CupertinoTheme(
      data: existingCupertinoTheme.copyWith(
        textTheme: existingCupertinoTheme.textTheme.copyWith(
          tabLabelTextStyle: OudsTheme.of(context).typographyTokens
              .typeBodyModerateMedium(context)
              .copyWith(fontSize: 10), // Apply the custom text style.
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: navigationBarBorderModifier.getBlurNavigationBar(),
          child: CupertinoTabBar(
            currentIndex: safeIndex,
            activeColor: navigationBarModifier.getTextIconItemColor(
              barControlState,
              true,
            ),
            inactiveColor: navigationBarModifier.getTextIconItemColor(
              barControlState,
              false,
            ),
            border: navigationBarBorderModifier.getBorderNavigationBar(),
            backgroundColor: navigationBarBgModifier.getBackgroundColor(
              widget.translucent,
            ),
            items: List.generate(
              widget.items.length,
              (index) => widget.items[index].toBottomNavigationBarItem(
                context,
                barControlState,
                isSelected: index == safeIndex,
              ),
            ),
            onTap: (index) {
              if (index == safeIndex) return;
              setState(() => _selectedIndex = index);
              widget.onTap?.call(index);
            },
          ),
        ),
      ),
    );

    // Apply accessibility text scaling constraints at the tab bar level to ensure
    // consistent text and icon sizing across all items. This prevents overflow at high zoom levels
    // while maintaining the component's visual hierarchy and positioning.
    return OudsNavigationA11y.withA11yScaling(tabBar);
  }
}
