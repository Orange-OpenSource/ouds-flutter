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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox_item.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:provider/provider.dart';

import '../../utilities/app_assets.dart';
import '../control_item/control_item_customization_utils.dart';

/// This screen displays a checkbox demo and allows customization of checkbox properties.
class ControlItemDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const ControlItemDemoScreen({super.key, this.indeterminate = false});

  @override
  State<ControlItemDemoScreen> createState() => _ControlItemDemoScreenState();
}

class _ControlItemDemoScreenState extends State<ControlItemDemoScreen> {
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
        appBar: widget.indeterminate ? MainAppBar(title: context.l10n.app_components_checkbox_indeterminateCheckboxItem_label) : MainAppBar(title: context.l10n.app_components_checkbox_checkboxItem_label),
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
          _CheckboxItemDemo(indeterminate: widget.indeterminate),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: ControlItemCodeGenerator.updateCode(context, widget.indeterminate, ControlItemType.checkbox),
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the checkbox demo.
class _CheckboxItemDemo extends StatefulWidget {
  final bool indeterminate;

  const _CheckboxItemDemo({required this.indeterminate});

  @override
  _CheckboxItemDemoState createState() => _CheckboxItemDemoState();
}

class _CheckboxItemDemoState extends State<_CheckboxItemDemo> {
  bool? isCheckedFirst = false;
  bool? isCheckedSecond = false;

  ControlItemCustomizationState? customizationState;
  ThemeController? themeController;

  @override
  Widget build(BuildContext context) {
    customizationState = ControlItemCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: false);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnColoredSurface(customizationState?.hasOnColoredBox);
    });

    return CustomizableSection(children: [
      ThemeBox(
        themeContract: themeController!.currentTheme,
        themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
        child: Column(
          children: [
            OudsCheckboxItem(
              value: isCheckedFirst,
              onChanged: customizationState!.hasEnabled
                  ? (bool? newValue) {
                      setState(() {
                        isCheckedFirst = newValue;
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
              tristate: widget.indeterminate,
            ),
            OudsCheckboxItem(
              value: isCheckedSecond,
              onChanged: customizationState!.hasEnabled
                  ? (bool? newValue) {
                      setState(() {
                        isCheckedSecond = newValue;
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
              tristate: widget.indeterminate,
            ),
          ],
        ),
      ),
      ThemeBox(
        themeContract: themeController!.currentTheme,
        themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
        child: Column(
          children: [
            OudsCheckboxItem(
              value: isCheckedFirst,
              onChanged: customizationState!.hasEnabled
                  ? (bool? newValue) {
                      setState(() {
                        isCheckedFirst = newValue;
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
              tristate: widget.indeterminate,
            ),
            OudsCheckboxItem(
              value: isCheckedSecond,
              onChanged: customizationState!.hasEnabled
                  ? (bool? newValue) {
                      setState(() {
                        isCheckedSecond = newValue;
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
              tristate: widget.indeterminate,
            ),
          ],
        ),
      )
    ]);
  }
}

/// This widget represents the customization content section that appears in the bottom sheet.
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the checkbox.
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
