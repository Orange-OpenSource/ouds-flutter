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
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_indicator_animation.dart';

void main() {
  group('OudsAnimatedIndicator', () {
    testWidgets('Indicator displays when selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OudsAnimatedIndicator(
              isSelected: true,
              color: Colors.orange,
              thickness: 4.0,
              tabWidth: 100.0,
              borderRadius: 2.0,
            ),
          ),
        ),
      );

      // Indicator should be rendered
      expect(find.byType(OudsAnimatedIndicator), findsOneWidget);
      // Find CustomPaint within OudsAnimatedIndicator by searching within its context
      expect(
        find.descendant(
          of: find.byType(OudsAnimatedIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Indicator animates from invisible to visible when selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    OudsAnimatedIndicator(
                      key: ValueKey('indicator'),
                      isSelected: true,
                      color: Colors.orange,
                      thickness: 4.0,
                      tabWidth: 100.0,
                      borderRadius: 2.0,
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Animation should start
      expect(find.byType(OudsAnimatedIndicator), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(OudsAnimatedIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );

      // Move time forward to check animation progresses
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(
        find.descendant(
          of: find.byType(OudsAnimatedIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );

      // Complete animation
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
      expect(
        find.descendant(
          of: find.byType(OudsAnimatedIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Indicator animates when selection changes', (
      WidgetTester tester,
    ) async {
      bool isSelected = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    OudsAnimatedIndicator(
                      key: ValueKey('indicator'),
                      isSelected: isSelected,
                      color: Colors.orange,
                      thickness: 4.0,
                      tabWidth: 100.0,
                      borderRadius: 2.0,
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => isSelected = !isSelected);
                      },
                      child: Text('Toggle'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(OudsAnimatedIndicator), findsOneWidget);

      // Tap button to deselect
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    OudsAnimatedIndicator(
                      key: ValueKey('indicator'),
                      isSelected: false,
                      color: Colors.orange,
                      thickness: 4.0,
                      tabWidth: 100.0,
                      borderRadius: 2.0,
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Toggle')),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Animation should reverse
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
      expect(find.byType(OudsAnimatedIndicator), findsOneWidget);
    });

    testWidgets('Multiple indicators expand independently', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                OudsAnimatedIndicator(
                  key: ValueKey('indicator1'),
                  isSelected: true,
                  color: Colors.orange,
                  thickness: 4.0,
                  tabWidth: 80.0,
                  borderRadius: 2.0,
                  animationDuration: const Duration(milliseconds: 300),
                ),
                OudsAnimatedIndicator(
                  key: ValueKey('indicator2'),
                  isSelected: false,
                  color: Colors.orange,
                  thickness: 4.0,
                  tabWidth: 80.0,
                  borderRadius: 2.0,
                  animationDuration: const Duration(milliseconds: 300),
                ),
                OudsAnimatedIndicator(
                  key: ValueKey('indicator3'),
                  isSelected: true,
                  color: Colors.blue,
                  thickness: 4.0,
                  tabWidth: 80.0,
                  borderRadius: 2.0,
                  animationDuration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      );

      // All indicators should be rendered
      expect(find.byType(OudsAnimatedIndicator), findsWidgets);
      // Find CustomPaint widgets only within OudsAnimatedIndicator components
      expect(
        find.descendant(
          of: find.byType(OudsAnimatedIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsWidgets,
      );
    });
  });
}
