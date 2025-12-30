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
import 'package:ouds_core/components/navigation_bars/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_enum.dart';
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
import 'package:ouds_flutter_demo/ui/utilities/code.dart';

/// This screen displays an appBar demo and allows customization of appBar properties
class TopAppbarDemoScreen extends StatefulWidget {
  const TopAppbarDemoScreen({super.key}); // Default value set to false

  @override
  State<TopAppbarDemoScreen> createState() => _TopAppbarDemoScreenState();
}

class _TopAppbarDemoScreenState extends State<TopAppbarDemoScreen> {
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
      child: TopAppBarCustomization(
        child: Padding(
          padding: EdgeInsets.only(bottom: Platform.isAndroid ? MediaQuery.of(context).viewPadding.bottom : OudsTheme.of(context).spaceScheme(context).paddingBlockNone),
          child: Scaffold(
            bottomSheet: OudsSheetsBottom(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
            key: _scaffoldKey,
            appBar: MainAppBar(title: context.l10n.app_components_topAppBar_label),
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
      description: context.l10n.app_components_topAppBar_description_text,
      widget: Column(
        children: [
          _TopAppBarDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: TopAppBarCodeGenerator.updateCode(context),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.bar,
          )
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the radio_button demo.
///
/// Component [AppBarDemo] demonstrates the behavior and functionality of a radio_button.
class _TopAppBarDemo extends StatefulWidget {
  @override
  State<_TopAppBarDemo> createState() => _TopAppBarDemoState();
}

class _TopAppBarDemoState extends State<_TopAppBarDemo> {
  ThemeController? themeController;
  TopAppBarCustomizationState? customizationState;
  String? label;
  OudsTopAppBarActionConfig? iconActionConfig;
  OudsTopAppBarActionConfig? avatarActionConfig;

  @override
  Widget build(BuildContext context) {
    customizationState = TopAppBarCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: true);
    iconActionConfig =  OudsTopAppBarActionConfig(
        type: OudsTopAppBarActionType.icon,
        badge : TopAppBarCustomizationUtils.isActionBadge(customizationState!),
        count : TopAppBarCustomizationUtils.getActionBadgeCount(customizationState!),
        standard : TopAppBarCustomizationUtils.isBadgeStandard(customizationState!),
        semanticLabel: context.l10n.app_components_common_icon_a11y,
        badgeSemanticLabel: context.l10n.app_components_badge_notification_label_a11y,
        onActionPressed: () {}
    );
    avatarActionConfig = OudsTopAppBarActionConfig(
        type: OudsTopAppBarActionType.avatar,
        avatarIcon: AppAssets.images.ilTopAppBarAvatar,
        monogramText : customizationState!.actionAvatarMonogramText,
        semanticLabel: context.l10n.app_components_common_icon_a11y,
        onActionPressed: () {});

    List<OudsTopAppBarActionConfig> actions = [];

    switch (customizationState?.selectedActionCount) {
      case ActionCountEnum.one:
        actions.add(iconActionConfig!);
        break;
      case ActionCountEnum.two:
        actions.add(iconActionConfig!);
        actions.add(iconActionConfig!);
        break;
      case ActionCountEnum.three:
        actions.add(iconActionConfig!);
        actions.add(iconActionConfig!);
        actions.add(iconActionConfig!);
        break;
      default:
        actions.add(avatarActionConfig!);
    }

    if(customizationState?.showAvatar == true){
      actions.add(avatarActionConfig!);
    }

    return Column(
      children: [
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
            child: OudsTopAppBar(
              size: TopAppBarCustomizationUtils.getSize(customizationState?.selectedSize as Object),
              navigationIcon: TopAppBarCustomizationUtils.getNavigationIcon(customizationState?.selectedIconType as Object),
              leadingSemanticLabel: TopAppBarCustomizationUtils.getLeadingSemanticLabel(context,customizationState?.selectedIconType as Object),
              customLeadingIcon: AppAssets.icons.assistanceTipsAndTricks(themeController!),
              title: customizationState?.titleText,
              showAvatar: customizationState!.showAvatar,
              centerTitle: customizationState!.hasCentredAligned,
              appBarActions: actions,
              backgroundColor: customizationState!.hasBackgroundColor,
            )
        ),
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: OudsTopAppBar(
            size: TopAppBarCustomizationUtils.getSize(customizationState?.selectedSize as Object),
            navigationIcon: TopAppBarCustomizationUtils.getNavigationIcon(customizationState?.selectedIconType as Object),
            leadingSemanticLabel: TopAppBarCustomizationUtils.getLeadingSemanticLabel(context,customizationState?.selectedIconType as Object),
            customLeadingIcon: AppAssets.icons.assistanceTipsAndTricks(themeController!),
            title: customizationState?.titleText,
            showAvatar: customizationState!.showAvatar,
            centerTitle: customizationState!.hasCentredAligned,
            appBarActions: actions,
            backgroundColor: customizationState!.hasBackgroundColor,
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

/// This state class handles the customization options for the TopAppBar
class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode titleFocus;
  late final FocusNode monogramFocus;

  @override
  void initState() {
    super.initState();
    titleFocus = FocusNode();
    monogramFocus = FocusNode();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    monogramFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TopAppBarCustomizationState? customizationState = TopAppBarCustomization.of(context);
    var navigationIconType = customizationState!.iconTypeState.list;
    var size = customizationState.sizeState.list;
    var actionIconBadgeType = customizationState.actionIconBadgeState.list;
    var actionAvatarType = customizationState.actionAvatarState.list;
    var actionCount = customizationState.actionCountState.list;

    return CustomizableSection(
      children: [
        CustomizableChips<TopAppBarSizeEnum>(
          title: TopAppBarSizeEnum.enumName(context),
          options: size,
          selectedOption: customizationState.selectedSize,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedSize = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_topAppBar_centerAligned_label,
          value: customizationState.hasCentredAligned,
          onChanged: (value) {
            setState(() {
              customizationState.hasCentredAligned = value;
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
        CustomizableSwitch(
          title: context.l10n.app_components_topAppBar_showAvatar_label,
          value: customizationState.showAvatar,
          onChanged: (value) {
            setState(() {
              customizationState.showAvatar = value;
            });
          },
        ),
        CustomizableChips<NavigationIconTypeEnum>(
          title: NavigationIconTypeEnum.enumName(context),
          options: navigationIconType,
          selectedOption: customizationState.selectedIconType,
          getText: (option) => option.stringValue(context),
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
          fieldType: FieldType.label,
        ),
        CustomizableChips<ActionCountEnum>(
          title: ActionCountEnum.enumName(context),
          options: actionCount,
          selectedOption: customizationState.selectedActionCount,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedActionCount = selectedOption;
            });
          },
        ),
        CustomizableChips<ActionIconBadgeEnum>(
          title: ActionIconBadgeEnum.enumName(context),
          options: actionIconBadgeType,
          selectedOption: customizationState.selectedIconBadge,
          getText: (option) => option.stringValue(context),
          onSelected: customizationState.selectedActionCount == ActionCountEnum.zero
              ? null
              : (selectedOption) {
            setState(() {
              customizationState.selectedIconBadge = selectedOption;
            });
          },
        ),
        CustomizableChips<ActionAvatarEnum>(
          title: ActionAvatarEnum.enumName(context),
          options: actionAvatarType,
          selectedOption: customizationState.selectedActionAvatar,
          getText: (option) => option.stringValue(context),
          onSelected: customizationState.showAvatar ? (selectedOption) {
            setState(() {
              customizationState.selectedActionAvatar = selectedOption;
              customizationState.actionAvatarMonogramText = TopAppBarCustomizationUtils.getMonogramText(customizationState);
            });
          } : null,
        ),
        CustomizableTextField(
          fieldEnable: TopAppBarCustomizationUtils.getActionAvatar(customizationState.selectedActionAvatar) == OudsTopAppBarActionAvatar.monogram,
          title: context.l10n.app_components_topAppBar_actionAvatarMonogram_label,
          text: customizationState.actionAvatarMonogramText,
          focusNode: monogramFocus,
          fieldType: FieldType.monogram,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}
