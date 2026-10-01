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
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';

import '../../helpers/testable_widget_helper.dart';

void main() {
  group('OudsSkeleton', () {
    testWidgets('fills the available space when width/height are omitted', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const SizedBox(width: 200, height: 80, child: OudsSkeleton()),
        ),
      );

      final size = tester.getSize(find.byType(OudsSkeleton));
      expect(size.width, 200);
      expect(size.height, 80);
    });

    testWidgets('animates with a shimmer sweep by default', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const SizedBox(width: 200, height: 80, child: OudsSkeleton()),
        ),
      );

      expect(find.byType(ShaderMask), findsOneWidget);

      // Pumping the animation should not throw and should keep the shader mask mounted.
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(ShaderMask), findsOneWidget);
    });

    testWidgets('renders a static placeholder when animated is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const SizedBox(
            width: 200,
            height: 80,
            child: OudsSkeleton(animated: false),
          ),
        ),
      );

      expect(find.byType(ShaderMask), findsNothing);
    });

    testWidgets(
      'renders a static placeholder when the system requests reduced motion',
      (tester) async {
        await tester.pumpWidget(
          testableWidget(
            MediaQuery(
              data: const MediaQueryData(disableAnimations: true),
              child: const SizedBox(
                width: 120,
                height: 24,
                child: OudsSkeleton(),
              ),
            ),
          ),
        );

        expect(find.byType(ShaderMask), findsNothing);
      },
    );

    testWidgets('is excluded from semantics as a single loading node', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const SizedBox(width: 120, height: 24, child: OudsSkeleton()),
        ),
      );

      expect(find.byType(Semantics), findsWidgets);
      expect(
        find.descendant(
          of: find.byType(OudsSkeleton),
          matching: find.byType(ExcludeSemantics),
        ),
        findsOneWidget,
      );
    });

    testWidgets('disposes its animation controller without error', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const SizedBox(width: 120, height: 24, child: OudsSkeleton()),
        ),
      );

      await tester.pumpWidget(testableWidget(const SizedBox.shrink()));

      expect(tester.takeException(), isNull);
    });
  });
}
