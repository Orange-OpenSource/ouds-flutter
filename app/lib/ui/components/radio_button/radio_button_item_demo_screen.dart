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
import 'package:ouds_core/components/ouds_colored_box.dart';
import 'package:ouds_core/components/radio_button/ouds_radio_button_item.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_enum.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:provider/provider.dart';

class RadioButtonItemDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const RadioButtonItemDemoScreen({super.key, this.indeterminate = false});

  @override
  State<RadioButtonItemDemoScreen> createState() => _RadioButtonDemoScreenState();
}

class _RadioButtonDemoScreenState extends State<RadioButtonItemDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControlItemCustomization(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: MainAppBar(title: context.l10n.app_components_radioButton_item_label),
        body: SafeArea(
          child: ExcludeSemantics(
            excluding: !_isBottomSheetExpanded,
            child: _Body(indeterminate: widget.indeterminate),
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

/// This widget represents the body of the screen where the checkbox demo and code will be displayed.
class _Body extends StatefulWidget {
  final bool indeterminate;

  const _Body({required this.indeterminate});

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
          _RadioButtonItemDemo(indeterminate: widget.indeterminate),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedTall),
          Code(
            code: ControlItemCodeGenerator.updateCode(context, widget.indeterminate, ControlItemType.radioButton),
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the radio_button demo.
class _RadioButtonItemDemo extends StatefulWidget {
  final bool indeterminate;

  const _RadioButtonItemDemo({required this.indeterminate});

  @override
  _RadioButtonItemDemoState createState() => _RadioButtonItemDemoState();
}

class _RadioButtonItemDemoState extends State<_RadioButtonItemDemo> {
  RadioOption _selectedOption = RadioOption.first;

  ControlItemCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = ControlItemCustomization.of(context);
    return CustomizableSection(
      children: [
        OudsColoredBox(
          color: OudsColoredBoxColor.statusNeutralMuted,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsRadioButtonItem<RadioOption>(
                value: RadioOption.first,
                groupValue: _selectedOption,
                onChanged: customizationState!.hasEnabled
                    ? (RadioOption? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      }
                    : null,
                title: ControlItemCustomizationUtils.getLabelText(customizationState!),
                additionalLabel: ControlItemCustomizationUtils.getAdditionalLabelText(customizationState!),
                helperTitle: ControlItemCustomizationUtils.getHelperLabelText(customizationState!),
                outlined: customizationState!.hasOutlined ? true : false,
                reversed: customizationState!.hasReversed ? true : false,
                readOnly: customizationState!.hasReadOnly ? true : false,
                icon: customizationState!.hasIcon ? AppAssets.icons.icHeart : null,
                isError: customizationState!.hasError ? true : false,
                divider: customizationState!.hasDivider ? true : false,
              ),
              OudsRadioButtonItem<RadioOption>(
                value: RadioOption.second,
                groupValue: _selectedOption,
                onChanged: customizationState!.hasEnabled
                    ? (RadioOption? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      }
                    : null,
                title: ControlItemCustomizationUtils.getLabelText(customizationState!),
                additionalLabel: ControlItemCustomizationUtils.getAdditionalLabelText(customizationState!),
                helperTitle: ControlItemCustomizationUtils.getHelperLabelText(customizationState!),
                outlined: customizationState!.hasOutlined ? true : false,
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

/// This state class handles the customization options for the Radiobutton.
class _CustomizationContentState extends State<_CustomizationContent> {
  @override
  Widget build(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    final labelFocus = FocusNode();
    final additionalFocus = FocusNode();
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
          title: context.l10n.app_components_controlItem_outlined_label,
          value: customizationState.hasOutlined,
          onChanged: (value) {
            setState(() {
              customizationState.hasOutlined = value;
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
          title: context.l10n.app_components_controlItem_additional_label,
          text: customizationState.additionalLabelText,
          focusNode: additionalFocus,
          fieldType: FieldType.additional,
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
