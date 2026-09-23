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
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/typography/ouds_body_text.dart'
    show OudsTextWeight;
import 'package:ouds_core/components/typography/ouds_label_text.dart';

import '../../helpers/testable_widget_helper.dart';

void main() {
  group('OudsLabelText common behavior', () {
    testWidgets('renders the provided text', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsLabelText(text: 'Hello world')),
      );

      expect(find.text('Hello world'), findsOneWidget);
    });

    testWidgets('applies the color override when provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsLabelText(text: 'Colored text', color: Colors.red),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Colored text'));
      expect(textWidget.textSpan?.style?.color, Colors.red);
    });

    testWidgets('renders bold markdown syntax', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsLabelText(text: 'This is **bold** text')),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final wrapper =
          (textWidget.textSpan! as TextSpan).children!.single as TextSpan;
      final boldSpan =
          wrapper.children!.firstWhere(
                (span) => (span as TextSpan).text == 'bold',
              )
              as TextSpan;
      expect(boldSpan.style?.fontWeight, FontWeight.bold);
    });
  });

  group('OudsLabelText', () {
    testWidgets('defaults to OudsLabelSize.medium and defaultWeight', (
      tester,
    ) async {
      const widget = OudsLabelText(text: 'Label');
      expect(widget.size, OudsLabelTextSize.medium);
      expect(widget.weight, OudsTextWeight.defaultWeight);
    });

    testWidgets('renders every size and weight without error', (tester) async {
      for (final weight in OudsTextWeight.values) {
        for (final size in OudsLabelTextSize.values) {
          await tester.pumpWidget(
            testableWidget(
              OudsLabelText(
                text: 'Label $weight $size',
                size: size,
                weight: weight,
              ),
            ),
          );
          expect(find.text('Label $weight $size'), findsOneWidget);
        }
      }
    });

    testWidgets('.rich colors only the span wrapped in withColor', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsLabelText.rich(
            text: buildOudsAnnotatedText((builder) {
              builder.append('Plain ');
              builder.withColor(Colors.red, () => builder.append('Colored'));
            }),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final spans = (textWidget.textSpan! as TextSpan).children!;
      expect((spans[0] as TextSpan).style?.color, isNot(Colors.red));
      expect((spans[1] as TextSpan).style?.color, Colors.red);
    });
  });
}
