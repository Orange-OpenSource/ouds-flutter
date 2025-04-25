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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox_item.dart';
import 'package:ouds_core/components/lists/ouds_list_switch.dart';
import 'package:ouds_core/components/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_core/ouds_theme.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:provider/provider.dart';

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
        appBar:
            widget.indeterminate ? MainAppBar(title: context.l10n.app_components_checkbox_indeterminateCheckboxItem_label) : MainAppBar(title: context.l10n.app_components_checkbox_checkboxItem_label),
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
          SizedBox(height: themeController.currentTheme.spaceTokens.fixedTall),
          Code(
            code: '''OudsCheckbox(\nchecked: isCheckedFirst, \nonCheckedChange: (bool newValue) { \n setState(() { \n  isCheckedFirst = newValue; \n }); \n},\nenabled: true, \nerror: false, \n)''',
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
  bool? isCheckedThird = false;

  ControlItemCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = ControlItemCustomization.of(context);
    return Column(
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
          inverted: customizationState!.hasInverted ? true : false,
          readOnly: customizationState!.hasReadOnly ? true : false,
          icon: customizationState!.hasIcon
              ? SvgPicture.asset(
                  'assets/ic_heart.svg',
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    OudsTheme.of(context).colorsScheme.actionEnabled,
                    BlendMode.srcIn,
                  ),
                )
              : null,
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
          inverted: customizationState!.hasInverted ? true : false,
          readOnly: customizationState!.hasReadOnly ? true : false,
          icon: customizationState!.hasIcon
              ? SvgPicture.asset(
                  'assets/ic_heart.svg',
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    OudsTheme.of(context).colorsScheme.actionEnabled,
                    BlendMode.srcIn,
                  ),
                )
              : null,
          isError: customizationState!.hasError ? true : false,
          divider: customizationState!.hasDivider ? true : false,
          tristate: widget.indeterminate,
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

/// This state class handles the customization options for the checkbox.
class _CustomizationContentState extends State<_CustomizationContent> {
  @override
  Widget build(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);
    final labelFocus = FocusNode();
    final helperFocus = FocusNode();

    return CustomizableSection(
      children: [
        OudsListSwitch(
          title: context.l10n.app_components_controlItem_icon_label,
          value: customizationState!.hasIcon,
          onChanged: (value) {
            setState(() {
              customizationState.hasIcon = value;
            });
          },
        ),
        OudsListSwitch(
          title: context.l10n.app_components_controlItem_divider_label,
          value: customizationState.hasDivider,
          onChanged: (value) {
            setState(() {
              customizationState.hasDivider = value;
            });
          },
        ),
        OudsListSwitch(
          title: context.l10n.app_components_controlItem_inverted_label,
          value: customizationState.hasInverted,
          onChanged: (value) {
            setState(() {
              customizationState.hasInverted = value;
            });
          },
        ),
        OudsListSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.hasEnabled,
          onChanged: customizationState.isEnabledWhenError
              ? null // Disable the switch if there is an error
              : (value) {
                  setState(() {
                    customizationState.hasEnabled = value;
                  });
                },
        ),
        OudsListSwitch(
          title: context.l10n.app_components_controlItem_readOnly_label,
          value: customizationState.hasReadOnly,
          onChanged: (value) {
            setState(() {
              customizationState.hasReadOnly = value;
            });
          },
        ),
        OudsListSwitch(
          title: context.l10n.app_components_common_error_label,
          value: customizationState.hasError,
          onChanged: customizationState.isErrorWhenEnabled
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
