import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/list_item/ouds_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/typography/ouds_label_text.dart';
import 'package:ouds_core/components/utilities/markdown_span_builder.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_orange/orange_theme.dart';

import '../../helpers/testable_widget_helper.dart';

Iterable<TextSpan> _spans(InlineSpan span) sync* {
  if (span is TextSpan) {
    yield span;
    for (final child in span.children ?? <InlineSpan>[]) {
      yield* _spans(child);
    }
  }
}

void main() {
  test('bold-only callers retain their existing style without a scope', () {
    const baseStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
    final text = MarkdownSpanBuilder.buildBoldOnly(
      'Before **date** after',
      baseStyle: baseStyle,
    );
    expect(text.toPlainText(), 'Before date after');
    final spans = _spans(text).toList();
    expect(
      spans.singleWhere((span) => span.text == 'date').style,
      baseStyle.copyWith(fontWeight: FontWeight.bold),
    );
    expect(
      spans.singleWhere((span) => span.text == 'Before ').style,
      baseStyle,
    );
  });

  final variants = <Widget Function(OudsListItemText)>[
    (text) => OudsListItem(
      label: text,
      overline: text,
      extraLabel: text,
      description: text,
      helperText: text,
    ),
    (text) => OudsSmallListItem(
      label: text,
      description: text,
      helperText: text,
    ),
    (text) => OudsCardItem(
      label: text,
      overline: text,
      extraLabel: text,
      description: text,
      helperText: text,
    ),
    (text) => OudsSmallCardItem(
      label: text,
      description: text,
      helperText: text,
    ),
  ];

  for (var index = 0; index < variants.length; index++) {
    for (final mode in [ThemeMode.light, ThemeMode.dark]) {
      testWidgets('variant $index uses the exact strong token in $mode', (
        tester,
      ) async {
        final theme = OrangeTheme();
        await tester.pumpWidget(MaterialApp(
          theme: theme.themeData,
          darkTheme: theme.darkThemeData,
          themeMode: mode,
          home: OudsTheme(
            themeContract: theme,
            themeMode: mode,
            onColoredSurface: false,
            child: Scaffold(
              body: Builder(builder: (context) {
                final color = OudsTheme.of(context)
                    .colorScheme(context).contentStatusPositive;
                return variants[index](OudsListItemText.rich(
                  text: buildOudsAnnotatedText((builder) {
                    builder.append('Before ');
                    builder.withColor(
                      (_) => color,
                      () => builder.append('**24 July**'),
                    );
                    builder.append(' after');
                  }),
                ));
              }),
            ),
          ),
        ));
        final context = tester.element(find.byType(OudsListItem));
        final oudsTheme = OudsTheme.of(context);
        final expected = oudsTheme.typographyTokens
            .typeLabelStrongMedium(context)
            .copyWith(
              color: oudsTheme.colorScheme(context).contentStatusPositive,
            );
        final texts = tester.widgetList<Text>(find.byType(Text));
        expect(texts, hasLength(index == 0 || index == 2 ? 5 : 3));
        for (final (index, text) in texts.indexed) {
          final allowsStrong = index >= texts.length - 2;
          expect(
            text.textSpan!.toPlainText(),
            allowsStrong ? 'Before 24 July after' : 'Before **24 July** after',
          );
          final spans = _spans(text.textSpan!).toList();
          if (!allowsStrong) {
            expect(
              spans.where((span) => span.text == '24 July'),
              isEmpty,
            );
            continue;
          }
          expect(
            spans.singleWhere((span) => span.text == '24 July').style,
            index == texts.length - 1
                ? expected.copyWith(
                    color: oudsTheme.colorScheme(context).contentMuted,
                  )
                : expected,
          );
          expect(spans.every((span) => span.recognizer == null), isTrue);
        }
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('variant $index does not style unsupported Markdown', (
      tester,
    ) async {
      const source = '__**Date**__ ~~old~~ [Help](https://example.com)';
      for (final text in [
        const OudsListItemText(text: source),
        OudsListItemText.rich(
          text: buildOudsAnnotatedText((b) => b.append(source)),
        ),
      ]) {
        await tester.pumpWidget(testableWidget(variants[index](text)));
        final texts = tester.widgetList<Text>(find.byType(Text));
        for (final (index, widget) in texts.indexed) {
          expect(
            widget.textSpan!.toPlainText(),
            index >= texts.length - 2
                ? '__Date__ ~~old~~ [Help](https://example.com)'
                : source,
          );
          for (final span in _spans(widget.textSpan!)) {
            expect(span.style?.decoration, isNot(TextDecoration.underline));
            expect(span.style?.decoration, isNot(TextDecoration.lineThrough));
            expect(span.recognizer, isNull);
          }
        }
      }
    });
  }

  testWidgets('custom slots and other Typography keep their Markdown behavior', (
    tester,
  ) async {
    final openedLinks = <String>[];
    final annotated = buildOudsAnnotatedText(
      (b) => b.append('[Help](https://example.com)'),
    );
    await tester.pumpWidget(testableWidget(Column(
      children: [
        OudsListItem(
          label: const OudsListItemText(text: '[Help](https://example.com)'),
          description: const OudsListItemText(text: '**Date**'),
          belowTextContent: (context, state) =>
              OudsLabelText.rich(
                text: annotated,
                onLinkTap: openedLinks.add,
              ),
        ),
        OudsLabelText.rich(
          text: annotated,
          onLinkTap: openedLinks.add,
        ),
      ],
    )));
    final texts = tester.widgetList<Text>(find.byType(Text)).toList();
    expect(texts[0].textSpan!.toPlainText(), '[Help](https://example.com)');
    for (final text in texts.skip(2)) {
      final link = _spans(text.textSpan!)
          .singleWhere((span) => span.text == 'Help');
      expect(link.style?.decoration, TextDecoration.underline);
      expect(link.recognizer, isNotNull);
    }
    expect(texts, hasLength(4));
    for (final link in find.text('Help', findRichText: true).evaluate()) {
      await tester.tap(find.byWidget(link.widget));
    }
    expect(openedLinks, [
      'https://example.com',
      'https://example.com',
    ]);
  });
}
