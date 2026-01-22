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
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_enum.dart';

class NavigationBarCodeGenerator {
  /// Entry point – generates the full OudsNavigationBar code
  static String updateCode(BuildContext context) {
    final NavigationBarCustomizationState? state = NavigationBarCustomization.of(context);

    if (state == null) {
      return '// NavigationBarCustomizationState not found';
    }

    final int itemCount = state.itemSelected.clamp(
      NavigationBarCustomizationUtils.minItemCount,
      NavigationBarCustomizationUtils.maxItemCount,
    );

    final String destinationsCode = generateDestinationsCode(
      itemCount: itemCount,
      badgeType: state.selectedItemBadge,
    );

    final List<String> codeParts = [
      'OudsNavigationBar(',
      '  selectedIndex: 0,',
      '  translucent: false,',
      '  destinations: [',
      destinationsCode,
      '  ],',
      '  onDestinationSelected: (index) {',
      '    // Handle destination selection',
      '  },',
      ');',
    ];

    return codeParts.join('\n');
  }

  /// Generates destinations list
  static String generateDestinationsCode({
    required int itemCount,
    required ItemBadge badgeType,
  }) {
    return List.generate(itemCount, (index) {
      final bool isFirstItem = index == 0;

      final List<String> itemParts = [
        '    OudsNavigationBarItem(',
        "      icon: 'assets/ic_heart.svg',",
        "      label: 'Label',",
        if (generateBadgeCode(isFirstItem, badgeType).isNotEmpty) generateBadgeCode(isFirstItem, badgeType),
        '    ),',
      ];

      return itemParts.join('\n');
    }).join('\n');
  }

  /// Generates badge code if needed
  static String generateBadgeCode(bool isFirstItem, ItemBadge badgeType) {
    if (!isFirstItem || badgeType == ItemBadge.none) {
      return '';
    }

    switch (badgeType) {
      case ItemBadge.count:
        return '''
      badge: OudsNavigationBarItemBadge(
        contentDescription: '${NavigationBarCustomizationUtils.itemBadgeCount} notification unread',
        count: ${NavigationBarCustomizationUtils.itemBadgeCount},
      ),''';
      case ItemBadge.standard:
        return '''
      badge: OudsNavigationBarItemBadge(
        contentDescription: 'notification unread',
      ),''';
      case ItemBadge.none:
        return '';
    }
  }
}
