import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/typography/ouds_body_text.dart';
import 'package:ouds_core/components/typography/ouds_code_text.dart';
import 'package:ouds_core/components/typography/ouds_display_text.dart';
import 'package:ouds_core/components/typography/ouds_heading_text.dart';
import 'package:ouds_core/components/typography/ouds_label_text.dart';
import 'package:ouds_core/theme/ouds_theme_tweak.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

import '../../helpers/testable_widget_helper.dart';

void main() {
  final plainConstructors = {
    'display': OudsDisplayText.new,
    'heading': OudsHeadingText.new,
    'body': OudsBodyText.new,
    'label': OudsLabelText.new,
    'code': OudsCodeText.new,
  };
  final richConstructors = {
    'display': OudsDisplayText.rich,
    'heading': OudsHeadingText.rich,
    'body': OudsBodyText.rich,
    'label': OudsLabelText.rich,
    'code': OudsCodeText.rich,
  };

  Color positive(BuildContext context) =>
      OudsTheme.of(context).colorScheme(context).contentStatusPositive;

  Color baseColor(Text text) =>
      (text.textSpan?.style?.color ?? text.style?.color)!;

  for (final name in plainConstructors.keys) {
    for (final rich in [false, true]) {
      Widget label({Color? Function(BuildContext)? colorBuilder}) => rich
          ? richConstructors[name]!(
              text: buildOudsAnnotatedText((builder) {
                builder.append('Base ');
                builder.withColor(
                  (context) => OudsTheme.of(
                    context,
                  ).colorScheme(context).contentStatusNegative,
                  () => builder.append('Segment'),
                );
              }),
              colorBuilder: colorBuilder,
            )
          : plainConstructors[name]!(text: 'Base', colorBuilder: colorBuilder);

      testWidgets(
        '$name rich=$rich resolves app callback in each local context',
        (tester) async {
          var calls = 0;
          final child = label(
            colorBuilder: (context) {
              calls++;
              return positive(context);
            },
          );
          await tester.pumpWidget(
            testableWidget(
              Column(
                children: [
                  child,
                  OudsThemeTweak(
                    tweak: OudsThemeTweakType.invert,
                    child: child,
                  ),
                ],
              ),
            ),
          );
          final texts = find.byType(Text);
          expect(calls, 2);
          expect(texts, findsNWidgets(2));
          final colors = <Color>[];
          for (final element in texts.evaluate()) {
            final text = element.widget as Text;
            expect(baseColor(text), positive(element));
            colors.add(baseColor(text));
            if (rich) {
              final spans = (text.textSpan! as TextSpan).children!;
              expect(spans.first.style?.color, positive(element));
              expect(
                spans.last.style?.color,
                OudsTheme.of(
                  element,
                ).colorScheme(element).contentStatusNegative,
              );
            }
          }
          expect(colors.first, isNot(colors.last));
        },
      );

      testWidgets('$name rich=$rich resolves fixed colors and null fallbacks', (
        tester,
      ) async {
        for (final builder in <Color? Function(BuildContext)?>[
          null,
          (_) => null,
          (_) => Colors.red,
        ]) {
          await tester.pumpWidget(testableWidget(label(colorBuilder: builder)));
          final context = tester.element(find.byType(Text));
          expect(
            baseColor(tester.widget<Text>(find.byType(Text))),
            builder?.call(context) ??
                OudsTheme.of(context).colorScheme(context).contentDefault,
          );
        }
      });

      testWidgets(
        '$name rich=$rich updates reused text when local theme changes',
        (tester) async {
          final child = label(colorBuilder: positive);
          final colors = <Color>[];
          for (final tweak in [
            OudsThemeTweakType.forceLight,
            OudsThemeTweakType.forceDark,
          ]) {
            await tester.pumpWidget(
              testableWidget(OudsThemeTweak(tweak: tweak, child: child)),
            );
            final context = tester.element(find.byType(Text));
            final color = baseColor(tester.widget<Text>(find.byType(Text)));
            expect(color, positive(context));
            colors.add(color);
          }
          expect(colors.first, isNot(colors.last));
        },
      );
    }
  }
}
