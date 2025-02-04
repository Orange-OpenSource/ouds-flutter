/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:ouds_core/components/navigation_bar/ouds_navigation_bar_item.dart';

/// OUDS Navigation Bar.
///
/// The navigation bar displays a list of destinations that can be selected.
/// It highlights the selected destination and calls a callback when a destination is selected.
class OudsNavigationBar extends StatelessWidget {
  /// Creates an ODS Small card.
  const OudsNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.destinations,
    this.onDestinationSelected,
  });

  /// The index of the currently selected destination.
  final int selectedIndex;

  /// The list of destinations to display.
  final List<OudsNavigationItem> destinations;

  /// The callback function called when a destination is selected.
  final void Function(int)? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations,
    );
  }
}
