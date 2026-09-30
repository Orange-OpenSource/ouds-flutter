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
import 'package:ouds_core/components/typography/ouds_code_text.dart';

import '../../helpers/testable_widget_helper.dart';

void main() {
  group('OudsCodeText common behavior', () {
    testWidgets('renders the provided text', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsCodeText(text: 'const x = 1;')),
      );

      expect(find.text('const x = 1;'), findsOneWidget);
    });

    testWidgets('applies the color override when provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsCodeText(text: 'Colored text', color: Colors.red),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Colored text'));
      expect(textWidget.textSpan?.style?.color, Colors.red);
    });

    testWidgets('uses a monospace font family', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsCodeText(text: 'const x = 1;')),
      );

      final textWidget = tester.widget<Text>(find.text('const x = 1;'));
      expect(textWidget.textSpan?.style?.fontFamily, 'monospace');
    });

    testWidgets('renders bold markdown syntax', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsCodeText(text: 'This is **bold** text')),
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

    testWidgets('.rich colors only the span wrapped in withColor', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsCodeText.rich(
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
