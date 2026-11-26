// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/alert/ouds_inline_alert.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/components/component_variants_screen.dart';
import 'package:ouds_flutter_demo/ui/components/components.dart';
import 'package:ouds_flutter_demo/ui/components/components_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/cards/ouds_illustration_component_card.dart';
import 'package:ouds_flutter_demo/ui/utilities/component_life_cycle.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

const draftText =
    'This component is available for use, but its design is not yet finalized.';
const wipText =
    'This component can be used with limited functionality and no breaking change, as its development is not yet complete.';

String expectedAlert(ComponentType type) =>
    switch (ComponentLifeCycle.status(type)) {
      ComponentLifeCycleStatus.draft => draftText,
      ComponentLifeCycleStatus.wip => wipText,
      ComponentLifeCycleStatus.production => '',
    };

Component component(ComponentType type, {bool withVariants = true}) {
  const illustration = SizedBox(key: ValueKey('illustration'), height: 100);
  if (withVariants) {
    return Component.withVariant('Example', illustration, 'Description', type, [
      VariantComponent(
        'Variant',
        const Scaffold(
          body: DetailScreenDescription(description: 'Variant demo'),
        ),
      ),
    ]);
  }
  return Component(
    'Example',
    illustration,
    'Description',
    type,
    const Scaffold(
      body: DetailScreenDescription(
        description: 'Demo description',
        widget: Text('Demo content'),
      ),
    ),
  );
}

Widget testApp(
  ThemeController controller,
  Widget child, {
  String locale = 'en',
}) {
  return ChangeNotifierProvider.value(
    value: controller,
    child: GetMaterialApp(
      theme: controller.themeData,
      locale: Locale(locale),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        OudsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: (context, child) => OudsTheme(
        themeContract: controller.currentTheme,
        themeMode: controller.themeMode,
        onColoredSurface: false,
        child: child!,
      ),
      home: child,
    ),
  );
}

