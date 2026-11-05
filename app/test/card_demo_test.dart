import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/card/ouds_action_card.dart';
import 'package:ouds_core/components/card/ouds_card.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/components/components.dart' as catalog;
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/dialog/theme_settings_dialog.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/constants_sheets_bottom.dart';
import 'package:ouds_theme_contract/config/component/ouds_card_config.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange_compact/orange_compact_theme.dart';
import 'package:ouds_theme_sosh/ouds_theme_sosh.dart';
import 'package:ouds_theme_wireframe/ouds_theme_wireframe.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Card rounding defaults to false and notifies only on changes', () {
    final controller = ThemeController(null);
    addTearDown(controller.dispose);
    var notifications = 0;
    controller.addListener(() => notifications++);

    expect(controller.onBorderRadiusCardState, isFalse);
    controller.setOnBorderRadiusCardState(false);
    expect(notifications, 0);
    controller.setOnBorderRadiusCardState(true);
    expect(controller.onBorderRadiusCardState, isTrue);
    expect(notifications, 1);
    controller.setOnBorderRadiusCardState(true);
    expect(notifications, 1);
    controller.setOnBorderRadiusCardState(null);
    expect(controller.onBorderRadiusCardState, isFalse);
    expect(notifications, 2);
    expect(controller.onBorderRadiusCardItemState, isFalse);
  });

  testWidgets('Theme settings apply shared card rounding only on Apply', (
    tester,
  ) async {
    final previousCollapsedHeight = ConstantSheetBottom.collapsedHeight;
    ConstantSheetBottom.collapsedHeight = 110;
    await tester.binding.setSurfaceSize(const Size(600, 1200));
    final controller = ThemeController(null)..setThemeMode(ThemeMode.light);
    late BuildContext demoContext;

    try {
      await tester.pumpWidget(
        _CardDemoApp(
          controller: controller,
          variantIndex: 0,
          onFamilyBuilt: (context, _) => demoContext = context,
        ),
      );
      await tester.pumpAndSettle();

      bool? cardRounded(Type component) => OudsThemeConfigModel.of(
        tester.element(find.byType(component).first),
      )?.card?.rounded;

      expect(cardRounded(OudsCard), isFalse);
      ThemeSettingsDialog.show(demoContext, controller);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rounded corner cards'));
      await tester.pumpAndSettle();
      expect(controller.onBorderRadiusCardState, isFalse);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(cardRounded(OudsCard), isFalse);

      ThemeSettingsDialog.show(demoContext, controller);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rounded corner cards'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();
      expect(controller.onBorderRadiusCardState, isTrue);
      expect(cardRounded(OudsCard), isTrue);
      expect(controller.onBorderRadiusCardItemState, isFalse);

      await tester.pumpWidget(
        _CardDemoApp(
          controller: controller,
          variantIndex: 1,
          onFamilyBuilt: (context, _) => demoContext = context,
        ),
      );
      await tester.pumpAndSettle();
      expect(cardRounded(OudsActionCard), isTrue);
    } finally {
      controller.dispose();
      ConstantSheetBottom.collapsedHeight = previousCollapsedHeight;
      await tester.binding.setSurfaceSize(null);
    }
  });

  testWidgets('Card family is registered and both demos render in all themes', (
    tester,
  ) async {
    final previousCollapsedHeight = ConstantSheetBottom.collapsedHeight;
    ConstantSheetBottom.collapsedHeight = 110;
    await tester.binding.setSurfaceSize(const Size(400, 900));
    final controller = ThemeController(null)..setThemeMode(ThemeMode.light);

    try {
      final themes = [
        OrangeTheme(null),
        OrangeCompactTheme(null),
        SoshTheme(),
        WireframeTheme(),
      ];

      for (final theme in themes) {
        controller.setTheme(theme);

        late Component cardFamily;
        late String expectedFamilyTitle;
        late String expectedContentTitle;
        late String expectedActionTitle;

        await tester.pumpWidget(
          _CardDemoApp(
            controller: controller,
            variantIndex: 0,
            onFamilyBuilt: (context, family) {
              cardFamily = family;
              expectedFamilyTitle = context.l10n.app_components_card_tech;
              expectedContentTitle =
                  context.l10n.app_components_card_contentCard_tech;
              expectedActionTitle =
                  context.l10n.app_components_card_actionCard_tech;
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(cardFamily.title, expectedFamilyTitle);
        expect(cardFamily.variants, hasLength(2));
        expect(cardFamily.variants![0].title, expectedContentTitle);
        expect(cardFamily.variants![1].title, expectedActionTitle);
        expect(find.byType(OudsCard), findsWidgets);
        expect(find.byType(OudsLink), findsWidgets);

        await tester.pumpWidget(
          _CardDemoApp(
            controller: controller,
            variantIndex: 1,
            onFamilyBuilt: (_, family) => cardFamily = family,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(OudsActionCard), findsWidgets);
        expect(find.byType(OudsCard), findsNothing);
      }
    } finally {
      controller.dispose();
      ConstantSheetBottom.collapsedHeight = previousCollapsedHeight;
      await tester.binding.setSurfaceSize(null);
    }
  });
}

class _CardDemoApp extends StatelessWidget {
  const _CardDemoApp({
    required this.controller,
    required this.variantIndex,
    required this.onFamilyBuilt,
  });

  final ThemeController controller;
  final int variantIndex;
  final void Function(BuildContext context, Component family) onFamilyBuilt;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeController>.value(
      value: controller,
      child: MaterialApp(
        theme: controller.themeData,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          OudsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => Consumer<ThemeController>(
          builder: (context, controller, _) => OudsThemeConfigModel(
            card: OudsCardConfig(rounded: controller.onBorderRadiusCardState),
            child: OudsTheme(
              themeContract: controller.currentTheme,
              themeMode: controller.themeMode,
              onColoredSurface: false,
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        ),
        home: Builder(
          builder: (context) {
            final family = catalog
                .components(context)
                .singleWhere(
                  (component) =>
                      component.title == context.l10n.app_components_card_tech,
                );
            onFamilyBuilt(context, family);
            return family.variants![variantIndex].screen;
          },
        ),
      ),
    );
  }
}
