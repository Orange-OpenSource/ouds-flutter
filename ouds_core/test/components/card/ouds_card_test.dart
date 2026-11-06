// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/card/internal/ouds_card_surface.dart';
import 'package:ouds_core/components/card/ouds_action_card.dart';
import 'package:ouds_core/components/card/ouds_card.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_core/components/progress_indicator/ouds_progress_indicator.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/config/component/ouds_card_config.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_orange/orange_theme.dart';

Widget _host(
  Widget child, {
  ThemeMode mode = ThemeMode.light,
  TextDirection direction = TextDirection.ltr,
  double textScale = 1,
}) {
  final theme = OrangeTheme();
  return MaterialApp(
    theme: theme.themeData,
    darkTheme: theme.darkThemeData,
    themeMode: mode,
    localizationsDelegates: OudsLocalizations.localizationsDelegates,
    supportedLocales: OudsLocalizations.supportedLocales,
    home: OudsTheme(
      themeContract: theme,
      themeMode: mode,
      onColoredSurface: false,
      child: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: Directionality(
            textDirection: direction,
            child: Scaffold(
              body: Center(child: SizedBox(width: 320, child: child)),
            ),
          ),
        ),
      ),
    ),
  );
}

Material _surface(WidgetTester tester) => tester.widget<Material>(
  find
      .descendant(
        of: find.byType(OudsCardSurface),
        matching: find.byType(Material),
      )
      .first,
);