void main() {
  test('classifies design versions and rejects malformed versions', () {
    expect(
      ComponentLifeCycle.fromVersion('0.0.0'),
      ComponentLifeCycleStatus.draft,
    );
    expect(
      ComponentLifeCycle.fromVersion('0.0.1'),
      ComponentLifeCycleStatus.wip,
    );
    expect(
      ComponentLifeCycle.fromVersion('0.12.3'),
      ComponentLifeCycleStatus.wip,
    );
    expect(
      ComponentLifeCycle.fromVersion('1.0.0'),
      ComponentLifeCycleStatus.production,
    );
    expect(
      ComponentLifeCycle.fromVersion('10.0.0'),
      ComponentLifeCycleStatus.production,
    );
    expect(
      () => ComponentLifeCycle.fromVersion('0.invalid.0'),
      throwsFormatException,
    );
    expect(
      ComponentLifeCycle.fromVersions(['1.0.0', '0.1.0', '0.0.0']),
      ComponentLifeCycleStatus.draft,
    );
    expect(
      ComponentLifeCycle.fromVersions(['1.0.0', '0.1.0']),
      ComponentLifeCycleStatus.wip,
    );
    expect(
      ComponentLifeCycle.fromVersions(['1.0.0', '2.1.0']),
      ComponentLifeCycleStatus.production,
    );
    expect(() => ComponentLifeCycle.fromVersions([]), throwsArgumentError);
  });

  testWidgets('cards show the correct tag without hiding it from semantics', (
    tester,
  ) async {
    final controller = ThemeController(null);
    addTearDown(controller.dispose);
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      testApp(
        controller,
        Scaffold(
          body: ComponentsScreen(
            oudsComponents: [
              component(ComponentType.bottomSheet),
              component(ComponentType.listItem),
              component(ComponentType.button),
            ],
          ),
        ),
      ),
    );
    final cards = find.byType(OudsIllustrationComponentCard);
    expect(cards, findsNWidgets(3));
    final types = [
      ComponentType.bottomSheet,
      ComponentType.listItem,
      ComponentType.button,
    ];
    for (var index = 0; index < types.length; index++) {
      final status = ComponentLifeCycle.status(types[index]);
      final tagFinder = find.descendant(
        of: cards.at(index),
        matching: find.byType(OudsTag),
      );
      if (status == ComponentLifeCycleStatus.production) {
        expect(tagFinder, findsNothing);
        continue;
      }
      final tag = tester.widget<OudsTag>(tagFinder);
      final label = status == ComponentLifeCycleStatus.draft ? 'Draft' : 'WIP';
      expect(tag.label, label);
      expect(tag.status, isA<Info>());
      expect(
        tag.appearance,
        status == ComponentLifeCycleStatus.draft
            ? OudsTagAppearance.emphasized
            : OudsTagAppearance.muted,
      );
      expect(tester.getSemantics(tagFinder).label, contains(label));
    }
    semantics.dispose();
  });

  for (final entry in {
    ComponentType.bottomSheet: expectedAlert(ComponentType.bottomSheet),
    ComponentType.listItem: expectedAlert(ComponentType.listItem),
    ComponentType.button: expectedAlert(ComponentType.button),
  }.entries) {
    testWidgets('direct demo shows ${entry.key} lifecycle above description', (
      tester,
    ) async {
      final controller = ThemeController(null);
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        testApp(
          controller,
          Scaffold(
            body: ComponentsScreen(
              oudsComponents: [component(entry.key, withVariants: false)],
            ),
          ),
        ),
      );
      await tester.tap(find.byType(OudsIllustrationComponentCard));
      await tester.pumpAndSettle();
      expect(find.text('Demo description'), findsOneWidget);
      if (entry.value.isEmpty) {
        expect(find.byType(OudsInlineAlert), findsNothing);
      } else {
        final alert = tester.widget<OudsInlineAlert>(
          find.byType(OudsInlineAlert),
        );
        expect(alert.label, entry.value);
        expect(alert.status, isA<Info>());
        expect(
          tester.getBottomLeft(find.byType(OudsInlineAlert)).dy,
          lessThan(tester.getTopLeft(find.text('Demo description')).dy),
        );
      }
    });
  }

  testWidgets('a variant demo does not repeat the lifecycle alert', (
    tester,
  ) async {
    final controller = ThemeController(null);
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      testApp(
        controller,
        Scaffold(
          body: ComponentsScreen(
            oudsComponents: [component(ComponentType.bottomSheet)],
          ),
        ),
      ),
    );
    await tester.tap(find.byType(OudsIllustrationComponentCard));
    await tester.pumpAndSettle();
    final message = expectedAlert(ComponentType.bottomSheet);
    if (message.isEmpty) {
      expect(find.byType(OudsInlineAlert), findsNothing);
    } else {
      expect(find.text(message), findsOneWidget);
    }
    await tester.tap(find.text('Variant'));
    await tester.pumpAndSettle();
    expect(find.text('Variant demo'), findsOneWidget);
    expect(find.byType(OudsInlineAlert), findsNothing);
  });

  for (final locale in ['en', 'fr', 'ar']) {
    for (final entry in {
      ComponentType.bottomSheet: expectedAlert(ComponentType.bottomSheet),
      ComponentType.listItem: expectedAlert(ComponentType.listItem),
      ComponentType.button: expectedAlert(ComponentType.button),
    }.entries) {
      testWidgets('variants ${entry.key} in $locale', (tester) async {
        final controller = ThemeController(null);
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          testApp(
            controller,
            ComponentVariantsScreen(component: component(entry.key)),
            locale: locale,
          ),
        );
        if (entry.value.isEmpty) {
          expect(find.byType(OudsInlineAlert), findsNothing);
        } else {
          final alert = tester.widget<OudsInlineAlert>(
            find.byType(OudsInlineAlert),
          );
          expect(alert.label, entry.value);
          expect(alert.status, isA<Info>());
          expect(
            tester.getBottomLeft(find.byKey(const ValueKey('illustration'))).dy,
            lessThan(tester.getTopLeft(find.byType(OudsInlineAlert)).dy),
          );
          expect(
            tester.getBottomLeft(find.byType(OudsInlineAlert)).dy,
            lessThan(tester.getTopLeft(find.text('Description')).dy),
          );
        }
      });
    }
  }

  testWidgets('registered components use their design version constants', (
    tester,
  ) async {
    final controller = ThemeController(null);
    addTearDown(controller.dispose);
    late List<Component> registered;
    await tester.pumpWidget(
      testApp(
        controller,
        Builder(
          builder: (context) {
            registered = components(context);
            return const SizedBox();
          },
        ),
      ),
    );
    expect(registered, isNotEmpty);
    expect(
      registered.map((item) => item.type).toSet(),
      ComponentType.values.toSet(),
    );
    for (final item in registered) {
      expect(
        ComponentLifeCycle.status(item.type),
        isA<ComponentLifeCycleStatus>(),
      );
    }
  });
}
