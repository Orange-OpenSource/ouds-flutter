/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:ouds_core/components/navigation/ouds_bottom_bar.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// This screen displays a navigation bar demo and allows customization of NavigationBar properties
class NavigationBarDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const NavigationBarDemoScreen({super.key, this.indeterminate = false}); // Default value set to false

  @override
  State<NavigationBarDemoScreen> createState() => _NavigationBarDemoScreenState();
}

class _NavigationBarDemoScreenState extends State<NavigationBarDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;
  late String previousPageTitle;

  @override
  void initState() {
    super.initState();
    previousPageTitle = Get.arguments?['previousPageTitle'] ?? '';
  }

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarCustomization(
      child: Padding(
        padding: EdgeInsets.only(bottom: defaultTargetPlatform == TargetPlatform.android ? MediaQuery.of(context).viewPadding.bottom : OudsTheme.of(context).spaceScheme(context).paddingBlockNone),
        child: Scaffold(
          bottomSheet: OudsSheetsBottom(
            onExpansionChanged: _onExpansionChanged,
            sheetContent: const _CustomizationContent(),
            title: context.l10n.app_common_customize_label,
          ),
          key: _scaffoldKey,
          appBar: MainAppBar(
              showBackButton: true,
              title: context.l10n.app_components_navigationBar_label,
              previousPageTitle: previousPageTitle,
          ),
          body: SafeArea(
            child: ExcludeSemantics(
              excluding: !_isBottomSheetExpanded,
              child: _Body(),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      description: context.l10n.app_components_navigationBar_description_text,
      widget: Column(
        children: [
          _NavigationBarDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: NavigationBarCodeGenerator.updateCode(
              context,
            ),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.bar,
          )
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the NavigationBar demo.
///
/// Component [_NavigationBarDemo] demonstrates the behavior and functionality of a NavigationBar.
class _NavigationBarDemo extends StatefulWidget {
  @override
  State<_NavigationBarDemo> createState() => _NavigationBarDemoState();
}

class _NavigationBarDemoState extends State<_NavigationBarDemo> {
  ThemeController? themeController;

  NavigationBarCustomizationState? customizationState;
  int _selectedIndex = 0; // 🔥 ÉTAT UNIQUE

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    customizationState = NavigationBarCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: true);
    final items = NavigationBarCustomizationUtils.buildItems(
      themeController: themeController!,
      customizationState: customizationState!,
      itemCount: customizationState!.itemSelected,
    );
    return LightDarkBox(
      child: OudsBottomBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTabSelected,
        translucent: false,
        destinations: items.take(customizationState!.itemSelected).toList(),
      ),
    );
  }
}

/// This widget represents the customization content section that appears in the bottom sheet
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the Badge
class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode labelFocus;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationBarCustomizationState? customizationState = NavigationBarCustomization.of(context);
    var badgeType = customizationState!.itemBadgeState.list;
    return CustomizableSection(
      children: [
        CustomizableChips<int>(
          title: context.l10n.app_components_navigationBar_itemCount_label,
          options: NavigationBarCustomizationUtils.itemCountOptions,
          selectedOption: customizationState.itemSelected,
          getText: (option) => option.toString(),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.itemSelected = selectedOption;
            });
          },
        ),
        CustomizableChips<ItemBadge>(
          title: ItemBadge.enumName(context),
          options: badgeType,
          selectedOption: customizationState.selectedItemBadge,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedItemBadge = selectedOption;
            });
          },
        ),
      ],
    );
  }
}
