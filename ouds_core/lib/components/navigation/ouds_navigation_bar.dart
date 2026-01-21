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
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_modifier.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_core/components/navigation/ouds_navigation_bar_item.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Height of the OUDS Navigation Bar.
const double oudsNavigationBarHeight = 80.0;

/// [OUDS Navigation Bar design guidelines](https://r.orange.fr/r/S-ouds-doc-android-navigation-bar)
///
/// **Reference design version: 1.0.0**
///
/// The OUDS Navigation Bar is a reusable component for switching between
/// top-level views or pages in an application. Each navigation item can
/// include an icon, a label, and optionally a badge. Interaction states
/// such as enabled, hovered, pressed, and focused are supported, and
/// the bar adapts to light and dark themes.
///
/// The bar can be **opaque or translucent**.
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

  /// Initializes the selected index from the widget's [selectedIndex].
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex.clamp(0, widget.destinations.length - 1);
  }

  /// Updates the selected index if [selectedIndex] changes.
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

    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;

    final barStateDeterminer = OudsNavigationBarControlStateDeterminer(
      enabled: widget.onDestinationSelected != null,
      isPressed: isPressed,
      isHovered: isHovered,
    );

    final barControlState = barStateDeterminer.determineControlState();
    final navigationBarModifier = OudsNavigationBarStatusModifier(context);

    final safeIndex = _selectedIndex.clamp(0, widget.destinations.length - 1);

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (states) {
            final isSelected = states.contains(WidgetState.selected);
            return OudsTheme.of(context).typographyTokens.typeLabelDefaultMedium(context).copyWith(color: navigationBarModifier.getTextIconItemColor(barControlState, isSelected));
          },
        ),
      ),
      child: NavigationBar(
        height: oudsNavigationBarHeight,
        selectedIndex: safeIndex,
        indicatorColor: Colors.transparent,
        indicatorShape: const _NoIndicatorShape(),
        backgroundColor: navigationBarModifier.getBackgroundColor(widget.translucent),
        destinations: List.generate(
          widget.destinations.length,
          (index) => widget.destinations[index].build(
            context,
            isSelected: index == safeIndex,
          ),
        ),
        onDestinationSelected: (index) {
          if (index == safeIndex) return;
          setState(() => _selectedIndex = index);
          widget.onDestinationSelected?.call(index);
        },
      ),
    );
  }
}

/// A custom [ShapeBorder] that draws **no indicator** for the NavigationBar.
///
/// Use this to completely hide the selection indicator while keeping
/// label and icon states functional.
class _NoIndicatorShape extends ShapeBorder {
  /// Const constructor for reuse.
  const _NoIndicatorShape();

  /// No extra space for the border.
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  /// Returns an empty outer path.
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path();

  /// Returns an empty inner path.
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  /// Paint nothing, fully invisible.
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // intentionally left blank
  }

  /// Returns a scaled version of this shape. Scaling has no effect.
  @override
  ShapeBorder scale(double t) => const _NoIndicatorShape();
}
