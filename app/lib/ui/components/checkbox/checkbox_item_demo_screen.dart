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
import 'package:ouds_core/components/checkbox/ouds_checkbox_tri_state.dart';
import 'package:ouds_core/components/checkbox/ouds_chekbox_item.dart';
import 'package:ouds_core/components/lists/ouds_list_switch.dart';
import 'package:ouds_core/components/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/checkbox/checkbox_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:provider/provider.dart';

/// This screen displays a checkbox demo and allows customization of checkbox properties.
class CheckboxItemDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const CheckboxItemDemoScreen({super.key, this.indeterminate = false}); // Default value set to false

  @override
  State<CheckboxItemDemoScreen> createState() => _CheckboxItemDemoScreenState();
}

class _CheckboxItemDemoScreenState extends State<CheckboxItemDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxCustomization(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: widget.indeterminate
            ? MainAppBar(title: context.l10n.app_components_checkbox_indeterminateCheckboxItem_label)
            : MainAppBar(title: context.l10n.app_components_checkbox_checkboxItem_label),
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

  const _Body({required this.indeterminate}); // Constructor to accept indeterminate

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
          widget.indeterminate ? _IndeterminateCheckboxItemDemo() : _CheckboxItemDemo(),
          SizedBox(height: themeController.currentTheme.spaceTokens.fixedTall),
          Code(
            code:
                '''OudsCheckbox(\nchecked: isCheckedFirst, \nonCheckedChange: (bool newValue) { \n setState(() { \n  isCheckedFirst = newValue; \n }); \n},\nenabled: true, \nerror: false, \n)''',
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the checkbox demo.
class _CheckboxItemDemo extends StatefulWidget {
  @override
  _CheckboxItemDemoState createState() => _CheckboxItemDemoState();
}

class _CheckboxItemDemoState extends State<_CheckboxItemDemo> {
  bool isCheckedFirst = false;
  bool isCheckedSecond = false;

  CheckboxCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = CheckboxCustomization.of(context);
    return Column(
      children: [
        OudsCheckboxItem(
          checked: isCheckedFirst,
          text: 'Label',
          onCheckedChange: (bool newValue) {
            setState(() {
              isCheckedFirst = newValue; // Met à jour l'état de la case à cocher
            });
          },
          helperText: 'Helper text',
          icon: Icon(Icons.favorite_border),
          enabled: true,
          error: false, // Contrôle si la case à cocher est en état d'erreur
        ),
      ],
    );
  }
}

/// This widget is now a StatefulWidget for the indeterminate checkbox demo.
class _IndeterminateCheckboxItemDemo extends StatefulWidget {
  @override
  State<_IndeterminateCheckboxItemDemo> createState() => _IndeterminateCheckboxItemDemoState();
}

class _IndeterminateCheckboxItemDemoState extends State<_IndeterminateCheckboxItemDemo> {
  ToggleableState state = ToggleableState.off;
  ToggleableState state2 = ToggleableState.off;

  CheckboxCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = CheckboxCustomization.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OudsTriStateCheckbox(
          state: state,
          onChanged: (ToggleableState newValue) {
            setState(() {
              state = newValue;
            });
          },
          enabled: customizationState!.hasEnabled,
          error: customizationState!.hasError,
        ),
        OudsTriStateCheckbox(
          state: state2,
          onChanged: (ToggleableState newValue) {
            setState(() {
              state2 = newValue;
            });
          },
          enabled: customizationState!.hasEnabled,
          error: customizationState!.hasError,
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
    final customizationState = CheckboxCustomization.of(context);

    return CustomizableSection(
      children: [
        OudsListSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState!.hasEnabled,
          onChanged: customizationState.isEnabledWhenError
              ? null // Disable the switch if there is an error
              : (value) {
                  setState(() {
                    customizationState.hasEnabled = value;
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
      ],
    );
  }
}
