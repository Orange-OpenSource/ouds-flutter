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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/navigation_bars/cupertino_navigation_bar/ouds_cupertino_navigation_bar.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/cupertino_navigation_bar/top_cupertino_navigation_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/cupertino_navigation_bar/top_cupertino_navigation_bar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/cupertino_navigation_bar/top_cupertino_navigation_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';


/// This screen displays an appBar demo and allows customization of appBar properties
class CupertinoNavigationBarDemoScreen extends StatefulWidget {
  const CupertinoNavigationBarDemoScreen({super.key}); // Default value set to false

  @override
  State<CupertinoNavigationBarDemoScreen> createState() => _CupertinoNavigationBarDemoScreenState();
}

class _CupertinoNavigationBarDemoScreenState extends State<CupertinoNavigationBarDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = true;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: TopCupertinoNavigationBarCustomization(
        child: Padding(
          padding: EdgeInsets.only(bottom: Platform.isAndroid ? MediaQuery.of(context).viewPadding.bottom : OudsTheme.of(context).spaceScheme(context).paddingBlockNone),
          child: Scaffold(
            bottomSheet: OudsSheetsBottom(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
            key: _scaffoldKey,
            appBar: MainAppBar(title: context.l10n.app_components_cupertinoNavigationBar_label),
            body: SafeArea(
              child: ExcludeSemantics(
                excluding: !_isBottomSheetExpanded,
                child: _Body(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the radio_button demo and code will be displayed
class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      description: context.l10n.app_components_cupertinoNavigationBar_description_text,
      widget: Column(
        children: [
          _CupertinoNavigationBarDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.bar,
          )
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the navigation bar demo.
class _CupertinoNavigationBarDemo extends StatefulWidget {
  @override
  State<_CupertinoNavigationBarDemo> createState() => __CupertinoNavigationBarDemoState();
}

class __CupertinoNavigationBarDemoState extends State<_CupertinoNavigationBarDemo> {
  ThemeController? themeController;
  String? label;
  TopCupertinoNavigationBarCustomizationState? customizationState;


  @override
  Widget build(BuildContext context) {
    themeController = Provider.of<ThemeController>(context, listen: true);
    customizationState = TopCupertinoNavigationBarCustomization.of(context);

    return Column(
      children: [
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
            child: OudsCupertinoNavigationBar(
             title: customizationState!.titleText,
              backgroundColor: customizationState!.hasBackgroundColor,
              style: TopCupertinoNavigationBarCustomizationUtils.getStyle(customizationState!.selectedType),
              leadingAction:
              OudsCupertinoNavigationBarActionConfig(
                actionType: TopCupertinoNavigationBarCustomizationUtils.getActionType(customizationState!.selectedActionType),
                actionLabel: customizationState!.leadingLabel,
                onActionPressed: (){},
              ),
              trailingAction:
                OudsCupertinoNavigationBarActionConfig(
                  actionType: TopCupertinoNavigationBarCustomizationUtils.getActionType(customizationState!.selectedTrailingActionType),
                  actionLabel: customizationState!.trailingLabel,
                  customIcon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!),
                  onActionPressed: (){},
                ),
            )
        ),
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
            child: OudsCupertinoNavigationBar(
              title: customizationState!.titleText,
              backgroundColor: customizationState!.hasBackgroundColor,
              style: TopCupertinoNavigationBarCustomizationUtils.getStyle(customizationState!.selectedType),
              leadingAction:
              OudsCupertinoNavigationBarActionConfig(
                actionType: TopCupertinoNavigationBarCustomizationUtils.getActionType(customizationState!.selectedActionType),
                actionLabel: customizationState!.leadingLabel,
                onActionPressed: (){},
              ),
              trailingAction:
              OudsCupertinoNavigationBarActionConfig(
                actionType: TopCupertinoNavigationBarCustomizationUtils.getActionType(customizationState!.selectedTrailingActionType),
                actionLabel: customizationState!.trailingLabel,
                customIcon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!),
                onActionPressed: (){},
              ),
            )
        ),
        SizedBox(height: themeController?.currentTheme.spaceScheme(context).fixedSmall),
      ],
    );
  }
}

/// This widget represents the customization content section that appears in the bottom sheet
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the TopNavigationBar
class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode titleFocus;
  late final FocusNode leadingFocus;
  late final FocusNode trailingFocus;

  @override
  void initState() {
    super.initState();
    titleFocus = FocusNode();
    leadingFocus = FocusNode();
    trailingFocus = FocusNode();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    leadingFocus.dispose();
    trailingFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TopCupertinoNavigationBarCustomizationState? customizationState = TopCupertinoNavigationBarCustomization.of(context);
    var navigationActionType = customizationState!.leadingActionTypeState.list;
    var trailingActionType = customizationState.trailingActionTypeState.list;

    var style = customizationState.typeState.list;

    return CustomizableSection(
      children: [
        CustomizableChips<TopCupertinoNavigationBarStyleEnum>(
          title: TopCupertinoNavigationBarStyleEnum.enumName(context),
          options: style,
          selectedOption: customizationState.selectedType,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedType = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_topAppBar_showBackground_label,
          value: customizationState.hasBackgroundColor,
          onChanged: (value) {
            setState(() {
              customizationState.hasBackgroundColor = value;
            });
          },
        ),
        CustomizableChips<TopCupertinoNavigationBarActionTypeEnum>(
          title: TopCupertinoNavigationBarActionTypeEnum.enumName(context),
          options: navigationActionType,
          selectedOption: customizationState.selectedActionType,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedActionType = selectedOption;
            });
          },
        ),
        CustomizableChips<TopCupertinoTrailingBarActionTypeEnum>(
          title: TopCupertinoTrailingBarActionTypeEnum.enumName(context),
          options: trailingActionType,
          selectedOption: customizationState.selectedTrailingActionType,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedTrailingActionType = selectedOption;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_title_label,
          text: customizationState.titleText,
          focusNode: titleFocus,
          fieldType: FieldType.label,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_cupertinoNavigationBar_leadingLabel_label,
          text: customizationState.leadingLabel,
          focusNode: leadingFocus,
          fieldType: FieldType.prefix,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_cupertinoNavigationBar_trailingLabel_label,
          text: customizationState.trailingLabel,
          focusNode: trailingFocus,
          fieldType: FieldType.suffix,
        )
      ],
    );
  }
}
