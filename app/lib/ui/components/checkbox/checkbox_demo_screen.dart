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
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/lists/ouds_list_switch.dart';
import 'package:ouds_core/components/ouds_colored_box.dart';
import 'package:ouds_core/components/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/checkbox/checkbox_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/checkbox/checkbox_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:provider/provider.dart';

/// This screen displays a checkbox demo and allows customization of checkbox properties
class CheckboxDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const CheckboxDemoScreen({super.key, this.indeterminate = false}); // Default value set to false

  @override
  State<CheckboxDemoScreen> createState() => _CheckboxDemoScreenState();
}

class _CheckboxDemoScreenState extends State<CheckboxDemoScreen> {
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
        bottomSheet: OudsSheetsBottom(
          onExpansionChanged: _onExpansionChanged,
          sheetContent: const _CustomizationContent(),
          title: context.l10n.app_common_customize_label,
        ),
        key: _scaffoldKey,
        appBar: widget.indeterminate
            ? MainAppBar(title: context.l10n.app_components_checkbox_indeterminateCheckbox_label) // Display IndeterminateCheckboxDemo if true
            : MainAppBar(title: context.l10n.app_components_checkbox_label),
        body: SafeArea(
          child: ExcludeSemantics(
            excluding: !_isBottomSheetExpanded,
            child: _Body(indeterminate: widget.indeterminate),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the checkbox demo and code will be displayed
class _Body extends StatefulWidget {
  final bool indeterminate;

  const _Body({required this.indeterminate});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      widget: Column(
        children: [
          _CheckboxDemo(indeterminate: widget.indeterminate),
          SizedBox(height: themeController.currentTheme.spaceTokens.fixedTall),
          Code(
            code: CheckboxCodeGenerator.updateCode(context, widget.indeterminate),
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the checkbox demo.
///
/// Component [CheckboxDemo] demonstrates the behavior and functionality of a checkbox.
class _CheckboxDemo extends StatefulWidget {
  final bool indeterminate;

  const _CheckboxDemo({required this.indeterminate});

  @override
  State<_CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  ThemeController? themeController;
  bool? isCheckedFirst = false;
  bool? isCheckedSecond = false;

  CheckboxCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = CheckboxCustomization.of(context);

    return OudsColoredBox(
      color: OudsColoredBoxColor.statusNeutralMuted,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OudsCheckbox(
            value: isCheckedFirst,
            onChanged: customizationState?.hasEnabled == true
                ? (bool? newValue) {
                    setState(() {
                      isCheckedFirst = newValue;
                    });
                  }
                : null,
            isError: customizationState!.hasError,
            tristate: widget.indeterminate,
          ),
          OudsCheckbox(
            value: isCheckedSecond,
            onChanged: customizationState?.hasEnabled == true
                ? (bool? newValue) {
                    setState(() {
                      isCheckedSecond = newValue;
                    });
                  }
                : null,
            isError: customizationState!.hasError ? true : false,
            tristate: widget.indeterminate,
          ),
        ],
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

/// This state class handles the customization options for the checkbox
class _CustomizationContentState extends State<_CustomizationContent> {
  _CustomizationContentState();

  @override
  Widget build(BuildContext context) {
    final CheckboxCustomizationState? customizationState = CheckboxCustomization.of(context);

    return CustomizableSection(
      children: [
        OudsListSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState!.hasEnabled,
          onChanged:

              /// Specific case: The switch is disabled if there is an error (hasError is true).
              customizationState.isEnabledWhenError == true
                  ? null // Disable the switch if there is an error
                  : (value) {
                      customizationState.hasEnabled = value;
                    },
        ),
        OudsListSwitch(
          title: context.l10n.app_components_common_error_label,
          value: customizationState.hasError,
          onChanged:

              /// Specific case: The switch is disabled if it is not enabled (hasEnabled is false).
              customizationState.isErrorWhenEnabled == true
                  ? null // Disable the switch if not enabled
                  : (value) {
                      customizationState.hasError = value;
                    },
        ),
      ],
    );
  }
}
