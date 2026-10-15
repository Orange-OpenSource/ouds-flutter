//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/skeleton/internal/ouds_skeleton_layout.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';

import '../../../helpers/testable_widget_helper.dart';

void main() {
  group('OudsSkeletonLayout', () {
    testWidgets('renders the content directly when not visible', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsSkeletonLayout(
            visible: false,
            content: (context) => const Text('content'),
          ),
        ),
      );

      expect(find.text('content'), findsOneWidget);
      expect(find.byType(OudsSkeleton), findsNothing);
    });

    testWidgets('overlays a skeleton matching the content size when visible', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsSkeletonLayout(
            visible: true,
            content: (context) =>
                const SizedBox(width: 150, height: 40, child: Text('x')),
          ),
        ),
      );

      expect(find.byType(OudsSkeleton), findsOneWidget);
      final size = tester.getSize(find.byType(OudsSkeletonLayout));
      expect(size.width, 150);
      expect(size.height, 40);
    });

    testWidgets('hides the content from semantics and touch when visible', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsSkeletonLayout(
            visible: true,
            content: (context) => const SizedBox(
              width: 100,
              height: 30,
              child: Text('hidden content'),
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(OudsSkeletonLayout),
          matching: find.byType(IgnorePointer),
        ),
        findsWidgets,
      );
      expect(
        find.descendant(
          of: find.byType(OudsSkeletonLayout),
          matching: find.byType(ExcludeSemantics),
        ),
        findsWidgets,
      );
    });
  });
}
