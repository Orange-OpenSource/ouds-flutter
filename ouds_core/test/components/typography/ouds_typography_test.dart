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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/typography/ouds_typography.dart';

import '../../helpers/testable_widget_helper.dart';

void main() {
  group('OudsTypography common behavior', () {
    testWidgets('renders the provided text', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsHeadingText(text: 'Hello world')),
      );

      expect(find.text('Hello world'), findsOneWidget);
    });

    testWidgets('applies the color override when provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsBodyText(text: 'Colored text', color: Colors.red),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Colored text'));
      expect(textWidget.textSpan?.style?.color, Colors.red);
    });

    testWidgets('renders bold markdown syntax', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsBodyText(text: 'This is **bold** text')),
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

  group('OudsDisplayText', () {
    testWidgets('defaults to OudsDisplaySize.large', (tester) async {
      const widget = OudsDisplayText(text: 'Display');
      expect(widget.size, OudsDisplayTextSize.large);

      await tester.pumpWidget(testableWidget(widget));
      expect(find.text('Display'), findsOneWidget);
    });

    testWidgets('renders every size without error', (tester) async {
      for (final size in OudsDisplayTextSize.values) {
        await tester.pumpWidget(
          testableWidget(OudsDisplayText(text: 'Display $size', size: size)),
        );
        expect(find.text('Display $size'), findsOneWidget);
      }
    });

    testWidgets('.rich colors only the span wrapped in withColor', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsDisplayText.rich(
            text: buildOudsAnnotatedText((builder) {
              builder.append('Plain ');
              builder.withColor(Colors.red, () => builder.append('Colored'));
            }),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final spans = (textWidget.textSpan! as TextSpan).children!;
      expect((spans[0] as TextSpan).toPlainText(), 'Plain ');
      expect((spans[0] as TextSpan).style?.color, isNot(Colors.red));
      expect((spans[1] as TextSpan).toPlainText(), 'Colored');
      expect((spans[1] as TextSpan).style?.color, Colors.red);
    });
  });

  group('OudsHeadingText', () {
    testWidgets('defaults to OudsHeadingSize.large', (tester) async {
      const widget = OudsHeadingText(text: 'Heading');
      expect(widget.size, OudsHeadingTextSize.large);
    });

    testWidgets('renders every size without error', (tester) async {
      for (final size in OudsHeadingTextSize.values) {
        await tester.pumpWidget(
          testableWidget(OudsHeadingText(text: 'Heading $size', size: size)),
        );
        expect(find.text('Heading $size'), findsOneWidget);
      }
    });
  });

  group('OudsHeadingText marker', () {
    testWidgets('is shown by default for OudsHeadingSize.large', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(const OudsHeadingText(text: 'Heading')),
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('is not shown for sizes other than large', (tester) async {
      for (final size in OudsHeadingTextSize.values.where(
        (s) => s != OudsHeadingTextSize.large,
      )) {
        await tester.pumpWidget(
          testableWidget(OudsHeadingText(text: 'Heading $size', size: size)),
        );
        expect(find.byType(SvgPicture), findsNothing);
      }
    });

    testWidgets('is not shown when marker is set to false', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsHeadingText(text: 'Heading', marker: false)),
      );

      expect(find.byType(SvgPicture), findsNothing);
    });

    testWidgets('is still shown together with .rich colored text', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsHeadingText.rich(
            text: buildOudsAnnotatedText((builder) {
              builder.append('Plain ');
              builder.withColor(Colors.red, () => builder.append('Colored'));
            }),
          ),
        ),
      );

      // The marker follows its own rules, independent of the text content.
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });

  group('OudsHeadingText.rich', () {
    testWidgets('renders every appended span', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          OudsHeadingText.rich(
            text: buildOudsAnnotatedText((builder) {
              builder.append('This is ');
              builder.withColor(
                Colors.red,
                () => builder.append('brand primary text'),
              );
            }),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final spans = (textWidget.textSpan! as TextSpan).children!;
      expect(spans, hasLength(2));
      expect((spans[0] as TextSpan).toPlainText(), 'This is ');
      expect((spans[1] as TextSpan).toPlainText(), 'brand primary text');
    });

    testWidgets('colors only the span wrapped in withColor', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          OudsHeadingText.rich(
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

    testWidgets('restores the previous color after withColor returns', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsHeadingText.rich(
            text: buildOudsAnnotatedText((builder) {
              builder.withColor(Colors.red, () => builder.append('Red'));
              builder.append('Default again');
            }),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final spans = (textWidget.textSpan! as TextSpan).children!;
      expect((spans[0] as TextSpan).style?.color, Colors.red);
      expect((spans[1] as TextSpan).style?.color, isNot(Colors.red));
    });

    testWidgets('also supports bold markdown syntax within a colored span', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsHeadingText.rich(
            text: buildOudsAnnotatedText((builder) {
              builder.withColor(
                Colors.red,
                () => builder.append('**Bold and red**'),
              );
            }),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final outerSpans = (textWidget.textSpan! as TextSpan).children!;
      final innerSpans = (outerSpans[0] as TextSpan).children!;
      final boldSpan = innerSpans.first as TextSpan;
      expect(boldSpan.text, 'Bold and red');
      expect(boldSpan.style?.fontWeight, FontWeight.bold);
      expect(boldSpan.style?.color, Colors.red);
    });
  });

  group('OudsBodyText', () {
    testWidgets('defaults to OudsBodySize.medium and defaultWeight', (
      tester,
    ) async {
      const widget = OudsBodyText(text: 'Body');
      expect(widget.size, OudsBodyTextSize.medium);
      expect(widget.weight, OudsTextWeight.defaultWeight);
    });

    testWidgets('renders every size and weight without error', (tester) async {
      for (final weight in OudsTextWeight.values) {
        for (final size in OudsBodyTextSize.values) {
          await tester.pumpWidget(
            testableWidget(
              OudsBodyText(
                text: 'Body $weight $size',
                size: size,
                weight: weight,
              ),
            ),
          );
          expect(find.text('Body $weight $size'), findsOneWidget);
        }
      }
    });

    testWidgets('.rich colors only the span wrapped in withColor', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsBodyText.rich(
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
