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
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_a11y.dart';
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

class _OudsTabBarState extends State<OudsTabBar> with TickerProviderStateMixin {
  // TickerProviderStateMixin for multiple controllers

  int _selectedIndex = 0;

  /// One AnimationController per tab, managed by the parent to survive rebuilds
  late List<AnimationController> _indicatorControllers;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex.clamp(0, widget.items.length - 1);

    /// Create one controller per tab with correct initial value
    _indicatorControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
        value: index == _selectedIndex
            ? 1.0
            : 0.0, // No animation on first render
      ),
    );
  }

  /// Updates the selected index if [currentIndex] changes.
  @override
  void didUpdateWidget(covariant OudsTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _animateToIndex(widget.currentIndex.clamp(0, widget.items.length - 1));
    }
  }

  /// Animates the indicator from the old selected tab to the new one.
  void _animateToIndex(int newIndex) {
    if (newIndex == _selectedIndex) return;

    // Animate out the previously selected tab
    _indicatorControllers[_selectedIndex].animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    //  Animate in the newly selected tab
    _indicatorControllers[newIndex].animateTo(
      1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  void dispose() {
    //  Dispose all controllers
    for (final controller in _indicatorControllers) {
      controller.dispose();
    }
    super.dispose();
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

    // Cap text scale at 160 % to prevent icon / label / badge overlap at very
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: clampNavBarTextScaler(context)),
      child: CupertinoTheme(
        data: existingCupertinoTheme.copyWith(
          textTheme: existingCupertinoTheme.textTheme.copyWith(
            tabLabelTextStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: OudsTheme.of(context).fontFamily,
            ).copyWith(fontSize: 10, fontWeight: FontWeight.w500),
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
                  index: index,
                  // Pass the external controller for iOS animation
                  externalController: _indicatorControllers[index],
                ),
              ),
              onTap: (index) {
                if (index == safeIndex) return;
                _animateToIndex(index); // Trigger animation from parent
                widget.onTap?.call(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
