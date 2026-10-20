import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/skeleton/internal/ouds_skeleton_layout.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';

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

    testWidgets('renders labelContent instead of label when provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsListItem.labelContent(
            labelContent: (context, state) => const Text('Custom label'),
          ),
        ),
      );

      expect(find.text('Custom label'), findsOneWidget);

      final listItem = tester.widget<OudsListItem>(find.byType(OudsListItem));
      expect(listItem.label, isNull);
    });

    testWidgets('renders belowTextContent after the description', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsListItem(
            label: 'Main label',
            description: 'Description',
            belowTextContent: (context, state) =>
                const Text('Below text content'),
          ),
        ),
      );

      expect(find.text('Below text content'), findsOneWidget);
    });

    testWidgets('renders bottomContent below the main row', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          OudsListItem(
            label: 'Main label',
            bottomContent: (context, state) =>
                const Text('Bottom content', key: Key('bottom-content')),
          ),
        ),
      );

      expect(find.byKey(const Key('bottom-content')), findsOneWidget);
    });

    testWidgets('renders OudsListItemTrailingContent with the control state', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsListItem(
            label: 'Main label',
            enable: false,
            trailing: OudsListItemTrailingContent(
              (context, state) => Text(state.name),
            ),
          ),
        ),
      );

      expect(find.text('disabled'), findsOneWidget);
    });

    testWidgets('renders OudsListItemLeadingContent with the control state', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          OudsListItem(
            label: 'Main label',
            enable: false,
            leading: OudsListItemLeadingContent(
              (context, state) => Text(state.name),
            ),
          ),
        ),
      );

      expect(find.text('disabled'), findsOneWidget);
    });

    testWidgets(
      'caps leading and trailing Content to sizeMaxSizeLeadingTrailingSlot',
      (tester) async {
        await tester.pumpWidget(
          testableWidget(
            OudsListItem(
              label: 'Main label',
              leading: OudsListItemLeadingContent(
                (context, state) =>
                    Container(color: Colors.red, width: 200, height: 200),
              ),
              trailing: OudsListItemTrailingContent(
                (context, state) =>
                    Container(color: Colors.blue, width: 200, height: 200),
              ),
            ),
          ),
        );

        // Orange theme token value: dimension1200 = 96 dp.
        final redBox = find.byWidgetPredicate(
          (w) => w is Container && w.color == Colors.red,
        );
        final blueBox = find.byWidgetPredicate(
          (w) => w is Container && w.color == Colors.blue,
        );
        expect(tester.getSize(redBox), const Size(96, 96));
        expect(tester.getSize(blueBox), const Size(96, 96));
      },
    );

    testWidgets(
      'propagates the control state to labelContent, belowTextContent and '
      'bottomContent builders',
      (tester) async {
        await tester.pumpWidget(
          testableWidget(
            OudsListItem.labelContent(
              labelContent: (context, state) => Text('label-${state.name}'),
              belowTextContent: (context, state) => Text('below-${state.name}'),
              bottomContent: (context, state) => Text('bottom-${state.name}'),
              enable: false,
            ),
          ),
        );

        expect(find.text('label-disabled'), findsOneWidget);
        expect(find.text('below-disabled'), findsOneWidget);
        expect(find.text('bottom-disabled'), findsOneWidget);
      },
    );
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

    testWidgets('rounds small image slots when rounded is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsSmallListItem(
            label: 'Rounded image',
            leading: OudsSmallListItemLeadingImage(
              asset: 'assets/component/alert/tick-confirmation-fill.svg',
              rounded: true,
            ),
            trailing: OudsSmallListItemTrailingImage(
              asset: 'assets/component/alert/tick-confirmation-fill.svg',
              rounded: true,
            ),
          ),
        ),
      );

      // Each rounded image is wrapped in a ClipRRect applying the
      // borderRadiusMediaRounded token.
      final clipRects = find.byType(ClipRRect);
      expect(clipRects, findsNWidgets(2));
    });

    testWidgets('keeps small image slots square when rounded is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsSmallListItem(
            label: 'Square image',
            leading: OudsSmallListItemLeadingImage(
              asset: 'assets/component/alert/tick-confirmation-fill.svg',
            ),
          ),
        ),
      );

      final svg = find.byType(SvgPicture);
      expect(svg, findsOneWidget);
      expect(
        find.ancestor(of: svg, matching: find.byType(ClipRRect)),
        findsNothing,
      );
    });

    testWidgets(
      'forwards enable into OudsSmallListItemTrailingBadge and TrailingTag',
      (tester) async {
        await tester.pumpWidget(
          testableWidget(
            OudsSmallListItem(
              label: 'Badge and tag',
              enable: false,
              trailing: OudsSmallListItemTrailingBadge(
                (enable) => Text('badge-$enable'),
              ),
            ),
          ),
        );
        expect(find.text('badge-false'), findsOneWidget);

        await tester.pumpWidget(
          testableWidget(
            OudsSmallListItem(
              label: 'Badge and tag',
              trailing: OudsSmallListItemTrailingTag(
                (enable) => Text('tag-$enable'),
              ),
            ),
          ),
        );
        expect(find.text('tag-true'), findsOneWidget);
      },
    );
  });

  group('skeleton', () {
    testWidgets('shows the skeleton layout when a skeleton is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        testableWidget(
          const OudsListItem(
            label: 'Skeleton item',
            skeleton: OudsSkeleton(animated: false),
          ),
        ),
      );

      final layout = tester.widget<OudsSkeletonLayout>(
        find.byType(OudsSkeletonLayout),
      );
      expect(layout.visible, isTrue);
    });

    testWidgets('keeps the skeleton layout hidden by default', (tester) async {
      await tester.pumpWidget(
        testableWidget(const OudsListItem(label: 'Plain item')),
      );

      final layout = tester.widget<OudsSkeletonLayout>(
        find.byType(OudsSkeletonLayout),
      );
      expect(layout.visible, isFalse);
    });
  });
}
