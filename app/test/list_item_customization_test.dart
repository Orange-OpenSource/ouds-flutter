import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/alert/ouds_alert_message.dart';
import 'package:ouds_core/components/list_item/ouds_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization_panel.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_tabs.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

void main() {
  for (final variant in ListItemDemoVariant.values) {
    testWidgets('rich text banner appears only above text controls for $variant', (
      tester,
    ) async {
      final controller = ThemeController(null);
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: controller,
          child: MaterialApp(
            localizationsDelegates: [
              ...AppLocalizations.localizationsDelegates,
              OudsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: controller.currentTheme.themeData,
            home: OudsTheme(
              themeContract: controller.currentTheme,
              themeMode: ThemeMode.light,
              onColoredSurface: false,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: ListItemCustomization(
                    child: ListItemCustomizationPanel(variant: variant),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final banner = find.byType(OudsAlertMessage);
      expect(banner, findsNothing);
      final tabs = find.byType(CustomizableTabs);

      final tabLabels = tester.widget<CustomizableTabs>(tabs).tabs;
      for (var index = 0; index < tabLabels.length; index++) {
        await tester.tap(find.text(tabLabels[index]));
        await tester.pump();
        final switches = tester.widgetList<CustomizableSwitch>(
          find.byType(CustomizableSwitch),
        );
        expect(
          switches.where((control) =>
              control.title.toLowerCase().contains('rich text') ||
              control.title.toLowerCase().contains('colours to examples')),
          isEmpty,
        );
        if (index == 2) {
          expect(banner, findsOneWidget);
          expect(
            tester.widget<OudsAlertMessage>(banner).label,
            AppLocalizations.of(tester.element(banner))!
                .app_components_listItem_richTextApi_tech,
          );
          expect(
            tester.getBottomLeft(banner).dy,
            lessThanOrEqualTo(
              tester.getTopLeft(find.byType(CustomizableTextField).first).dy,
            ),
          );
        } else {
          expect(banner, findsNothing);
        }
      }

      final context = tester.element(find.byType(ListItemCustomizationPanel));
      final state = ListItemCustomization.of(context)!;
      state.label = 'eSIM activation';
      state.description = 'Your eSIM will be activated on **24 July**';
      final code = switch (variant) {
        ListItemDemoVariant.listItem =>
          ListItemCodeGenerator.updateCode(context, isSmall: false),
        ListItemDemoVariant.smallListItem =>
          ListItemCodeGenerator.updateCode(context, isSmall: true),
        ListItemDemoVariant.cardItem =>
          ListItemCodeGenerator.updateCardCode(context, isSmall: false),
        ListItemDemoVariant.smallCardItem =>
          ListItemCodeGenerator.updateCardCode(context, isSmall: true),
      };
      expect(code, contains("label: OudsListItemText(text: 'eSIM activation')"));
      expect(code, contains(
        "description: OudsListItemText(text: "
        "'Your eSIM will be activated on **24 July**')",
      ));
      expect(code, isNot(contains('.rich(')));

      state.leading = ListItemLeadingEnum.image;
      state.leadingImageRounded = true;
      final imageCode = switch (variant) {
        ListItemDemoVariant.listItem =>
          ListItemCodeGenerator.updateCode(context, isSmall: false),
        ListItemDemoVariant.smallListItem =>
          ListItemCodeGenerator.updateCode(context, isSmall: true),
        ListItemDemoVariant.cardItem =>
          ListItemCodeGenerator.updateCardCode(context, isSmall: false),
        ListItemDemoVariant.smallCardItem =>
          ListItemCodeGenerator.updateCardCode(context, isSmall: true),
      };
      final small = variant == ListItemDemoVariant.smallListItem ||
          variant == ListItemDemoVariant.smallCardItem;
      expect(imageCode, contains(
        '  leading: ${small ? 'OudsSmallListItemLeadingImage' : 'OudsListItemLeadingImage'}(\n'
        "    asset: 'assets/photo.jpg',\n"
        '    rounded: true,\n'
        '  ),',
      ));
      state.leading = ListItemLeadingEnum.none;

      const specialText = "It's \$5\\month\nNext\rTab\t";
      state.label = specialText;
      state.helperText = specialText;
      final escapedCode = switch (variant) {
        ListItemDemoVariant.listItem =>
          ListItemCodeGenerator.updateCode(context, isSmall: false),
        ListItemDemoVariant.smallListItem =>
          ListItemCodeGenerator.updateCode(context, isSmall: true),
        ListItemDemoVariant.cardItem =>
          ListItemCodeGenerator.updateCardCode(context, isSmall: false),
        ListItemDemoVariant.smallCardItem =>
          ListItemCodeGenerator.updateCardCode(context, isSmall: true),
      };
      expect(
        escapedCode,
        contains(r"label: OudsListItemText(text: 'It\'s \$5\\month\nNext\rTab\t')"),
      );
      expect(
        escapedCode,
        contains(r"helperText: OudsListItemText(text: 'It\'s \$5\\month\nNext\rTab')"),
      );
      state.label = 'eSIM activation';
      state.overline = '**Services activated**';
      state.extraLabel = '**Offers available**';
      state.helperText = 'Actions required';
      final colors = OudsTheme.of(context).colorScheme(context);
      final tabsWidget = tester.widget<CustomizableTabs>(tabs);
      await tester.ensureVisible(find.text(tabsWidget.tabs[2]));
      await tester.tap(find.text(tabsWidget.tabs[2]));
      await tester.pump();
      final colorSwitch = find.byWidgetPredicate(
        (widget) => widget is CustomizableSwitch &&
            widget.title == AppLocalizations.of(context)!
                .app_components_listItem_coloredText_tech,
      );
      expect(colorSwitch, findsOneWidget);
      expect(
        tester.widget<CustomizableSwitch>(find.byType(CustomizableSwitch).last)
            .title,
        tester.widget<CustomizableSwitch>(colorSwitch).title,
      );

      for (final enabled in [true, false]) {
        await tester.ensureVisible(colorSwitch);
        await tester.tap(colorSwitch);
        await tester.pump();
        expect(state.coloredText, enabled);
        expect(state.label, 'eSIM activation');
        expect(state.description, 'Your eSIM will be activated on **24 July**');
        expect(state.extraLabel, '**Offers available**');
        expect(state.overline, '**Services activated**');
        expect(state.helperText, 'Actions required');
        final builders = switch (variant) {
          ListItemDemoVariant.listItem => [
            ListItemCustomizationUtils.buildListItem,
            ListItemCustomizationUtils.buildNavigationListItem,
          ],
          ListItemDemoVariant.smallListItem => [
            ListItemCustomizationUtils.buildSmallListItem,
            ListItemCustomizationUtils.buildNavigationSmallListItem,
          ],
          ListItemDemoVariant.cardItem => [
            ListItemCustomizationUtils.buildCardItem,
          ],
          ListItemDemoVariant.smallCardItem => [
            ListItemCustomizationUtils.buildSmallCardItem,
          ],
        };
        for (final builder in builders) {
          final preview = builder(context, state, controller);
          final fields = switch (preview) {
            OudsListItem() => [preview.label, preview.description,
              preview.helperText, preview.overline, preview.extraLabel],
            OudsCardItem() => [preview.label, preview.description,
              preview.helperText, preview.overline, preview.extraLabel],
            OudsSmallListItem() => [preview.label, preview.description,
              preview.helperText],
            OudsSmallCardItem() => [preview.label, preview.description,
              preview.helperText],
            _ => throw StateError('Unexpected preview: $preview'),
          };
          final expected = [
            colors.contentStatusNegative,
            colors.contentStatusWarning,
            null,
            if (fields.length == 5) ...[
              colors.contentStatusPositive,
              colors.contentStatusAccent,
            ],
          ];
          for (var index = 0; index < fields.length; index++) {
            expect(fields[index]!.color, enabled ? expected[index] : null);
          }
        }
        final coloredCode = switch (variant) {
          ListItemDemoVariant.listItem =>
            ListItemCodeGenerator.updateCode(context, isSmall: false),
          ListItemDemoVariant.smallListItem =>
            ListItemCodeGenerator.updateCode(context, isSmall: true),
          ListItemDemoVariant.cardItem =>
            ListItemCodeGenerator.updateCardCode(context, isSmall: false),
          ListItemDemoVariant.smallCardItem =>
            ListItemCodeGenerator.updateCardCode(context, isSmall: true),
        };
        expect(
          coloredCode.contains('colorScheme(context).contentStatusNegative'),
          enabled,
        );
        if (enabled) {
          expect(coloredCode, contains(
            "  label: OudsListItemText(\n"
            "    text: 'eSIM activation',\n"
            "    color: OudsTheme.of(context).colorScheme(context)"
            ".contentStatusNegative,\n"
            "  ),",
          ));
        }
        expect(
          coloredCode.contains('colorScheme(context).contentStatusWarning'),
          enabled,
        );
        expect(
          coloredCode,
          contains("helperText: OudsListItemText(text: 'Actions required'),"),
        );
        if (variant == ListItemDemoVariant.listItem ||
            variant == ListItemDemoVariant.cardItem) {
          expect(
            coloredCode.contains('colorScheme(context).contentStatusPositive'),
            enabled,
          );
          expect(
            coloredCode.contains('colorScheme(context).contentStatusAccent'),
            enabled,
          );
        }
      }
    });
  }
}
