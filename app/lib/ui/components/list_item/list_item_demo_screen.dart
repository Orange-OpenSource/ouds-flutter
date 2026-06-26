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
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_dropdown_menu.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// Screen for the [OudsListItem] component demo.
class StaticListItemDemoScreen extends StatefulWidget {
  final String? previousPageTitle;

  const StaticListItemDemoScreen({super.key, this.previousPageTitle});

  @override
  State<StaticListItemDemoScreen> createState() =>
      _StaticListItemDemoScreenState();
}

class _StaticListItemDemoScreenState extends State<StaticListItemDemoScreen> {
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
      child: ListItemCustomization(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: defaultTargetPlatform == TargetPlatform.android
                ? MediaQuery.of(context).viewPadding.bottom
                : OudsTheme.of(context).spaceScheme(context).paddingBlockNone,
          ),
          child: Scaffold(
            bottomSheet: OudsSheetsBottom(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: MainAppBar(
              title: 'List item',
              previousPageTitle: widget.previousPageTitle,
              showBackButton: true,
            ),
            body: ExcludeSemantics(
              excluding: !_isBottomSheetExpanded,
              child: _Body(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Body of the screen, displaying the component demo and description.
class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    return DetailScreenDescription(
      description:
          "A list item is a horizontal row used to display a unit of information within a list.",
      widget: Column(
        children: [
          _StaticListItemDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(code: ''),
          const ReferenceDesignVersionComponent(version: '0.1.0'),
        ],
      ),
    );
  }
}

/// Widget that displays [OudsListItem] with the current customizations.
class _StaticListItemDemo extends StatefulWidget {
  @override
  State<_StaticListItemDemo> createState() => _StaticListItemDemoState();
}

class _StaticListItemDemoState extends State<_StaticListItemDemo> {
  @override
  Widget build(BuildContext context) {
    final customizationState = ListItemCustomization.of(context)!;
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return LightDarkBox(
      child: Column(
        children: [
          ListItemCustomizationUtils.buildListItem(customizationState, themeController),
        ],
      ),
    );
  }
}

/// Content of the bottom sheet with customization controls.
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode labelFocus;
  late final FocusNode overlineFocus;
  late final FocusNode extraLabelFocus;
  late final FocusNode descriptionFocus;
  late final FocusNode helperTextFocus;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
    overlineFocus = FocusNode();
    extraLabelFocus = FocusNode();
    descriptionFocus = FocusNode();
    helperTextFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    overlineFocus.dispose();
    extraLabelFocus.dispose();
    descriptionFocus.dispose();
    helperTextFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = ListItemCustomization.of(context)!;

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.enable,
          onChanged: (value) {
            setState(() {
              customizationState.enable = value;
            });
          },
        ),
        CustomizableChips<ListItemSizeEnum>(
          title: ListItemSizeEnum.enumName(context),
          options: customizationState.sizeState.list,
          selectedOption: customizationState.size,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.size = selectedOption;
            });
          },
        ),
        CustomizableChips<ListItemContentAlignmentEnum>(
          title: ListItemContentAlignmentEnum.enumName(context),
          options: customizationState.contentAlignmentState.list,
          selectedOption: customizationState.contentAlignment,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.contentAlignment = selectedOption;
            });
          },
        ),
        // Show icon status dropdown only when leading or trailing is set to icon.
        if (customizationState.leading == ListItemLeadingEnum.icon ||
            customizationState.trailing == ListItemTrailingEnum.icon)
          CustomizationDropdownMenu<StatusEnum>(
            label: StatusEnum.enumName(context),
            options: customizationState.iconStatusState.list,
            selectedItemIndex: customizationState.iconStatusIndex,
            selectedOption: customizationState.iconStatus,
            getText: (option) => option.stringValue(context),
            onSelectionChange: (value, index) {
              setState(() {
                customizationState.iconStatus = value;
              });
            },
            itemLeadingIcons: customizationState.iconStatusState.list.map((
              status,
            ) {
              return () => Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: ListItemCustomizationUtils.getIconStatusColor(
                    context,
                    status,
                  ),
                  shape: BoxShape.rectangle,
                ),
              );
            }).toList(),
          ),
        CustomizableChips<ListItemLeadingEnum>(
          title: ListItemLeadingEnum.enumName(context),
          options: customizationState.leadingState.list,
          selectedOption: customizationState.leading,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.leading = selectedOption;
            });
          },
        ),
        CustomizableChips<ListItemTrailingEnum>(
          title: ListItemTrailingEnum.enumName(context),
          options: customizationState.trailingState.list,
          selectedOption: customizationState.trailing,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.trailing = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_controlItem_divider_label,
          value: customizationState.divider,
          onChanged: (value) {
            setState(() {
              customizationState.divider = value;
            });
          },
        ),
        CustomizableSwitch(
          title: 'Background',
          value: customizationState.background,
          onChanged: (value) {
            setState(() {
              customizationState.background = value;
            });
          },
        ),
        CustomizableSwitch(
          title: 'Bold label',
          value: customizationState.boldLabel,
          onChanged: (value) {
            setState(() {
              customizationState.boldLabel = value;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.labelTextState.value,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
        CustomizableTextField(
          title: 'Overline',
          text: customizationState.overlineTextState.value,
          focusNode: overlineFocus,
          fieldType: FieldType.listItemOverline,
        ),
        CustomizableTextField(
          title: context
              .l10n
              .app_components_radioButton_radioButtonItem_extraLabel_label,
          text: customizationState.extraLabelTextState.value,
          focusNode: extraLabelFocus,
          fieldType: FieldType.extra,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_description_tech,
          text: customizationState.descriptionTextState.value,
          focusNode: descriptionFocus,
          fieldType: FieldType.description,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_helperText_label,
          text: customizationState.helperTextState.value,
          focusNode: helperTextFocus,
          fieldType: FieldType.helper,
        ),
      ],
    );
  }
}
