
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
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/toolbar_top_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_appbar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';

/// This screen displays an appBar demo and allows customization of appBar properties
class TopBarDemoScreen extends StatefulWidget {
  const TopBarDemoScreen({super.key}); // Default value set to false

  @override
  State<TopBarDemoScreen> createState() => _TopBarDemoScreenState();
}

class _TopBarDemoScreenState extends State<TopBarDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = true;
  late String previousTitle;

  @override
  void initState() {
    super.initState();
    previousTitle = Get.arguments?['previousTitle'] ?? '';
  }

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: TopBarCustomization(
          child: child(context)
      ),
    );
  }

  Widget child(BuildContext context){

    return Padding(
      padding: EdgeInsets.only(bottom: defaultTargetPlatform ==  TargetPlatform.android
          ? MediaQuery.of(context).viewPadding.bottom
          : OudsTheme.of(context).spaceScheme(context).paddingBlockNone),
      child: Scaffold(
        bottomSheet: OudsSheetsBottom(
          onExpansionChanged: _onExpansionChanged,
          sheetContent: Theme.of(context).platform == TargetPlatform.iOS
              ? const _ToolBarTopCustomizationContent()
              : const _TopAppBarCustomizationContent(),
          title: context.l10n.app_common_customize_label,
        ),
        //extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        appBar: MainAppBar(
          title: context.l10n.app_components_topAppBar_label,
          showBackButton: true,
          previousTitle: previousTitle,
        ),
        body: ExcludeSemantics(
          excluding: !_isBottomSheetExpanded,
          child: _Body(),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the TopBar demo and code will be displayed
class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      description: context.l10n.app_components_topAppBar_description_text,
      widget: Column(
        children: [
          _TopBarDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: TopBarCodeGenerator.updateCode(context),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.bar,
          )
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the top app bar demo.
///
/// Component [AppBarDemo] demonstrates the behavior and functionality of a BarTop.
class _TopBarDemo extends StatefulWidget {
  @override
  State<_TopBarDemo> createState() => _TopBarDemoState();
}

class _TopBarDemoState extends State<_TopBarDemo> {
  ThemeController? themeController;
  TopBarCustomizationState? customizationState;
  String? label;
  OudsTopBarActionConfig? iconActionConfig;
  OudsTopBarActionConfig? iconActionConfigWithBadge;
  OudsTopBarActionConfig? avatarActionConfig;

  @override
  Widget build(BuildContext context) {
    customizationState = TopBarCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: true);

    final barTop = OudsTopBar(
      size: TopBarCustomizationUtils.getSize(customizationState!.selectedSize),
      leadingActions: TopBarCustomizationUtils
          .buildActions(
        context: context,
        customizationState: customizationState!,
        themeController: themeController,
        isLeadingActions: true,
      ),
      title: customizationState?.titleText,
      trailingActions: TopBarCustomizationUtils
          .buildActions(
        context: context,
        customizationState: customizationState!,
        themeController: themeController,
        isLeadingActions: false,
      ),
      materialConfig: TopAppBarCustomizationUtils.getMaterialConfig(customizationState!)
    );

    return LightDarkBox(
      child: _wrapWithSizedBox(
        context,
        barTop,
        TopAppBarCustomizationUtils.getExpandedHeaderValue(customizationState!),
      ),
    );
  }

  // Helper method to reduce duplication
  Widget _wrapWithSizedBox(
      BuildContext context,
      Widget child,
      double height,
      ) {
    return Theme.of(context).platform == TargetPlatform.android
        ? SizedBox(height: height, child: child)
        : child;
  }
}

/// This widget represents the customization content section that appears in the bottom sheet
class _TopAppBarCustomizationContent extends StatefulWidget {
  const _TopAppBarCustomizationContent();

  @override
  State<_TopAppBarCustomizationContent> createState() => _TopAppBarCustomizationContentState();
}

/// This state class handles the customization options for the TopAppBar
class _TopAppBarCustomizationContentState extends State<_TopAppBarCustomizationContent> {
  late final FocusNode titleFocus;
  late final FocusNode headerFocus;
  late final FocusNode lineCountFocus;
  late final FocusNode monogramFocus;

  @override
  void initState() {
    super.initState();
    titleFocus = FocusNode();
    monogramFocus = FocusNode();
    lineCountFocus = FocusNode();
    headerFocus = FocusNode();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    monogramFocus.dispose();
    lineCountFocus.dispose();
    headerFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TopBarCustomizationState? customizationState = TopBarCustomization.of(context);
    var navigationIconType = customizationState!.iconTypeState.list;
    var size = customizationState.sizeState.list;
    var actionIconBadgeType = customizationState.actionIconBadgeState.list;
    var actionAvatarType = customizationState.actionAvatarState.list;

    return CustomizableSection(
      children: [
        CustomizableChips<TopBarSizeEnum>(
          title: TopBarSizeEnum.enumName(context),
          options: size,
          selectedOption: customizationState.selectedSize,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedSize = selectedOption;
              customizationState.maxLinesSelected = 1;
              customizationState.expandedHeightText = TopAppBarCustomizationUtils
                  .setExpandedHeight(customizationState);
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_topAppBar_centerAligned_label,
          value: customizationState.hasCentredAligned,
          onChanged: customizationState.selectedSize == TopBarSizeEnum.small
              ? (value) {
            setState(() {
              customizationState.hasCentredAligned = value;
            });
          } : null,
        ),
        CustomizableChips<NavigationIconTypeEnum>(
          title: NavigationIconTypeEnum.enumName(context),
          options: navigationIconType,
          selectedOption: customizationState.selectedIconType,
          getText: (option) => option.stringValue(),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedIconType = selectedOption;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_title_label,
          text: customizationState.titleText,
          focusNode: titleFocus,
          fieldType: FieldType.title,
        ),
        CustomizableChips<int>(
          title: context.l10n.app_components_topAppBar_titleMaxLines_label,
          options: TopAppBarCustomizationUtils.maxLinesOptions,
          selectedOption: customizationState.maxLinesSelected,
          getText: (option) => option.toString(),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.maxLinesSelected = selectedOption;
              customizationState.expandedHeightText = TopAppBarCustomizationUtils
                  .setExpandedHeight(customizationState);
            });
          },
            disabledOptions: TopAppBarCustomizationUtils.getMaxLiensDisabledOptions(customizationState)
        ),
        CustomizableTextField(
          title: context.l10n.app_components_topAppBar_expandedHeight_label,
          text: customizationState.expandedHeightText,
          helperText: TopAppBarCustomizationUtils
              .getExpandedHeightHelperText(context, customizationState),
          focusNode: headerFocus,
          fieldType: FieldType.customHeight,
          keyboardType: TextInputType.number,
          fieldEnable: customizationState.selectedSize != TopBarSizeEnum.small,
          errorText: TopAppBarCustomizationUtils.getExpandedHeightErrorText(context,customizationState),
        ),
        CustomizableChips<int>(
          title: context.l10n.app_components_common_trailingActionCount_label,
          options: TopAppBarCustomizationUtils.actionCountOptions,
          selectedOption: customizationState.actionSelected,
          getText: (option) => option.toString(),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.actionSelected = selectedOption;
            });
          },
        ),
        CustomizableChips<ActionIconBadgeEnum>(
          title: ActionIconBadgeEnum.enumName(context),
          options: actionIconBadgeType,
          selectedOption: customizationState.selectedIconBadge,
          getText: (option) => option.stringValue(context),
          onSelected: customizationState.actionSelected == 0
              ? null
              : (selectedOption) {
            setState(() {
              customizationState.selectedIconBadge = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_topAppBar_showAvatar_label,
          value: customizationState.showAvatar,
          onChanged:  (value) {
            setState(() {
              customizationState.showAvatar = value;
            });
          },
        ),
        CustomizableChips<ActionAvatarEnum>(
          title: ActionAvatarEnum.enumName(context),
          options: actionAvatarType,
          selectedOption: customizationState.selectedActionAvatar,
          getText: (option) => option.stringValue(context),
          onSelected: !customizationState.showAvatar
              ? null
              : (selectedOption) {
            setState(() {
              customizationState.selectedActionAvatar = selectedOption;
              customizationState.actionAvatarMonogramText = TopAppBarCustomizationUtils.getMonogramText(customizationState);
            });
          } ,
        ),
        CustomizableTextField(
          fieldEnable: TopAppBarCustomizationUtils
              .getActionAvatar(customizationState.selectedActionAvatar) == OudsTopAppBarActionAvatar.monogram,
          title: context.l10n.app_components_topAppBar_actionAvatarMonogram_label,
          text: customizationState.actionAvatarMonogramText ?? "A",
          focusNode: monogramFocus,
          fieldType: FieldType.monogram,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}

/// This widget represents the customization content section that appears in the bottom sheet
class _ToolBarTopCustomizationContent extends StatefulWidget {
  const _ToolBarTopCustomizationContent();

  @override
  State<_ToolBarTopCustomizationContent> createState() => _ToolbarTopCustomizationContentState();
}

/// This state class handles the customization options for the TopNavigationBar
class _ToolbarTopCustomizationContentState extends State<_ToolBarTopCustomizationContent> {
  late final FocusNode titleFocus;
  late final FocusNode leadingFocus;
  late final FocusNode trailingFocus;
  late final FocusNode labelFocus;

  @override
  void initState() {
    super.initState();
    titleFocus = FocusNode();
    leadingFocus = FocusNode();
    trailingFocus = FocusNode();
    labelFocus = FocusNode();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    leadingFocus.dispose();
    trailingFocus.dispose();
    labelFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TopBarCustomizationState? customizationState = TopBarCustomization.of(context);
    var navigationActionType = customizationState!.leadingActionTypeState.list;
    var trailingActionType = customizationState.trailingActionTypeState.list;
    final sizeOptions = customizationState.sizeState.list
        .where((e) => e != TopBarSizeEnum.medium)
        .toList();
    return CustomizableSection(
      children: [
        CustomizableChips<TopBarSizeEnum>(
          title: TopBarSizeEnum.enumName(context),
          options: sizeOptions,
          selectedOption: customizationState.selectedSize,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedSize = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
            title: context.l10n.app_components_toolbarTop_actionEnabled_label,
            value: customizationState.hasEnabled,
            onChanged: (value) => customizationState.hasEnabled = value
        ),
        CustomizableChips<ToolbarTopActionTypeEnum>(
          title: ToolbarTopActionTypeEnum.enumName(context),
          options: navigationActionType,
          selectedOption: customizationState.selectedLeadingActionType,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedLeadingActionType = selectedOption;
              if(selectedOption == ToolbarTopActionTypeEnum.back){
                customizationState.selectedLeadingActionCount = ToolbarTopCustomizationUtils.minActionCount;
              }
            });
          },
        ),
        CustomizableChips<int>(
          title: context.l10n.app_components_toolbarTop_leadingActionCount_label,
          options: ToolbarTopCustomizationUtils.getLimitedActionsCount(context),
          selectedOption: customizationState.selectedLeadingActionCount,
          getText: (option) => option.toString(),
          disabledOptions: ToolbarTopCustomizationUtils.getDisabledLeadingActionCountOptions(customizationState),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedLeadingActionCount = selectedOption;
            });
          },
        ),
        CustomizableChips<ToolbarTopActionTypeEnum>(
          title: context.l10n.app_components_toolbarTop_trailingActionType_label,
          options: trailingActionType,
          selectedOption: customizationState.selectedTrailingActionType,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedTrailingActionType = selectedOption;
            });
          },
        ),
        CustomizableChips<int>(
          title: context.l10n.app_components_common_trailingActionCount_label,
          options: ToolbarTopCustomizationUtils.getLimitedActionsCount(context),
          selectedOption: customizationState.selectedTrailingActionCount,
          getText: (option) => option.toString(),
          disabledOptions: ToolbarTopCustomizationUtils
              .getDisabledTrailingActionCountOptions(customizationState),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedTrailingActionCount = selectedOption;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_title_label,
          text: customizationState.titleText,
          focusNode: titleFocus,
          fieldType: FieldType.title,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_toolbarTop_previousTitle_label,
          text: customizationState.previousPageTitleText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
      ],
    );
  }
}
