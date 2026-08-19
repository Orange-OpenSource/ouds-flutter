import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/ouds_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_theme_contract/config/component/ouds_card_item_config.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import '../../helpers/testable_widget_helper.dart';

BorderRadius _listItemBorderRadius(WidgetTester tester) {
  final container = tester
      .widgetList<Container>(find.byType(Container))
      .firstWhere(
        (widget) =>
            widget.decoration is BoxDecoration &&
            (widget.decoration! as BoxDecoration).borderRadius != null,
      );

  return (container.decoration! as BoxDecoration).borderRadius! as BorderRadius;
}

void main() {
  group('OudsCardItem', () {
    testWidgets(
      'delegates to OudsListItem with default-size card configuration',
      (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const OudsCardItem(
              label: 'Plan 200 Go',
              overline: 'Mobile',
              extraLabel: 'Sans engagement',
              description: '5G incluse',
              helperText: 'Voir conditions',
              decoration: OudsListItemDecorationOutlined(),
              boldLabel: true,
              enable: false,
            ),
          ),
        );

        final listItem = tester.widget<OudsListItem>(find.byType(OudsListItem));

        expect(listItem.label, 'Plan 200 Go');
        expect(listItem.size, OudsListItemSize.defaultSize);
        expect(listItem.overline, 'Mobile');
        expect(listItem.extraLabel, 'Sans engagement');
        expect(listItem.description, '5G incluse');
        expect(listItem.helperText, 'Voir conditions');
        expect(listItem.boldLabel, isTrue);
        expect(listItem.enable, isFalse);
        expect(listItem.card, isTrue);
        expect(listItem.decoration, isA<OudsListItemDecorationOutlined>());
      },
    );

    testWidgets('is tappable and announced as a button when interactive', (
      tester,
    ) async {
      final semanticsHandle = tester.ensureSemantics();
      var tapCount = 0;

      await tester.pumpWidget(
        testableWidget(
          OudsCardItem(label: 'Voir le détail', onTap: () => tapCount++),
        ),
      );

      expect(find.bySemanticsLabel('Voir le détail'), findsOneWidget);

      await tester.tap(find.text('Voir le détail'));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
      semanticsHandle.dispose();
    });

    testWidgets('renders stacked trailing text without expanding vertically', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsCardItem(
            label: 'Plan 200 Go',
            trailing: OudsListItemTrailingText(
              OudsListItemTrailingLabelAndExtraLabel('99€', 'TTC'),
            ),
          ),
        ),
      );

      final stackedTrailingColumn = tester
          .widgetList<Column>(find.byType(Column))
          .firstWhere(
            (column) =>
                column.crossAxisAlignment == CrossAxisAlignment.end &&
                column.mainAxisSize == MainAxisSize.min &&
                column.children.length == 2 &&
                column.children.every((child) => child is Text),
          );

      expect(stackedTrailingColumn.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('keeps card mode enabled when rounded config is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsThemeConfigModel(
            cardItem: OudsCardItemConfig(rounded: false),
            child: OudsCardItem(label: 'Plan 200 Go'),
          ),
        ),
      );

      final listItem = tester.widget<OudsListItem>(find.byType(OudsListItem));

      expect(listItem.card, isTrue);
    });

    testWidgets('uses the card-item rounded radius from theme config', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsThemeConfigModel(
            cardItem: OudsCardItemConfig(rounded: false),
            child: OudsCardItem(label: 'Plan 200 Go'),
          ),
        ),
      );

      final defaultRadius = _listItemBorderRadius(tester).topLeft.x;

      await tester.pumpWidget(
        testableWidget(
          const OudsThemeConfigModel(
            cardItem: OudsCardItemConfig(rounded: true),
            child: OudsCardItem(label: 'Plan 200 Go'),
          ),
        ),
      );

      final roundedRadius = _listItemBorderRadius(tester).topLeft.x;

      expect(roundedRadius, greaterThan(defaultRadius));
    });
  });

  group('OudsSmallCardItem', () {
    testWidgets(
      'delegates to OudsListItem with restricted small-card content',
      (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const OudsSmallCardItem(
              label: 'Paiement',
              description: 'Facture du mois',
              trailing: OudsSmallListItemTrailingText('99€'),
              decoration: OudsListItemDecorationBackgroundOnInteraction(),
            ),
          ),
        );

        final listItem = tester.widget<OudsListItem>(find.byType(OudsListItem));

        expect(listItem.label, 'Paiement');
        expect(listItem.size, OudsListItemSize.smallSize);
        expect(listItem.description, 'Facture du mois');
        expect(listItem.extraLabel, isNull);
        expect(listItem.card, isTrue);
        expect(
          listItem.decoration,
          isA<OudsListItemDecorationBackgroundOnInteraction>(),
        );
        expect(listItem.trailing, isA<OudsListItemTrailingCustom>());
      },
    );

    testWidgets('is tappable and announced as a button when interactive', (
      tester,
    ) async {
      final semanticsHandle = tester.ensureSemantics();
      var tapCount = 0;

      await tester.pumpWidget(
        testableWidget(
          OudsSmallCardItem(label: 'Détails facture', onTap: () => tapCount++),
        ),
      );

      expect(find.bySemanticsLabel('Détails facture'), findsOneWidget);

      await tester.tap(find.text('Détails facture'));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
      semanticsHandle.dispose();
    });

    testWidgets('uses the card-item rounded radius in small card items', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsThemeConfigModel(
            cardItem: OudsCardItemConfig(rounded: false),
            child: OudsSmallCardItem(label: 'Paiement'),
          ),
        ),
      );

      final defaultRadius = _listItemBorderRadius(tester).topLeft.x;

      await tester.pumpWidget(
        testableWidget(
          const OudsThemeConfigModel(
            cardItem: OudsCardItemConfig(rounded: true),
            child: OudsSmallCardItem(label: 'Paiement'),
          ),
        ),
      );

      final roundedRadius = _listItemBorderRadius(tester).topLeft.x;

      expect(roundedRadius, greaterThan(defaultRadius));
    });
  });
}
