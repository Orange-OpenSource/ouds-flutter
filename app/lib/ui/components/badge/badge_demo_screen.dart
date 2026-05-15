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
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_enum.dart';
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

/// This screen displays a radio_button demo and allows customization of radio_button properties
class BadgeDemoScreen extends StatefulWidget {
  final String? previousPageTitle;

  const BadgeDemoScreen({
    super.key,
    this.previousPageTitle,
  }); // Default value set to false

  @override
  State<BadgeDemoScreen> createState() => _BadgeDemoScreenState();
}

class _BadgeDemoScreenState extends State<BadgeDemoScreen> {
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
      child: BadgeCustomization(
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
              title: context.l10n.app_components_badge_label,
              previousPageTitle: widget.previousPageTitle,
              showBackButton: true,
            ),
            // SafeArea is intentionally not used to allow the TopAppBar blur effect
            // in body content added top padding so the content is not hidden behind the top app bar
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

/// This widget represents the body of the screen where the radio_button demo and code will be displayed
class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final customizationState = BadgeCustomization.of(context)!;
    ThemeController? themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );

    //after update of badge component, each variant of badge component have his only version,
    // so we need to retrieve the version based on the selected type
    String getVersion() {
      switch (customizationState.selectedType) {
        case BadgeEnumType.standard:
          return OudsComponentVersion.badge;
        case BadgeEnumType.count:
          return OudsComponentVersion.badgeCount;
        case BadgeEnumType.icon:
          return OudsComponentVersion.badgeIcon;
      }
    }

    return DetailScreenDescription(
      description: context.l10n.app_components_badge_description_text,
      widget: Column(
        children: [
          _BadgeDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(code: BadgeCodeGenerator.updateCode(context)),
          //after update of badge component, each variant of badge component have his only version,
          // so we need to retrieve the version based on the selected type
          ReferenceDesignVersionComponent(version: getVersion()),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the radio_button demo.
///
/// Component [BadgeDemo] demonstrates the behavior and functionality of a radio_button.
class _BadgeDemo extends StatefulWidget {
  @override
  State<_BadgeDemo> createState() => _BadgeDemoState();
}

class _BadgeDemoState extends State<_BadgeDemo> {
  String? label;

  @override
  Widget build(BuildContext context) {
    final customizationState = BadgeCustomization.of(
      context,
    )!; // safe to use !;
    final themeController = Provider.of<ThemeController>(context, listen: true);
    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController.setOnColoredSurface(customizationState.hasOnColoredBox);
    });
    return Column(
      children: [
        LightDarkBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customizationState.selectedType == BadgeEnumType.count
                  ? OudsBadge.count(
                      label:
                          customizationState.selectedType == BadgeEnumType.count
                          ? BadgeCustomizationUtils.getNumberText(
                              customizationState,
                            )
                          : null,
                      size: BadgeCustomizationUtils.getSize(
                        customizationState.selectedState,
                      ),
                      status: BadgeCustomizationUtils.getIconStatus(
                        context,
                        customizationState,
                        themeController,
                      ),
                      enabled: customizationState.hasEnabled,
                      semanticsLabel: BadgeCustomizationUtils.getSemanticLabel(
                        context,
                        customizationState,
                      ),
                    )
                  : customizationState.selectedType == BadgeEnumType.icon
                  ? OudsBadge.icon(
                      size: BadgeCustomizationUtils.getSize(
                        customizationState.selectedState,
                      ),
                      enabled: customizationState.hasEnabled,
                      semanticsLabel: BadgeCustomizationUtils.getSemanticLabel(
                        context,
                        customizationState,
                      ),
                      status: BadgeCustomizationUtils.getIconStatus(
                        context,
                        customizationState,
                        themeController,
                      ),
                    )
                  : OudsBadge.standard(
                      size: BadgeCustomizationUtils.getSize(
                        customizationState.selectedState,
                      ),
                      status: BadgeCustomizationUtils.getIconStatus(
                        context,
                        customizationState,
                        themeController,
                      ),
                      enabled: customizationState.hasEnabled,
                      semanticsLabel: BadgeCustomizationUtils.getSemanticLabel(
                        context,
                        customizationState,
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: themeController.currentTheme.spaceScheme(context).fixedSmall,
        ),
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
    final customizationState = BadgeCustomization.of(context)!;
    final theme = OudsTheme.of(context).spaceScheme(context);
    var status = customizationState.statusState.list;
    var size = customizationState.sizeState.list;
    var style = customizationState.typeState.list;

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.hasEnabled,
          onChanged: (value) {
            setState(() {
              customizationState.hasEnabled = value;
            });
          },
        ),
        CustomizableChips<BadgeEnumType>(
          title: BadgeEnumType.enumName(context),
          options: style,
          selectedOption: customizationState.selectedType,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedType = selectedOption;
            });
          },
        ),
        CustomizableChips<BadgeEnumSize>(
          title: BadgeEnumSize.enumName(context),
          options: size,
          selectedOption: customizationState.selectedState,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              bool isTypeTrigger =
                  customizationState.selectedType == BadgeEnumType.count;
              bool isSizeTrigger =
                  selectedOption == BadgeEnumSize.xsmall ||
                  selectedOption == BadgeEnumSize.small;

              if (isTypeTrigger && isSizeTrigger) {
                customizationState.selectedType = BadgeEnumType.standard;
              }
              customizationState.selectedState = selectedOption;
            });
          },
        ),
        CustomizationDropdownMenu<StatusEnum>(
          label: StatusEnum.enumName(context),
          options: status,
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
              width: theme.paddingBlockMedium,
              height: theme.paddingBlockMedium,
              decoration: BoxDecoration(
                color: BadgeCustomizationUtils.getStatusColor(
                  context,
                  status,
                  true,
                ),
                shape: BoxShape.rectangle,
              ),
            );
          }).toList(),
        ),
        CustomizableTextField(
          fieldEnable: customizationState.selectedType == BadgeEnumType.count,
          keyboardType: TextInputType.number,
          title: context.l10n.app_components_badge_count_label,
          text: customizationState.countText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
      ],
    );
  }
}
