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

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_tabs.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/tinted_enum.dart';

/// Variant of the list item family displayed by [ListItemCustomizationPanel].
enum ListItemDemoVariant {
  /// [OudsListItem] controls.
  listItem,

  /// [OudsCardItem] controls.
  cardItem,

  /// [OudsSmallListItem] controls.
  smallListItem,

  /// [OudsSmallCardItem] controls.
  smallCardItem,
}

/// Customization bottom sheet content shared by the four list item demo
/// screens (list item, card item, small list item and small card item).
///
/// The [variant] selects which controls are relevant for the component
/// under demo: card variants expose the card decoration chips, small
/// variants hide the controls that the small components do not expose.
class ListItemCustomizationPanel extends StatefulWidget {
  final ListItemDemoVariant variant;

  const ListItemCustomizationPanel({super.key, required this.variant});

  @override
  State<ListItemCustomizationPanel> createState() =>
      _ListItemCustomizationPanelState();
}

class _ListItemCustomizationPanelState
    extends State<ListItemCustomizationPanel> {
  late final FocusNode labelFocus;
  late final FocusNode? overlineFocus;
  late final FocusNode? extraLabelFocus;
  late final FocusNode descriptionFocus;
  late final FocusNode helperTextFocus;
  late final FocusNode trailingTextLabelFocus;
  late final FocusNode? trailingTextExtraLabelFocus;
  late final FocusNode trailingBadgeCountFocus;
  late final FocusNode trailingTagLabelFocus;

  bool get _isCard =>
      widget.variant == ListItemDemoVariant.cardItem ||
      widget.variant == ListItemDemoVariant.smallCardItem;

  bool get _isSmall =>
      widget.variant == ListItemDemoVariant.smallListItem ||
      widget.variant == ListItemDemoVariant.smallCardItem;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
    overlineFocus = _isSmall ? null : FocusNode();
    extraLabelFocus = _isSmall ? null : FocusNode();
    descriptionFocus = FocusNode();
    helperTextFocus = FocusNode();
    trailingTextLabelFocus = FocusNode();
    trailingTextExtraLabelFocus = _isSmall ? null : FocusNode();
    trailingBadgeCountFocus = FocusNode();
    trailingTagLabelFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    overlineFocus?.dispose();
    extraLabelFocus?.dispose();
    descriptionFocus.dispose();
    helperTextFocus.dispose();
    trailingTextLabelFocus.dispose();
    trailingTextExtraLabelFocus?.dispose();
    trailingBadgeCountFocus.dispose();
    trailingTagLabelFocus.dispose();
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
        CustomizableSection(
          children: _buildTrailingSection(customizationState),
        ),
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
      CustomizableChips<ListItemIndicatorEnum>(
        title: ListItemIndicatorEnum.enumName(context),
        options: customizationState.indicatorState.list,
        selectedOption: customizationState.indicator,
        getText: (option) => option.stringValue(context),
        // Indicator chips stay visible but
        // are disabled while the item is not clickable.
        disabledOptions: customizationState.clickable
            ? null
            : customizationState.indicatorState.list,
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
      if (_isCard) ...[
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
      ] else ...[
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
          title: context.l10n.app_components_listItem_background_tech,
          value: customizationState.background,
          onChanged: (value) {
            setState(() {
              customizationState.background = value;
            });
          },
        ),
      ],
      CustomizableSwitch(
        title: context.l10n.app_common_enabled_label,
        value: customizationState.enable,
        onChanged: (value) {
          setState(() {
            customizationState.enable = value;
          });
        },
      ),
      if (!_isCard)
        CustomizableSwitch(
          title: context.l10n.app_components_common_edgeToEdge_tech,
          value: customizationState.edgeToEdge,
          onChanged: (value) {
            setState(() {
              customizationState.edgeToEdge = value;
            });
          },
        ),
      if (!_isSmall)
        CustomizableSwitch(
          title: context.l10n.app_components_listItem_bottomContent_tech,
          value: customizationState.bottomContentEnabled,
          onChanged: (value) {
            setState(() {
              customizationState.bottomContentEnabled = value;
            });
          },
        ),
      CustomizableSwitch(
        title: context.l10n.app_components_common_skeleton_tech,
        value: customizationState.hasSkeleton,
        onChanged: (value) {
          setState(() {
            customizationState.hasSkeleton = value;
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
        options: _isSmall
            ? ListItemLeadingEnum.smallOptions
            : customizationState.leadingState.list,
        selectedOption: customizationState.leading,
        getText: (option) => option.stringValue(context),
        onSelected: (selectedOption) {
          setState(() {
            customizationState.leading = selectedOption;
          });
        },
      ),
      if (!_isSmall &&
          customizationState.leading == ListItemLeadingEnum.content)
        ListItemCustomizationUtils.buildContentExampleAlert(context),
      // Icon size is not customizable for the small items: leading/trailing
      // icons are always rendered at OudsListItemAssetSize.small by design.
      if (!_isSmall && customizationState.leading == ListItemLeadingEnum.icon)
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
        CustomizableChips<StatusEnum>(
          title: StatusEnum.enumName(context),
          options: customizationState.leadingIconStatusState.list,
          selectedOption: customizationState.leadingIconStatus,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.leadingIconStatus = selectedOption;
            });
          },
        ),
      if (customizationState.leading == ListItemLeadingEnum.icon &&
          customizationState.leadingIconStatus == StatusEnum.neutral)
        CustomizableChips<TintedEnum>(
          title: TintedEnum.enumName(context),
          options: customizationState.tintedState.list,
          selectedOption: customizationState.selectedLeadingTinted,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedLeadingTinted = selectedOption;
            });
          },
        ),
      if (!_isSmall && customizationState.leading == ListItemLeadingEnum.image)
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
      if (customizationState.leading == ListItemLeadingEnum.image)
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
      if (customizationState.leading == ListItemLeadingEnum.image)
        CustomizableSwitch(
          title: context.l10n.app_components_listItem_roundedMedia_tech,
          value: customizationState.leadingImageRounded,
          onChanged: (value) {
            setState(() {
              customizationState.leadingImageRounded = value;
            });
          },
        ),
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
        fieldEnable: _isSmall || !customizationState.labelContentEnabled,
      ),
      CustomizableSwitch(
        title: context.l10n.app_components_listItem_boldLabel_tech,
        value: customizationState.boldLabel,
        onChanged: !_isSmall && customizationState.labelContentEnabled
            ? null
            : (value) {
                setState(() {
                  customizationState.boldLabel = value;
                });
              },
      ),
      if (!_isSmall)
        CustomizableSwitch(
          title: context.l10n.app_components_listItem_labelContent_tech,
          value: customizationState.labelContentEnabled,
          onChanged: (value) {
            setState(() {
              customizationState.labelContentEnabled = value;
            });
          },
        ),
      CustomizableTextField(
        title: context.l10n.app_components_common_description_tech,
        text: customizationState.descriptionTextState.value,
        focusNode: descriptionFocus,
        fieldType: FieldType.description,
      ),
      if (!_isSmall)
        CustomizableTextField(
          title: context.l10n.app_components_listItem_overline_tech,
          text: customizationState.overlineTextState.value,
          focusNode: overlineFocus!,
          fieldType: FieldType.listItemOverline,
        ),
      if (!_isSmall)
        CustomizableTextField(
          title: context.l10n.app_components_listItem_extraLabel_tech,
          text: customizationState.extraLabelTextState.value,
          focusNode: extraLabelFocus!,
          fieldType: FieldType.extra,
        ),
      CustomizableTextField(
        title: context.l10n.app_components_common_helperText_label,
        text: customizationState.helperTextState.value,
        focusNode: helperTextFocus,
        fieldType: FieldType.helper,
      ),
      if (!_isSmall)
        CustomizableSwitch(
          title: context.l10n.app_components_listItem_belowTextContent_tech,
          value: customizationState.belowTextContentEnabled,
          onChanged: (value) {
            setState(() {
              customizationState.belowTextContentEnabled = value;
            });
          },
        ),
    ];
  }

  List<Widget> _buildTrailingSection(
    ListItemCustomizationState customizationState,
  ) {
    return [
      CustomizableChips<ListItemTrailingEnum>(
        title: ListItemTrailingEnum.enumName(context),
        options: _isSmall
            ? ListItemTrailingEnum.smallOptions
            : customizationState.trailingState.list,
        selectedOption: customizationState.trailing,
        getText: (option) => option.stringValue(context),
        onSelected: (selectedOption) {
          setState(() {
            customizationState.trailing = selectedOption;
          });
        },
      ),
      if (!_isSmall &&
          customizationState.trailing == ListItemTrailingEnum.content)
        ListItemCustomizationUtils.buildContentExampleAlert(context),
      if (!_isSmall && customizationState.trailing == ListItemTrailingEnum.icon)
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
        CustomizableChips<StatusEnum>(
          title: StatusEnum.enumName(context),
          options: customizationState.trailingIconStatusState.list,
          selectedOption: customizationState.trailingIconStatus,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.trailingIconStatus = selectedOption;
            });
          },
        ),
      if (customizationState.trailing == ListItemTrailingEnum.icon &&
          customizationState.trailingIconStatus == StatusEnum.neutral)
        CustomizableChips<TintedEnum>(
          title: TintedEnum.enumName(context),
          options: customizationState.tintedState.list,
          selectedOption: customizationState.selectedTrailingTinted,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedTrailingTinted = selectedOption;
            });
          },
        ),
      if (!_isSmall &&
          customizationState.trailing == ListItemTrailingEnum.image)
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
      if (customizationState.trailing == ListItemTrailingEnum.image)
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
      if (customizationState.trailing == ListItemTrailingEnum.image)
        CustomizableSwitch(
          title: context.l10n.app_components_listItem_roundedMedia_tech,
          value: customizationState.trailingImageRounded,
          onChanged: (value) {
            setState(() {
              customizationState.trailingImageRounded = value;
            });
          },
        ),
      if (customizationState.trailing == ListItemTrailingEnum.text) ...[
        CustomizableChips<ListItemTrailingTextStyleEnum>(
          title: ListItemTrailingTextStyleEnum.enumName(context),
          options: _isSmall
              ? ListItemTrailingTextStyleEnum.smallOptions
              : customizationState.trailingTextStyleState.list,
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
        if (!_isSmall &&
            customizationState.trailingTextStyle ==
                ListItemTrailingTextStyleEnum.labelAndExtraLabel)
          CustomizableTextField(
            title: context
                .l10n
                .app_components_listItem_trailingTextExtraLabel_tech,
            text: customizationState.trailingTextExtraLabelState.value,
            focusNode: trailingTextExtraLabelFocus!,
            fieldType: FieldType.listItemTrailingExtraText,
          ),
      ],
      if (customizationState.trailing == ListItemTrailingEnum.badge)
        ...ListItemCustomizationUtils.buildBadgeTrailingControls(
          context,
          customizationState,
          countFocus: trailingBadgeCountFocus,
        ),
      if (customizationState.trailing == ListItemTrailingEnum.tag)
        ...ListItemCustomizationUtils.buildTagTrailingControls(
          context,
          customizationState,
          labelFocus: trailingTagLabelFocus,
        ),
    ];
  }
}
