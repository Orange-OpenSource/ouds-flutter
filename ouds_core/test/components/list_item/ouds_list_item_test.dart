import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';

import '../../helpers/testable_widget_helper.dart';

void main() {
  group('OudsListItemIconSize', () {
    test(
      'exposes exactly the medium and large sizes for default-size items',
      () {
        // Default-size list/card items support two icon sizes only.
        expect(OudsListItemIconSize.values, [
          OudsListItemIconSize.medium,
          OudsListItemIconSize.large,
        ]);
      },
    );
  });

  group('OudsListItemImageSize', () {
    test(
      'exposes exactly the medium, large and extraLarge sizes for default-size items',
      () {
        // Default-size list/card items support three image sizes only.
        expect(OudsListItemImageSize.values, [
          OudsListItemImageSize.medium,
          OudsListItemImageSize.large,
          OudsListItemImageSize.extraLarge,
        ]);
      },
    );
  });

  group('OudsListItem', () {
    testWidgets('keeps the provided configuration', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsListItem(
            label: 'Main label',
            overline: 'Category',
            extraLabel: 'Strong info',
            description: 'Additional detail',
            trailing: OudsListItemTrailingText(
              OudsListItemTrailingLabel('99€'),
            ),
            helperText: 'Helper text',
            boldLabel: true,
            enable: false,
            decoration: OudsListItemDecorationOutlined(),
          ),
        ),
      );

      final listItem = tester.widget<OudsListItem>(find.byType(OudsListItem));

      expect(listItem.label, 'Main label');
      expect(listItem.size, OudsListItemSize.defaultSize);
      expect(listItem.overline, 'Category');
      expect(listItem.extraLabel, 'Strong info');
      expect(listItem.description, 'Additional detail');
      expect(listItem.helperText, 'Helper text');
      expect(listItem.boldLabel, isTrue);
      expect(listItem.enable, isFalse);
      expect(listItem.card, isFalse);
      expect(listItem.decoration, isA<OudsListItemDecorationOutlined>());
    });

    testWidgets('is tappable and announced as a button when interactive', (
      tester,
    ) async {
      final semanticsHandle = tester.ensureSemantics();
      var tapCount = 0;

      await tester.pumpWidget(
        testableWidget(
          OudsListItem(label: 'Navigate', onTap: () => tapCount++),
        ),
      );

      expect(find.bySemanticsLabel('Navigate'), findsOneWidget);

      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
      semanticsHandle.dispose();
    });

    testWidgets('hides the leading slot when the Previous indicator is shown', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsListItem(
            label: 'Back',
            leading: OudsListItemLeadingIcon(Positive()),
            indicator: const OudsListItemIndicatorPrevious(),
            onTap: () {},
          ),
        ),
      );

      // The leading icon must not be rendered: the Previous indicator
      // takes over the start slot exclusively.
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });

  group('OudsSmallListItem', () {
    testWidgets(
      'delegates to OudsListItem with restricted small-item content',
      (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const OudsSmallListItem(
              label: 'Compact item',
              description: 'Secondary text',
              trailing: OudsSmallListItemTrailingText('99€'),
              decoration: OudsListItemDecorationBackgroundOnInteraction(),
            ),
          ),
        );

        final listItem = tester.widget<OudsListItem>(find.byType(OudsListItem));

        expect(listItem.label, 'Compact item');
        expect(listItem.size, OudsListItemSize.smallSize);
        expect(listItem.description, 'Secondary text');
        expect(listItem.overline, isNull);
        expect(listItem.extraLabel, isNull);
        expect(listItem.card, isFalse);
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
          OudsSmallListItem(label: 'Compact navigate', onTap: () => tapCount++),
        ),
      );

      expect(find.bySemanticsLabel('Compact navigate'), findsOneWidget);

      await tester.tap(find.text('Compact navigate'));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
      semanticsHandle.dispose();
    });

    testWidgets(
      'always renders leading/trailing icons at the single small size',
      (tester) async {
        // OudsSmallListItem has no icon-size parameter: leading and trailing
        // icons must render identically regardless of status.
        await tester.pumpWidget(
          testableWidget(
            OudsSmallListItem(
              label: 'Compact icons',
              leading: OudsSmallListItemLeadingIcon(Positive()),
              trailing: OudsSmallListItemTrailingIcon(Negative()),
            ),
          ),
        );

        final sizes = tester
            .widgetList<SvgPicture>(find.byType(SvgPicture))
            .map((w) => w.width)
            .toSet();

        expect(
          sizes.length,
          1,
          reason: 'leading and trailing icons must share the same fixed size',
        );
      },
    );
  });
}
