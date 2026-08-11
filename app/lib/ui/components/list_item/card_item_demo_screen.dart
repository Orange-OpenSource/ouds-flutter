/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 *
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 *
 * // Software description: Flutter library of reusable graphical components
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_code_generator.dart';
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
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_tabs.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom_with_tabs.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// Screen for the [OudsCardItem] component demo.
class CardItemDemoScreen extends StatefulWidget {
  final String? previousPageTitle;

  const CardItemDemoScreen({super.key, this.previousPageTitle});

  @override
  State<CardItemDemoScreen> createState() => _CardItemDemoScreenState();
}

class _CardItemDemoScreenState extends State<CardItemDemoScreen> {
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
            bottomSheet: OudsSheetsBottomWithTabs(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
            extendBodyBehindAppBar: true,
            appBar: MainAppBar(
              title: context.l10n.app_components_listItem_cardItem_tech,
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

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    return DetailScreenDescription(
      description:
          context.l10n.app_components_listItem_cardItem_description_text,
      widget: Column(
        children: [
          _CardItemDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(
            code: ListItemCodeGenerator.updateCardCode(context, isSmall: false),
          ),
          const ReferenceDesignVersionComponent(version: '0.1.0'),
        ],
      ),
    );
  }
}

class _CardItemDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customizationState = ListItemCustomization.of(context)!;
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );

    return LightDarkBox(
      child: Column(
        children: [
          ListItemCustomizationUtils.buildCardItem(
            customizationState,
            themeController,
          ),
        ],
      ),
    );
  }
}

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
  late final FocusNode trailingTextLabelFocus;
  late final FocusNode trailingTextExtraLabelFocus;

  CustomizationDropdownMenu<StatusEnum> _buildStatusDropdown({
    required BuildContext context,
    required List<StatusEnum> options,
    required int selectedItemIndex,
    required StatusEnum selectedOption,
    required void Function(StatusEnum) onChanged,
  }) {
    return CustomizationDropdownMenu<StatusEnum>(
      label: StatusEnum.enumName(context),
      options: options,
      selectedItemIndex: selectedItemIndex,
      selectedOption: selectedOption,
      getText: (option) => option.stringValue(context),
      onSelectionChange: (value, index) {
        setState(() {
          onChanged(value);
        });
      },
      itemLeadingIcons: options.map((status) {
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
    );
  }

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
    overlineFocus = FocusNode();
    extraLabelFocus = FocusNode();
    descriptionFocus = FocusNode();
    helperTextFocus = FocusNode();
    trailingTextLabelFocus = FocusNode();
    trailingTextExtraLabelFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    overlineFocus.dispose();
    extraLabelFocus.dispose();
    descriptionFocus.dispose();
    helperTextFocus.dispose();
    trailingTextLabelFocus.dispose();
    trailingTextExtraLabelFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = ListItemCustomization.of(context)!;

    return CustomizableTabs(
      tabs: [
        context.l10n.app_components_listItem_section_general_label,
        context.l10n.app_components_listItem_leading_tech,
        context.l10n.app_components_listItem_section_texts_label,
        context.l10n.app_components_listItem_trailing_tech,
      ],
      children: [
        CustomizableSection(children: _buildGeneralSection(customizationState)),
        CustomizableSection(children: _buildLeadingSection(customizationState)),
        CustomizableSection(children: _buildTextsSection(customizationState)),
        CustomizableSection(children: _buildTrailingSection(customizationState)),
      ],
    );
  }

  List<Widget> _buildGeneralSection(
    ListItemCustomizationState customizationState,
  ) {
    return [
        CustomizableSwitch(
          title: context.l10n.app_components_listItem_clickable_tech,
          value: customizationState.clickable,
          onChanged: (value) {
            setState(() {
              customizationState.clickable = value;
            });
          },
        ),
        if (customizationState.clickable)
          CustomizableChips<ListItemIndicatorEnum>(
            title: ListItemIndicatorEnum.enumName(context),
            options: customizationState.indicatorState.list,
            selectedOption: customizationState.indicator,
            getText: (option) => option.stringValue(context),
            onSelected: (selectedOption) {
              setState(() {
                customizationState.indicator = selectedOption;
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
        CustomizableChips<ListItemCardDecorationEnum>(
          title: ListItemCardDecorationEnum.enumName(context),
          options: customizationState.cardDecorationState.list,
          selectedOption: customizationState.cardDecoration,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.cardDecoration = selectedOption;
            });
          },
        ),
        if (customizationState.cardDecoration.supportsDivider)
          CustomizableSwitch(
            title: context.l10n.app_components_divider_label,
            value: customizationState.divider,
            onChanged: (value) {
              setState(() {
                customizationState.divider = value;
              });
            },
          ),
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.enable,
          onChanged: (value) {
            setState(() {
              customizationState.enable = value;
            });
          },
        ),
    ];
  }

  List<Widget> _buildLeadingSection(
    ListItemCustomizationState customizationState,
  ) {
    return [
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
        if (customizationState.leading == ListItemLeadingEnum.icon)
          CustomizableChips<ListItemIconSizeEnum>(
            title: ListItemIconSizeEnum.enumName(context),
            options: customizationState.leadingIconSizeState.list,
            selectedOption: customizationState.leadingIconSize,
            getText: (option) => option.stringValue(context),
            onSelected: (selectedOption) {
              setState(() {
                customizationState.leadingIconSize = selectedOption;
              });
            },
          ),
        if (customizationState.leading == ListItemLeadingEnum.icon)
          _buildStatusDropdown(
            context: context,
            options: customizationState.leadingIconStatusState.list,
            selectedItemIndex: customizationState.leadingIconStatusIndex,
            selectedOption: customizationState.leadingIconStatus,
            onChanged: (value) {
              customizationState.leadingIconStatus = value;
            },
          ),
        if (customizationState.leading == ListItemLeadingEnum.image) ...[
          CustomizableChips<ListItemImageSizeEnum>(
            title: ListItemImageSizeEnum.enumName(context),
            options: customizationState.leadingImageSizeState.list,
            selectedOption: customizationState.leadingImageSize,
            getText: (option) => option.stringValue(context),
            onSelected: (selectedOption) {
              setState(() {
                customizationState.leadingImageSize = selectedOption;
              });
            },
          ),
          CustomizableChips<ListItemImageFormatEnum>(
            title: ListItemImageFormatEnum.enumName(context),
            options: customizationState.leadingImageFormatState.list,
            selectedOption: customizationState.leadingImageFormat,
            getText: (option) => option.stringValue(context),
            onSelected: (selectedOption) {
              setState(() {
                customizationState.leadingImageFormat = selectedOption;
              });
            },
          ),
          CustomizableSwitch(
            title: context.l10n.app_components_listItem_roundedMedia_tech,
            value: customizationState.leadingImageRounded,
            onChanged: (value) {
              setState(() {
                customizationState.leadingImageRounded = value;
              });
            },
          ),
        ],
    ];
  }

  List<Widget> _buildTextsSection(
    ListItemCustomizationState customizationState,
  ) {
    return [
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.labelTextState.value,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_listItem_boldLabel_tech,
          value: customizationState.boldLabel,
          onChanged: (value) {
            setState(() {
              customizationState.boldLabel = value;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_description_tech,
          text: customizationState.descriptionTextState.value,
          focusNode: descriptionFocus,
          fieldType: FieldType.description,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_listItem_overline_tech,
          text: customizationState.overlineTextState.value,
          focusNode: overlineFocus,
          fieldType: FieldType.listItemOverline,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_listItem_extraLabel_tech,
          text: customizationState.extraLabelTextState.value,
          focusNode: extraLabelFocus,
          fieldType: FieldType.extra,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_helperText_label,
          text: customizationState.helperTextState.value,
          focusNode: helperTextFocus,
          fieldType: FieldType.helper,
        ),
    ];
  }

  List<Widget> _buildTrailingSection(
    ListItemCustomizationState customizationState,
  ) {
    return [
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
        if (customizationState.trailing == ListItemTrailingEnum.icon)
          CustomizableChips<ListItemIconSizeEnum>(
            title: ListItemIconSizeEnum.enumName(context),
            options: customizationState.trailingIconSizeState.list,
            selectedOption: customizationState.trailingIconSize,
            getText: (option) => option.stringValue(context),
            onSelected: (selectedOption) {
              setState(() {
                customizationState.trailingIconSize = selectedOption;
              });
            },
          ),
        if (customizationState.trailing == ListItemTrailingEnum.icon)
          _buildStatusDropdown(
            context: context,
            options: customizationState.trailingIconStatusState.list,
            selectedItemIndex: customizationState.trailingIconStatusIndex,
            selectedOption: customizationState.trailingIconStatus,
            onChanged: (value) {
              customizationState.trailingIconStatus = value;
            },
          ),
        if (customizationState.trailing == ListItemTrailingEnum.image) ...[
          CustomizableChips<ListItemImageSizeEnum>(
            title: ListItemImageSizeEnum.enumName(context),
            options: customizationState.trailingImageSizeState.list,
            selectedOption: customizationState.trailingImageSize,
            getText: (option) => option.stringValue(context),
            onSelected: (selectedOption) {
              setState(() {
                customizationState.trailingImageSize = selectedOption;
              });
            },
          ),
          CustomizableChips<ListItemImageFormatEnum>(
            title: ListItemImageFormatEnum.enumName(context),
            options: customizationState.trailingImageFormatState.list,
            selectedOption: customizationState.trailingImageFormat,
            getText: (option) => option.stringValue(context),
            onSelected: (selectedOption) {
              setState(() {
                customizationState.trailingImageFormat = selectedOption;
              });
            },
          ),
          CustomizableSwitch(
            title: context.l10n.app_components_listItem_roundedMedia_tech,
            value: customizationState.trailingImageRounded,
            onChanged: (value) {
              setState(() {
                customizationState.trailingImageRounded = value;
              });
            },
          ),
        ],
        if (customizationState.trailing == ListItemTrailingEnum.text) ...[
          CustomizableChips<ListItemTrailingTextStyleEnum>(
            title: ListItemTrailingTextStyleEnum.enumName(context),
            options: customizationState.trailingTextStyleState.list,
            selectedOption: customizationState.trailingTextStyle,
            getText: (option) => option.stringValue(context),
            onSelected: (selectedOption) {
              setState(() {
                customizationState.trailingTextStyle = selectedOption;
              });
            },
          ),
          CustomizableTextField(
            title: context.l10n.app_components_listItem_trailingTextLabel_tech,
            text: customizationState.trailingTextLabelState.value,
            focusNode: trailingTextLabelFocus,
            fieldType: FieldType.listItemTrailingText,
          ),
          if (customizationState.trailingTextStyle ==
              ListItemTrailingTextStyleEnum.labelAndExtraLabel)
            CustomizableTextField(
              title: context
                  .l10n
                  .app_components_listItem_trailingTextExtraLabel_tech,
              text: customizationState.trailingTextExtraLabelState.value,
              focusNode: trailingTextExtraLabelFocus,
              fieldType: FieldType.listItemTrailingExtraText,
            ),
        ],
    ];
  }
}
