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
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_background_modifier.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_border_modifier.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_status_modifier.dart';
import 'package:ouds_core/components/navigation/ouds_navigation_bar_item.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Height of the OUDS Navigation Bar.
const double _oudsNavigationBarHeight = 80.0;

/// [OUDS Navigation Bar design guidelines](https://r.orange.fr/r/S-ouds-doc-android-navigation-bar)
///
/// **Reference design version: 1.0.0**
///
/// The OUDS Navigation Bar is a reusable component for switching between
/// top-level views or pages in an application.
///
/// This widget is backed by the Material 3 [NavigationBar] (Android/Material-style bottom navigation)
/// and expects a list of destination widgets built from OUDS items
/// (see [OudsNavigationBarItem.toNavigationDestination]).
///
/// The bar can be **opaque or translucent**.
/// [OudsNavigationBar] default appearance is opaque but, if you need a translucent blurred as specified on OUDS design side.
/// To do this, use [OudsNavigationBar] with translucent parameter set to true and :
/// * Avoid wrapping the body in a [SafeArea] as the content must scroll behind the [OudsNavigationBar] to be visible through the blur.
/// * Set the [Scaffold.extendBody] property to `true`.
///
/// Example of code:
///
/// ```dart
/// return Scaffold(
///   extendBody: true,
///   bottomNavigationBar: OudsNavigationBar(...),
///   body: MyScrollableContent(),
/// );
/// ```
///
/// ### Parameters:
/// - [destinations]: The list of [OudsNavigationBarItem] to display.
/// - [translucent]: If true, renders a translucent background; otherwise opaque.
/// - [selectedIndex]: The index of the initially selected item.
/// - [onDestinationSelected]: Callback triggered when a destination is tapped, returns the index.
///
/// ### Example usage:
///
/// **Default navigation bar with 3 items:**
/// ```dart
/// OudsNavigationBar(
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
/// **Navigation bar without translucency:**
/// ```dart
/// OudsNavigationBar(
///   destinations: [
///     OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home'),
///     OudsNavigationBarItem(icon: 'assets/search.svg', label: 'Search'),
///   ],
///   selectedIndex: 0,
///   translucent: false,
///   onDestinationSelected: (index) {
///     print('Selected item: $index');
///   },
/// );
/// ```
class OudsNavigationBar extends StatefulWidget {
  /// The list of items displayed in the bar (icons, labels, optional badge).
  final List<OudsNavigationBarItem> destinations;

  /// If true, the navigation bar has a translucent background.
  final bool translucent;

  /// The index of the initially selected item.
  final int selectedIndex;

  /// Callback invoked when a navigation item is tapped.
  final ValueChanged<int>? onDestinationSelected;

  /// Creates an OUDS Navigation Bar with configurable items, transparency, and callbacks.
  const OudsNavigationBar({
    super.key,
    required this.destinations,
    this.translucent = false,
    this.selectedIndex = 0,
    this.onDestinationSelected,
  });

  @override
  State<OudsNavigationBar> createState() => _OudsNavigationBarState();
}

/// State for [OudsNavigationBar], managing selected index and interaction states.
class _OudsNavigationBarState extends State<OudsNavigationBar> {
  /// Tracks the currently selected index.
  int _selectedIndex = 0;

  /// Initializes the selected index from the widget's [currentIndex].
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex.clamp(0, widget.destinations.length - 1);
  }

  /// Updates the selected index if [currentIndex] changes.
  @override
  void didUpdateWidget(covariant OudsNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex.clamp(0, widget.destinations.length - 1);
    }
  }

  /// Builds the navigation bar with dynamic label and icon colors and a custom indicator shape.
  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final interactionModelFocused = OudsInheritedInteractionModel.of(context, InteractionAspect.focused);

    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;
    final isFocused = interactionModelFocused?.state.isFocused ?? false;

    final barStateDeterminer = OudsNavigationBarControlStateDeterminer(
      enabled: widget.onDestinationSelected != null,
      isPressed: isPressed,
      isHovered: isHovered,
      isFocused: isFocused,
    );

    final barControlState = barStateDeterminer.determineControlState();
    final navigationBarModifier = OudsNavigationBarStatusModifier(context);
    final navigationBarBgModifier = OudsNavigationBarBackgroundColorModifier(context);
    final navigationBarBorderModifier = OudsNavigationBarBorderModifier(context);

    final safeIndex = _selectedIndex.clamp(0, widget.destinations.length - 1);

    return ClipRect(
      child: BackdropFilter(
        filter: navigationBarBorderModifier.getBlurNavigationBar(),
        child: Container(
          decoration: BoxDecoration(
            border: navigationBarBorderModifier.getBorderNavigationBar(),
          ),
          child: NavigationBar(
            height: _oudsNavigationBarHeight,
            selectedIndex: safeIndex,
            // `indicatorColor` paints the Material 3 active indicator behind the selected destination.
            indicatorColor: navigationBarModifier.getMaterialIndicatorBarColor(
              barControlState,
              widget.onDestinationSelected != null,
            ),
            // `overlayColor` is the transient ink overlay used for interaction feedback (pressed/hovered/focused),
            // resolved per destination via `WidgetState`.
            overlayColor: WidgetStateProperty.resolveWith<Color>(
              (states) {
                final isSelected = states.contains(WidgetState.selected);
                return navigationBarModifier.getMaterialIndicatorBarColor(barControlState, isSelected);
              },
            ),
            backgroundColor: navigationBarBgModifier.getBackgroundColor(widget.translucent),
            // Label text style resolved per destination via `WidgetState` (at minimum selected/unselected).
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (states) {
                final isSelected = states.contains(WidgetState.selected);
                return OudsTheme.of(context).typographyTokens.typeLabelDefaultMedium(context).copyWith(
                      color: navigationBarModifier.getTextIconItemColor(barControlState, isSelected),
                    );
              },
            ),
            destinations: List.generate(
              widget.destinations.length,
              (index) => widget.destinations[index].toNavigationDestination(
                context,
                barControlState,
                isSelected: index == safeIndex,
              ),
            ),
            onDestinationSelected: (index) {
              if (index == safeIndex) return;
              setState(() => _selectedIndex = index);
              widget.onDestinationSelected?.call(index);
            },
          ),
        ),
      ),
    );
  }
}
