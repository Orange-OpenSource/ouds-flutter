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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/switch/ouds_switch_item.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_controller.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:provider/provider.dart';

class SwitchButtonItemDemoScreen extends StatefulWidget {
  const SwitchButtonItemDemoScreen({super.key});

  @override
  State<SwitchButtonItemDemoScreen> createState() => _SwitchButtonItemDemoScreenState();
}

class _SwitchButtonItemDemoScreenState extends State<SwitchButtonItemDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Injecting the ControlItemController into GetX with the specified control item type
    Get.put(ControlItemController(controlItemType: ControlItemType.switchButton));

    return ControlItemCustomization(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: MainAppBar(title: context.l10n.app_components_switch_switchItem_label),
        body: SafeArea(
          child: ExcludeSemantics(
            excluding: !_isBottomSheetExpanded,
            child: _Body(),
          ),
        ),
        bottomSheet: OudsSheetsBottom(
          onExpansionChanged: _onExpansionChanged,
          sheetContent: const _CustomizationContent(),
          title: context.l10n.app_common_customize_label,
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the switch demo and code will be displayed.
class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      widget: Column(
        children: [
          _SwitchButtonItemDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: ControlItemCodeGenerator.updateCode(context, false, ControlItemType.switchButton),
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the switch_button demo.
class _SwitchButtonItemDemo extends StatefulWidget {
  @override
  _SwitchButtonItemDemoState createState() => _SwitchButtonItemDemoState();
}

class _SwitchButtonItemDemoState extends State<_SwitchButtonItemDemo> {
  ThemeController? themeController;
  bool _isSwitchOn = true;

  ControlItemCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = ControlItemCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: true);

    return Column(
      children: [
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
          child: Column(
            children: [
              OudsSwitchButtonItem(
                value: _isSwitchOn,
                onChanged: customizationState!.hasEnabled
                    ? (bool? newValue) {
                        setState(() {
                          _isSwitchOn = newValue!;
                        });
                      }
                    : null,
                title: ControlItemCustomizationUtils.getLabelText(customizationState!),
                helperTitle: ControlItemCustomizationUtils.getHelperLabelText(customizationState!),
                reversed: customizationState!.hasReversed ? true : false,
                readOnly: customizationState!.hasReadOnly ? true : false,
                icon: customizationState!.hasIcon ? AppAssets.icons.icHeart : null,
                isError: customizationState!.hasError ? true : false,
                divider: customizationState!.hasDivider ? true : false,
              ),
            ],
          ),
        ),
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: Column(
            children: [
              OudsSwitchButtonItem(
                value: _isSwitchOn,
                onChanged: customizationState!.hasEnabled
                    ? (bool? newValue) {
                        setState(() {
                          _isSwitchOn = newValue!;
                        });
                      }
                    : null,
                title: ControlItemCustomizationUtils.getLabelText(customizationState!),
                helperTitle: ControlItemCustomizationUtils.getHelperLabelText(customizationState!),
                reversed: customizationState!.hasReversed ? true : false,
                readOnly: customizationState!.hasReadOnly ? true : false,
                icon: customizationState!.hasIcon ? AppAssets.icons.icHeart : null,
                isError: customizationState!.hasError ? true : false,
                divider: customizationState!.hasDivider ? true : false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// This widget represents the customization content section that appears in the bottom sheet.
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the switch_button.
class _CustomizationContentState extends State<_CustomizationContent> {
  @override
  Widget build(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    final labelFocus = FocusNode();
    final helperFocus = FocusNode();

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_components_controlItem_icon_label,
          value: customizationState!.hasIcon,
          onChanged: (value) {
            setState(() {
              customizationState.hasIcon = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_controlItem_divider_label,
          value: customizationState.hasDivider,
          onChanged: (value) {
            setState(() {
              customizationState.hasDivider = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_controlItem_reversed_label,
          value: customizationState.hasReversed,
          onChanged: (value) {
            setState(() {
              customizationState.hasReversed = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.hasEnabled,
          onChanged: customizationState.isEnabledWhenError || customizationState.isEnabledWhenReadOnly
              ? null // Disable the switch if there is an error
              : (value) {
                  setState(() {
                    customizationState.hasEnabled = value;
                  });
                },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_controlItem_readOnly_label,
          value: customizationState.hasReadOnly,
          onChanged: customizationState.isReadOnlyWhenError || customizationState.isReadOnlyWhenEnabled
              ? null
              : (value) {
                  setState(() {
                    customizationState.hasReadOnly = value;
                  });
                },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_error_label,
          value: customizationState.hasError,
          onChanged: customizationState.isErrorWhenEnabled || customizationState.isErrorWhenReadOnly
              ? null // Disable the switch if not enabled
              : (value) {
                  setState(() {
                    customizationState.hasError = value;
                  });
                },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_controlItem_label_label,
          text: customizationState.labelText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_controlItem_helperText_label,
          text: customizationState.helperLabelText,
          focusNode: helperFocus,
          fieldType: FieldType.helper,
        ),
      ],
    );
  }
}
