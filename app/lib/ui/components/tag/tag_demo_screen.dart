//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';
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
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

class TagDemoScreen extends StatefulWidget {
  final String? previousPageTitle;
  const TagDemoScreen({super.key, this.previousPageTitle});

  @override
  State<StatefulWidget> createState() => _TagDemoScreenState();
}

class _TagDemoScreenState extends State<TagDemoScreen> {
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
      child: TagCustomization(
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
              showBackButton: true,
              title: context.l10n.app_components_tag_label,
              previousPageTitle: widget.previousPageTitle,
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

/// This widget represents the body of the screen where the tag demo and code will be displayed
class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    return DetailScreenDescription(
      description: context.l10n.app_components_tag_description_text,
      widget: Column(
        children: [
          _TagDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(code: TagCodeGenerator.updateCode(context)),
          ReferenceDesignVersionComponent(version: OudsComponentVersion.tag),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the tag demo.
///
/// Component [TagDemo] demonstrates the behavior and functionality of a tag.
class _TagDemo extends StatefulWidget {
  const _TagDemo();

  @override
  State<_TagDemo> createState() => _TagDemoState();
}

class _TagDemoState extends State<_TagDemo> {
  @override
  Widget build(BuildContext context) {
    final customizationState = TagCustomization.of(context)!;
    final themeController = Provider.of<ThemeController>(context, listen: true);

    return LightDarkBox(
      child: customizationState.selectedLayout == TagEnumLayout.bulletAndText
          ? OudsTag.bullet(
              status: TagCustomizationUtils.getIconStatus(
                context,
                customizationState,
                themeController,
              ),
              label: customizationState.labelText,
              enabled: customizationState.hasEnabled,
              appearance: TagCustomizationUtils.getAppearance(
                customizationState.selectedAppearance,
              ),
              size: TagCustomizationUtils.getSize(
                customizationState.selectedSize as Object,
              ),
              loading: customizationState.hasLoader,
              roundedCorners: customizationState.hasRoundedCorner,
            )
          : customizationState.selectedLayout == TagEnumLayout.iconAndText
          ? OudsTag.icon(
              status: TagCustomizationUtils.getIconStatus(
                context,
                customizationState,
                themeController,
              ),
              label: customizationState.labelText,
              enabled: customizationState.hasEnabled,
              appearance: TagCustomizationUtils.getAppearance(
                customizationState.selectedAppearance,
              ),
              size: TagCustomizationUtils.getSize(
                customizationState.selectedSize as Object,
              ),
              loading: customizationState.hasLoader,
              roundedCorners: customizationState.hasRoundedCorner,
            )
          : OudsTag.text(
              status: TagCustomizationUtils.getIconStatus(
                context,
                customizationState,
                themeController,
              ),
              label: customizationState.labelText,
              enabled: customizationState.hasEnabled,
              appearance: TagCustomizationUtils.getAppearance(
                customizationState.selectedAppearance,
              ),
              size: TagCustomizationUtils.getSize(
                customizationState.selectedSize as Object,
              ),
              loading: customizationState.hasLoader,
              roundedCorners: customizationState.hasRoundedCorner,
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

/// This state class handles the customization options for the tag
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
    final customizationState = TagCustomization.of(context)!;

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.hasEnabled,
          onChanged: customizationState.hasLoader == true
              ? null
              : (value) {
                  setState(() {
                    customizationState.hasEnabled = value;
                  });
                },
        ),
        CustomizableChips<TagEnumAppearance>(
          title: TagEnumAppearance.enumName(context),
          options: customizationState.appearanceState.list,
          selectedOption: customizationState.selectedAppearance,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedAppearance = selectedOption;
            });
          },
        ),
        CustomizationDropdownMenu<StatusEnum>(
          label: StatusEnum.enumName(context),
          options: customizationState.statusState.list,
          selectedItemIndex: customizationState.selectedIndex,
          selectedOption: customizationState.selectedStatus,
          getText: (option) => option.stringValue(context),
          onSelectionChange: (value, index) {
            setState(() {
              customizationState.selectedStatus = value;
              customizationState.selectedIndex = index;
            });
          },
          itemLeadingIcons: customizationState.statusState.list.map((status) {
            return () => Container(
              width: OudsTheme.of(
                context,
              ).spaceScheme(context).paddingBlockMedium,
              height: OudsTheme.of(
                context,
              ).spaceScheme(context).paddingBlockMedium,
              decoration: BoxDecoration(
                color: TagCustomizationUtils.getStatusColor(
                  context,
                  customizationState,
                  status,
                  true,
                ),
                shape: BoxShape.rectangle,
              ),
            );
          }).toList(),
        ),
        CustomizableChips<TagEnumLayout>(
          title: TagEnumLayout.enumName(context),
          options: customizationState.layoutState.list,
          selectedOption: customizationState.selectedLayout,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedLayout = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_loader_label,
          value: customizationState.hasLoader,
          onChanged: customizationState.hasEnabled == false
              ? null
              : (value) {
                  setState(() {
                    customizationState.hasLoader = value;
                  });
                },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_roundedCorner_label,
          value: customizationState.hasRoundedCorner,
          onChanged: (value) {
            setState(() {
              customizationState.hasRoundedCorner = value;
            });
          },
        ),
        CustomizableChips<TagEnumSize>(
          title: TagEnumSize.enumName(context),
          options: customizationState.sizeState.list,
          selectedOption: customizationState.selectedSize,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedSize = selectedOption;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.labelText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
      ],
    );
  }
}
