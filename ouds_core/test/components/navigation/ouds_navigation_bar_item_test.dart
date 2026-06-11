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

import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/navigation/ouds_navigation_bar_item.dart';

void main() {
  group('OudsNavigationBarItem API', () {
    test(
      'OudsNavigationBarItem constructor works with required parameters',
      () {
        const item = OudsNavigationBarItem(
          icon: 'assets/test.svg',
          label: 'Test',
        );

        expect(item.icon, 'assets/test.svg');
        expect(item.label, 'Test');
        expect(item.badge, isNull);
      },
    );

    test('OudsNavigationBarItem constructor works with badge', () {
      const badge = OudsNavigationBarItemBadge(
        contentDescription: 'Test Badge',
        count: 5,
      );

      const item = OudsNavigationBarItem(
        icon: 'assets/test.svg',
        label: 'Test',
        badge: badge,
      );

      expect(item.icon, 'assets/test.svg');
      expect(item.label, 'Test');
      expect(item.badge, isNotNull);
      expect(item.badge?.contentDescription, 'Test Badge');
      expect(item.badge?.count, 5);
      expect(item.badge?.hasCount, isTrue);
    });

    test('OudsNavigationBarItemBadge with no count', () {
      const badge = OudsNavigationBarItemBadge(
        contentDescription: 'Test Badge',
      );

      expect(badge.contentDescription, 'Test Badge');
      expect(badge.count, isNull);
      expect(badge.hasCount, isFalse);
    });

    test('OudsNavigationBarItemBadge with count', () {
      const badge = OudsNavigationBarItemBadge(
        contentDescription: 'Test Badge',
        count: 10,
      );

      expect(badge.contentDescription, 'Test Badge');
      expect(badge.count, 10);
      expect(badge.hasCount, isTrue);
    });
  });
}
