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
import 'package:ouds_core/components/navigation/OudsNavigationBarItem.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_enum.dart';

class NavigationBarCustomizationUtils {
  static final itemBadgeCount = 1;

  /// Retrieves the count to display based on the current customization state.
  static OudsNavigationBarItemBadge? getItemBadge(NavigationBarCustomizationState customizationState) {
    return customizationState.selectedItemBadge == ItemBadge.count
        ? OudsNavigationBarItemBadge(contentDescription: "$itemBadgeCount notification unread", count: itemBadgeCount)
        : customizationState.selectedItemBadge == ItemBadge.standard
            ? OudsNavigationBarItemBadge(contentDescription: "notification unread")
            : null;
  }
}
