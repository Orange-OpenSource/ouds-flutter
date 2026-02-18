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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/navigation/ouds_navigation_bar.dart';
import 'package:ouds_core/components/navigation/ouds_navigation_bar_item.dart';
import 'package:ouds_core/components/navigation/ouds_tab_bar.dart';

/// Alias for [OudsBottomBar].
///
/// Use this if you prefer a more explicit name that matches Flutter's
/// `BottomNavigationBar` terminology.
typedef OudsBottomNavigationBar = OudsBottomBar;

///
/// **Reference design version: 1.0.0**
///
/// A platform-adaptive OUDS bottom bar.
///
/// This widget renders:
/// - [OudsTabBar] on iOS (backed by Cupertino's [CupertinoTabBar]),
/// - [OudsNavigationBar] on Android (backed by the Material 3 [NavigationBar]).
///
/// It provides a single, shared API so consumers don't have to branch on platform.
///
/// ### Parameters:
/// - [destinations]: The list of [OudsNavigationBarItem] displayed in the bar. These are
///   forwarded to either [OudsTabBar] or [OudsNavigationBar].
/// - [selectedIndex]: The currently selected destination index. This controls which item is
///   highlighted as active.
/// - [translucent]: When true, the underlying implementation renders a translucent (blurred)
///   background; otherwise it renders an opaque background.
/// - [onDestinationSelected]: Called with the tapped destination index. If null, the bar is
///   considered disabled.
///
/// ### Example usage:
///
/// **Using [OudsBottomBar]:**
/// ```dart
///  OudsBottomBar(
///     destinations: [
///       OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home'),
///       OudsNavigationBarItem(icon: 'assets/search.svg', label: 'Search'),
///     ],
///     selectedIndex: selectedIndex,
///     onDestinationSelected: (index) => setState(() => selectedIndex = index),
/// ),
/// ```
///
/// **Using the alias [OudsBottomNavigationBar]:**
/// ```dart
///  OudsBottomNavigationBar(
///     destinations: [
///       OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home'),
///       OudsNavigationBarItem(icon: 'assets/search.svg', label: 'Search'),
///     ],
///     selectedIndex: selectedIndex,
///     onDestinationSelected: (index) => setState(() => selectedIndex = index),
///   ),
/// ```
class OudsBottomBar extends StatelessWidget {
  /// Creates an adaptive OUDS bottom bar.
  const OudsBottomBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    this.translucent = false,
    this.onDestinationSelected,
  });

  /// The list of [OudsNavigationBarItem] to display.
  final List<OudsNavigationBarItem> destinations;

  /// The currently selected destination index.
  final int selectedIndex;

  /// If true, renders a translucent background; otherwise opaque.
  final bool translucent;

  /// Callback triggered when a destination is tapped (returns the tapped index).
  ///
  /// If null, the control is considered disabled.
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return OudsTabBar(
        items: destinations,
        currentIndex: selectedIndex,
        translucent: translucent,
        onTap: onDestinationSelected,
      );
    }

    return OudsNavigationBar(
      destinations: destinations,
      selectedIndex: selectedIndex,
      translucent: translucent,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