void main() {
  group('OudsCard', () {
    testWidgets('names the group without merging its content or actions', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      var first = 0;
      var second = 0;
      await tester.pumpWidget(
        _host(
          OudsCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Your current mobile plan'),
                OudsLink(label: 'View plan', onPressed: () => first++),
                OudsLink(label: 'Manage options', onPressed: () => second++),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final group = tester.getSemantics(find.bySemanticsLabel('Manage plan'));
      expect(group.label, 'Manage plan');
      expect(group.flagsCollection.isButton, isFalse);
      expect(group.getSemanticsData().hasAction(SemanticsAction.tap), isFalse);
      expect(find.bySemanticsLabel('Your current mobile plan'), findsOneWidget);
      await tester.tap(find.text('View plan'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Manage options'));
      await tester.pumpAndSettle();
      expect(first, 1);
      expect(second, 1);
      handle.dispose();
    });

    testWidgets('keyboard focus goes to children, never the container', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          OudsCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: () {}, child: const Text('First')),
                TextButton(onPressed: () {}, child: const Text('Second')),
              ],
            ),
          ),
        ),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      final firstButton = tester.element(find.text('First'));
      expect(Focus.of(firstButton).hasFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      final secondButton = tester.element(find.text('Second'));
      expect(Focus.of(secondButton).hasFocus, isTrue);
      expect(find.byType(InkWell), findsNWidgets(2));
    });

    testWidgets('disabled content blocks native pointer and semantic actions', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      var count = 0;
      await tester.pumpWidget(
        _host(
          OudsCard(
            enabled: false,
            child: TextButton(
              onPressed: () => count++,
              child: const Text('View plan'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('View plan'), warnIfMissed: false);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(count, 0);
      final button = tester.getSemantics(find.bySemanticsLabel('View plan'));
      expect(button.getSemanticsData().hasAction(SemanticsAction.tap), isFalse);
      handle.dispose();
    });

    testWidgets('disabled card blocks OUDS actions and restores on re-enable', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      var count = 0;
      Widget card(bool enabled) => _host(
        OudsCard(
          enabled: enabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OudsButton(
                label: 'View plan',
                appearance: OudsButtonAppearance.strong,
                onPressed: () => count++,
              ),
              OudsLink(label: 'Manage options', onPressed: () => count++),
            ],
          ),
        ),
      );
      await tester.pumpWidget(card(false));
      await tester.pumpAndSettle();
      for (final name in ['View plan', 'Manage options']) {
        final node = tester.getSemantics(find.bySemanticsLabel(name));
        expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isFalse);
        await tester.tap(find.text(name), warnIfMissed: false);
      }
      await tester.pumpAndSettle();
      expect(count, 0);
      await tester.pumpWidget(card(true));
      await tester.pumpAndSettle();
      await tester.tap(find.text('View plan'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Manage options'));
      await tester.pumpAndSettle();
      expect(count, 2);
      handle.dispose();
    });

    testWidgets('a nested card cannot re-enable its disabled parent', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(
          OudsCard(
            enabled: false,
            child: OudsActionCard(
              semanticsLabel: 'View plan',
              onPressed: () {},
              child: const SizedBox(height: 100, child: Text('Plan')),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final node = tester.getSemantics(find.bySemanticsLabel('View plan'));
      expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isFalse);
      handle.dispose();
    });

    testWidgets('never shows hover or press feedback', (tester) async {
      await tester.pumpWidget(
        _host(
          const OudsCard(
            child: SizedBox(height: 100, child: Text('Plan')),
          ),
        ),
      );
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer();
      await mouse.moveTo(tester.getCenter(find.byType(OudsCard)));
      await tester.pump();
      expect(find.byType(InkWell), findsNothing);
      expect(find.byType(ColoredBox), findsNothing);
    });
  });

  group('OudsActionCard', () {
    testWidgets(
      'has one named semantic action, with presentation-only slot',
      (tester) async {
        final handle = tester.ensureSemantics();
        var primary = 0;
        var nested = 0;
        await tester.pumpWidget(
          _host(
            OudsActionCard(
              semanticsLabel: 'Activate your eSIM',
              onPressed: () => primary++,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Instructions for activating your eSIM'),
                  OudsButton(
                    label: 'Activate',
                    appearance: OudsButtonAppearance.strong,
                    onPressed: () => nested++,
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final node = tester.getSemantics(
          find.bySemanticsLabel('Activate your eSIM'),
        );
        expect(node.label, 'Activate your eSIM');
        expect(node.flagsCollection.isButton, isTrue);
        expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);
        expect(find.bySemanticsLabel('Activate'), findsNothing);
        expect(
          find.bySemanticsLabel('Instructions for activating your eSIM'),
          findsNothing,
        );

        await tester.tap(find.text('Activate'));
        await tester.pumpAndSettle();
        expect(primary, 1);
        expect(nested, 0);
        tester.binding.performSemanticsAction(
          SemanticsActionEvent(
            type: SemanticsAction.tap,
            viewId: tester.view.viewId,
            nodeId: node.id,
          ),
        );
        await tester.pumpAndSettle();
        expect(primary, 2);
        expect(nested, 0);

        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();
        expect(primary, 3);
        expect(nested, 0);
        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pumpAndSettle();
        expect(primary, 4);
        expect(nested, 0);
        handle.dispose();
      },
      variant: TargetPlatformVariant({
        TargetPlatform.android,
        TargetPlatform.iOS,
      }),
    );

    for (final disabledByCallback in [true, false]) {
      testWidgets(
        'cannot activate when disabled by ${disabledByCallback ? 'callback' : 'flag'}',
        (tester) async {
          final handle = tester.ensureSemantics();
          var count = 0;
          await tester.pumpWidget(
            _host(
              OudsActionCard(
                semanticsLabel: 'View plan',
                enabled: disabledByCallback,
                onPressed: disabledByCallback ? null : () => count++,
                child: const SizedBox(height: 100, child: Text('Plan')),
              ),
            ),
          );
          final node = tester.getSemantics(find.bySemanticsLabel('View plan'));
          expect(node.flagsCollection.isEnabled, isFalse);
          expect(
            node.getSemanticsData().hasAction(SemanticsAction.tap),
            isFalse,
          );
          await tester.tap(find.text('Plan'), warnIfMissed: false);
          await tester.sendKeyEvent(LogicalKeyboardKey.tab);
          await tester.sendKeyEvent(LogicalKeyboardKey.enter);
          await tester.pumpAndSettle();
          expect(count, 0);
          handle.dispose();
        },
      );
    }

    testWidgets('hover, focus and press feedback spans the surface', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          OudsActionCard(
            semanticsLabel: 'View plan',
            onPressed: () {},
            child: const SizedBox(height: 100, child: Text('Plan')),
          ),
        ),
      );
      final context = tester.element(find.byType(OudsActionCard));
      final colors = OudsTheme.of(context).colorScheme(context);
      Finder overlay(Color color) => find.byWidgetPredicate(
        (widget) => widget is ColoredBox && widget.color == color,
      );
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer();
      await mouse.moveTo(tester.getCenter(find.byType(OudsActionCard)));
      await tester.pump();
      expect(overlay(colors.actionSupportHover), findsOneWidget);
      expect(
        tester.getSize(overlay(colors.actionSupportHover)),
        tester.getSize(find.byType(OudsActionCard)),
      );
      await mouse.down(tester.getCenter(find.byType(OudsActionCard)));
      await tester.pump();
      expect(overlay(colors.actionSupportPressed), findsOneWidget);
      await mouse.up();
      await mouse.moveTo(Offset.zero);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      expect(overlay(colors.actionSupportFocus), findsOneWidget);
    });

    testWidgets('loading retains size, announces progress and blocks actions', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      var count = 0;
      Widget card(OudsCardLoader? loader) => _host(
        OudsActionCard(
          semanticsLabel: 'Activate eSIM',
          onPressed: () => count++,
          loader: loader,
          child: const SizedBox(height: 100, child: Text('Activation details')),
        ),
      );
      await tester.pumpWidget(card(null));
      final initialSize = tester.getSize(find.byType(OudsActionCard));
      await tester.pumpWidget(card(const OudsCardLoader(progress: 0.5)));
      await tester.pump();
      expect(tester.getSize(find.byType(OudsActionCard)), initialSize);
      final node = tester.getSemantics(find.bySemanticsLabel('Activate eSIM'));
      expect(node.value, 'Loading, 50 percent');
      expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isFalse);
      expect(node.flagsCollection.isLiveRegion, isTrue);
      expect(find.text('Activation details').hitTestable(), findsNothing);
      await tester.tap(find.byType(OudsActionCard), warnIfMissed: false);
      await tester.pump();
      expect(count, 0);

      await tester.pumpWidget(card(const OudsCardLoader()));
      await tester.pump();
      expect(
        tester.getSemantics(find.bySemanticsLabel('Activate eSIM')).value,
        'Loading',
      );
      final indicator = tester.widget<OudsCircularProgressIndicator>(
        find.byType(OudsCircularProgressIndicator),
      );
      expect(indicator.progressType, OudsProgressIndicatorType.indeterminate);
      await tester.pumpWidget(card(null));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Activation details'));
      await tester.pumpAndSettle();
      expect(count, 1);
      handle.dispose();
    });

    testWidgets('clamps determinate loading progress', (tester) async {
      for (final value in [-0.5, 1.5]) {
        await tester.pumpWidget(
          _host(
            OudsActionCard(
              semanticsLabel: 'Activate eSIM',
              onPressed: () {},
              loader: OudsCardLoader(progress: value),
              child: const SizedBox(height: 100),
            ),
          ),
        );
        final indicator = tester.widget<OudsCircularProgressIndicator>(
          find.byType(OudsCircularProgressIndicator),
        );
        expect(indicator.value, value.clamp(0, 1));
      }
    });

    testWidgets('disabling a loading card takes precedence over its loader', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          OudsActionCard(
            semanticsLabel: 'Activate eSIM',
            enabled: false,
            onPressed: () {},
            loader: const OudsCardLoader(),
            child: const SizedBox(
              height: 100,
              child: Text('Activation details'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(OudsCircularProgressIndicator), findsNothing);
      expect(find.text('Activation details'), findsOneWidget);
    });

    testWidgets('skeleton hides card semantics and interaction', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      var count = 0;
      await tester.pumpWidget(
        _host(
          OudsActionCard(
            semanticsLabel: 'View plan',
            onPressed: () => count++,
            skeleton: const OudsSkeleton(animated: false),
            child: const SizedBox(height: 100, child: Text('Plan')),
          ),
        ),
      );
      await tester.pump();
      expect(find.bySemanticsLabel('View plan'), findsNothing);
      await tester.tap(find.byType(OudsActionCard), warnIfMissed: false);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(count, 0);
      handle.dispose();
    });
  });

  group('Card styles and layout', () {
    for (final actionable in [false, true]) {
      testWidgets('theme config updates rounding for actionable=$actionable', (
        tester,
      ) async {
        final card = actionable
            ? OudsActionCard(
                semanticsLabel: 'Plan',
                onPressed: () {},
                child: const SizedBox(height: 100),
              )
            : const OudsCard(
                child: SizedBox(height: 100),
              );
        BorderRadiusGeometry radius() =>
            (_surface(tester).shape! as RoundedRectangleBorder).borderRadius;
        await tester.pumpWidget(_host(card));
        expect(radius(), BorderRadius.zero);
        for (final rounded in [true, false, null]) {
          await tester.pumpWidget(
            _host(
              OudsThemeConfigModel(
                card: OudsCardConfig(rounded: rounded),
                child: card,
              ),
            ),
          );
          await tester.pumpAndSettle();
          final context = tester.element(find.byType(OudsCardSurface));
          expect(
            radius(),
            BorderRadius.circular(
              rounded == true
                  ? OudsTheme.of(context).borderTokens.radiusLarge
                  : OudsTheme.of(context).borderTokens.radiusNone,
            ),
          );
        }
      });
    }

    for (final mode in [ThemeMode.light, ThemeMode.dark]) {
      for (final style in OudsCardStyle.values) {
        testWidgets('$style in $mode uses theme values and natural height', (
          tester,
        ) async {
          await tester.pumpWidget(
            _host(
              OudsThemeConfigModel(
                card: const OudsCardConfig(rounded: true),
                child: OudsCard(
                  style: style,
                  divider: true,
                  backgroundColor: true,
                  child: const SizedBox(height: 100),
                ),
              ),
              mode: mode,
            ),
          );
          final context = tester.element(find.byType(OudsCard));
          final theme = OudsTheme.of(context);
          final material = _surface(tester);
          expect(
            material.elevation,
            style == OudsCardStyle.elevated
                ? theme.elevationTokens.raised
                : theme.elevationTokens.none,
          );
          expect(
            material.color,
            style == OudsCardStyle.outlined ? Colors.transparent : Colors.blue,
          );
          final shape = material.shape! as RoundedRectangleBorder;
          expect(
            shape.borderRadius,
            BorderRadius.circular(theme.borderTokens.radiusLarge),
          );
          expect(
            shape.side.style,
            style == OudsCardStyle.outlined
                ? BorderStyle.solid
                : BorderStyle.none,
          );
          final divider = find.byWidgetPredicate(
            (widget) =>
                widget is ColoredBox &&
                widget.color == theme.colorScheme(context).borderMuted,
          );
          expect(
            divider,
            style == OudsCardStyle.filled ? findsOneWidget : findsNothing,
          );
          expect(tester.getSize(find.byType(OudsCard)).height, 100);
        });
      }
    }

    testWidgets('supports RTL, landscape and large system text', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        _host(
          OudsActionCard(
            semanticsLabel: 'View your plan',
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('View your mobile plan and available options'),
            ),
          ),
          direction: TextDirection.rtl,
          textScale: 2,
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byType(OudsActionCard)).height,
        greaterThan(48),
      );
    });
  });
}
