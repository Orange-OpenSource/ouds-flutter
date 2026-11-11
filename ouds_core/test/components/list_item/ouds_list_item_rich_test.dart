import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/list_item/ouds_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/typography/ouds_label_text.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

import '../../helpers/testable_widget_helper.dart';

void main() {
  testWidgets('disabled items override field and segment colors', (tester) async {
    for (var index = 0; index < 4; index++) {
      await tester.pumpWidget(testableWidget(
        Builder(builder: (context) {
          final colors = OudsTheme.of(context).colorScheme(context);
          final text = OudsListItemText.rich(
            color: colors.contentStatusNegative,
            text: buildOudsAnnotatedText((builder) {
              builder.append('Before ');
              builder.withColor(
                (_) => colors.contentStatusPositive,
                () => builder.append('**date**'),
              );
            }),
          );
          return switch (index) {
            0 => OudsListItem(
              label: text, overline: text, extraLabel: text,
              description: text, helperText: text, enable: false,
            ),
            1 => OudsSmallListItem(
              label: text, description: text, helperText: text, enable: false,
            ),
            2 => OudsCardItem(
              label: text, overline: text, extraLabel: text,
              description: text, helperText: text, enable: false,
            ),
            _ => OudsSmallCardItem(
              label: text, description: text, helperText: text, enable: false,
            ),
          };
        }),
      ));
      final context = tester.element(find.byType(OudsListItem));
      final disabled = OudsTheme.of(context).colorScheme(context).contentDisabled;
      void check(InlineSpan span) {
        if (span is TextSpan) {
          expect(span.style?.color, disabled);
          for (final child in span.children ?? <InlineSpan>[]) {
            check(child);
          }
        }
      }
      for (final text in tester.widgetList<Text>(find.byType(Text))) {
        check(text.textSpan!);
      }
    }
  });

  testWidgets('helper and description preserve annotation boundaries', (
    tester,
  ) async {
    final text = OudsListItemText.rich(
      text: buildOudsAnnotatedText((builder) {
        builder.append('**split');
        builder.append(' emphasis**');
      }),
    );
    await tester.pumpWidget(testableWidget(OudsListItem(
      label: const OudsListItemText(text: 'Title'),
      description: text,
      helperText: text,
    )));
    final texts = tester.widgetList<Text>(find.byType(Text)).toList();
    expect(texts[1].textSpan!.toPlainText(), '**split emphasis**');
    expect(texts[2].textSpan!.toPlainText(), '**split emphasis**');
  });

  test('plain descriptors preserve source Markdown and default color', () {
    const text = OudsListItemText(text: 'Activated on **24 July**');
    expect(text.text.plainText, 'Activated on **24 July**');
    expect(text.color, isNull);
  });

  test('rich descriptors reuse the supplied annotations', () {
    final annotated = buildOudsAnnotatedText((builder) {
      builder.append('Activated on ');
      builder.append('**24 July**');
    });
    final text = OudsListItemText.rich(text: annotated);
    expect(text.text, same(annotated));
    expect(text.text.plainText, 'Activated on **24 July**');
    expect(text.color, isNull);
  });

  OudsListItemText text(String value, [Color? color]) => OudsListItemText.rich(
    text: buildOudsAnnotatedText((b) => b.append(value)),
    color: color,
  );

  final variants = <Widget Function(Color?, Color?, Color?)>[
    (label, description, helper) => OudsListItem(
      label: text('eSIM activation', label),
      description: text('Your eSIM will be activated on **24 July**', description),
      helperText: text('Actions required', helper),
    ),
    (label, description, helper) => OudsSmallListItem(
      label: text('eSIM activation', label),
      description: text('Your eSIM will be activated on **24 July**', description),
      helperText: text('Actions required', helper),
    ),
    (label, description, helper) => OudsCardItem(
      label: text('eSIM activation', label),
      description: text('Your eSIM will be activated on **24 July**', description),
      helperText: text('Actions required', helper),
    ),
    (label, description, helper) => OudsSmallCardItem(
      label: text('eSIM activation', label),
      description: text('Your eSIM will be activated on **24 July**', description),
      helperText: text('Actions required', helper),
    ),
  ];

  const plainVariants = <Widget>[
    OudsListItem(label: OudsListItemText(text: 'Original label')),
    OudsSmallListItem(label: OudsListItemText(text: 'Original label')),
    OudsCardItem(label: OudsListItemText(text: 'Original label')),
    OudsSmallCardItem(label: OudsListItemText(text: 'Original label')),
  ];

  for (var index = 0; index < variants.length; index++) {
    testWidgets('helper colors are ignored for variant $index', (tester) async {
      await tester.pumpWidget(testableWidget(
        Builder(builder: (context) {
          final colors = OudsTheme.of(context).colorScheme(context);
          final helper = OudsListItemText.rich(
            color: colors.contentStatusNegative,
            text: buildOudsAnnotatedText((builder) {
              builder.append('Complete ');
              builder.withColor(
                (_) => colors.contentStatusPositive,
                () => builder.append('**this step**'),
              );
            }),
          );
          return switch (index) {
            0 => OudsListItem(
              label: const OudsListItemText(text: 'Title'),
              helperText: helper,
            ),
            1 => OudsSmallListItem(
              label: const OudsListItemText(text: 'Title'),
              helperText: helper,
            ),
            2 => OudsCardItem(
              label: const OudsListItemText(text: 'Title'),
              helperText: helper,
            ),
            _ => OudsSmallCardItem(
              label: const OudsListItemText(text: 'Title'),
              helperText: helper,
            ),
          };
        }),
      ));
      final context = tester.element(find.byType(OudsListItem));
      final colors = OudsTheme.of(context).colorScheme(context);
      final helper = tester.widgetList<OudsLabelText>(
        find.byType(OudsLabelText),
      ).last;
      expect(helper.color, colors.contentMuted);
      final rendered = tester.widgetList<Text>(find.byType(Text))
          .singleWhere(
            (text) => text.textSpan?.toPlainText() == 'Complete this step',
          );
      void checkColors(InlineSpan span) {
        if (span is TextSpan) {
          expect(span.style?.color, colors.contentMuted);
          if (span.text == 'this step') {
            expect(
              span.style,
              OudsTheme.of(context).typographyTokens
                  .typeLabelStrongMedium(context)
                  .copyWith(color: colors.contentMuted),
            );
          }
          for (final child in span.children ?? <InlineSpan>[]) {
            checkColors(child);
          }
        }
      }
      checkColors(rendered.textSpan!);
    });

    testWidgets('rich text and per-field colors forward for variant $index', (
      tester,
    ) async {
      late Color labelColor;
      late Color descriptionColor;
      late Color helperColor;
      late Color mutedColor;
      await tester.pumpWidget(
        testableWidget(
          Builder(builder: (context) {
            final colors = OudsTheme.of(context).colorScheme(context);
            labelColor = colors.contentStatusNegative;
            descriptionColor = colors.contentStatusPositive;
            helperColor = colors.contentStatusWarning;
            mutedColor = colors.contentMuted;
            return variants[index](labelColor, descriptionColor, helperColor);
          }),
        ),
      );
      final labels = tester.widgetList<OudsLabelText>(
        find.byType(OudsLabelText),
      ).toList();
      expect(labels.map((label) => label.color), [
        labelColor,
        descriptionColor,
        mutedColor,
      ]);
      expect(find.text('eSIM activation', findRichText: true), findsOneWidget);
      expect(find.text(
        'Your eSIM will be activated on 24 July',
        findRichText: true,
      ), findsOneWidget);
      expect(find.text('Actions required', findRichText: true), findsOneWidget);

      await tester.pumpWidget(testableWidget(variants[index](null, null, null)));
      final context = tester.element(find.byType(OudsListItem));
      final colors = OudsTheme.of(context).colorScheme(context);
      final defaults = tester.widgetList<OudsLabelText>(
        find.byType(OudsLabelText),
      ).toList();
      expect(defaults.map((label) => label.color), [
        colors.contentDefault,
        colors.contentMuted,
        colors.contentMuted,
      ]);
      expect(find.text(
        'Your eSIM will be activated on 24 July',
        findRichText: true,
      ), findsOneWidget);

      await tester.pumpWidget(testableWidget(plainVariants[index]));
      expect(find.text('Original label', findRichText: true), findsOneWidget);
      expect(find.text('eSIM activation', findRichText: true), findsNothing);
      expect(find.text('Actions required', findRichText: true), findsNothing);
      expect(tester.widgetList<OudsLabelText>(
        find.byType(OudsLabelText),
      ), hasLength(1));
    });
  }

  testWidgets('full-size items preserve all field styles and colors', (
    tester,
  ) async {
    for (final isCard in [false, true]) {
      late List<Color> expectedColors;
      await tester.pumpWidget(testableWidget(
        Builder(builder: (context) {
          final colors = OudsTheme.of(context).colorScheme(context);
          expectedColors = [
            colors.contentStatusWarning,
            colors.contentStatusNegative,
            colors.contentStatusPositive,
            colors.contentBrandPrimary,
            colors.contentMuted,
          ];
          if (isCard) {
            return OudsCardItem(
              overline: text('Overline', expectedColors[0]),
              label: text('Payment problems', expectedColors[1]),
              extraLabel: text('Offers available', expectedColors[2]),
              description: text('Orange Fibre services', expectedColors[3]),
              helperText: text('Actions required', expectedColors[4]),
              boldLabel: true,
            );
          }
          return OudsListItem(
            overline: text('Overline', expectedColors[0]),
            label: text('Payment problems', expectedColors[1]),
            extraLabel: text('Offers available', expectedColors[2]),
            description: text('Orange Fibre services', expectedColors[3]),
            helperText: text('Actions required', expectedColors[4]),
            boldLabel: true,
          );
        }),
      ));
      final labels = tester.widgetList<OudsLabelText>(
        find.byType(OudsLabelText),
      ).toList();
      expect(labels.map((label) => label.color), expectedColors);
      expect(labels.map((label) => label.size), [
        OudsLabelTextSize.small,
        OudsLabelTextSize.large,
        OudsLabelTextSize.medium,
        OudsLabelTextSize.medium,
        OudsLabelTextSize.medium,
      ]);
      expect(labels.map((label) => label.weight), [
        OudsTextWeight.moderate,
        OudsTextWeight.strong,
        OudsTextWeight.strong,
        OudsTextWeight.defaultWeight,
        OudsTextWeight.defaultWeight,
      ]);
    }
  });

  testWidgets('single public fields forward plain text and colors unchanged', (
    tester,
  ) async {
    late OudsListItemText label;
    late OudsListItemText description;
    final builders = <Widget Function()>[
      () => OudsListItem(label: label, description: description),
      () => OudsSmallListItem(label: label, description: description),
      () => OudsCardItem(label: label, description: description),
      () => OudsSmallCardItem(label: label, description: description),
    ];
    for (final build in builders) {
      await tester.pumpWidget(testableWidget(
        Builder(builder: (context) {
          final colors = OudsTheme.of(context).colorScheme(context);
          label = OudsListItemText(
            text: 'Services activated',
            color: colors.contentStatusPositive,
          );
          description = const OudsListItemText(
            text: 'Your eSIM will be activated on **24 July**',
          );
          return build();
        }),
      ));
      final item = tester.widget<OudsListItem>(find.byType(OudsListItem));
      expect(item.label, same(label));
      expect(item.description, same(description));
      final labels = tester.widgetList<OudsLabelText>(
        find.byType(OudsLabelText),
      ).toList();
      expect(labels.first.color, label.color);
      expect(find.text('Services activated', findRichText: true), findsOneWidget);
      expect(find.text(
        'Your eSIM will be activated on 24 July',
        findRichText: true,
      ), findsOneWidget);
    }
  });

  testWidgets('empty optional plain and annotated fields are omitted', (
    tester,
  ) async {
    final emptyFields = [
      const OudsListItemText(text: ''),
      OudsListItemText.rich(text: buildOudsAnnotatedText((b) {})),
      OudsListItemText.rich(text: buildOudsAnnotatedText((b) {
        b.append('');
        b.append('');
      })),
    ];
    for (final empty in emptyFields) {
      await tester.pumpWidget(testableWidget(
        OudsListItem(
          label: const OudsListItemText(text: 'Title'),
          description: empty,
          extraLabel: empty,
          helperText: empty,
        ),
      ));
      expect(tester.widgetList<OudsLabelText>(
        find.byType(OudsLabelText),
      ), hasLength(1));
    }
  });

  testWidgets('custom label content keeps its original text fields', (
    tester,
  ) async {
    for (final item in <Widget>[
      OudsListItem.labelContent(
        labelContent: (context, state) => const Text('Custom label'),
        description: OudsListItemText(text: 'Original description'),
        overline: OudsListItemText(text: 'Overline'),
        extraLabel: OudsListItemText(text: 'Extra'),
      ),
      OudsCardItem.labelContent(
        labelContent: (context, state) => const Text('Custom label'),
        description: OudsListItemText(text: 'Original description'),
        overline: OudsListItemText(text: 'Overline'),
        extraLabel: OudsListItemText(text: 'Extra'),
      ),
    ]) {
      await tester.pumpWidget(testableWidget(item));
      expect(find.text('Custom label'), findsOneWidget);
      expect(find.text('Original description', findRichText: true), findsOneWidget);
      expect(find.text('Overline', findRichText: true), findsOneWidget);
      expect(find.text('Extra', findRichText: true), findsOneWidget);
    }
  });
}
