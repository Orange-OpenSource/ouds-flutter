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
import 'package:ouds_core/components/radio_button/ouds_radio_button.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:provider/provider.dart';

import '../../utilities/theme_colored_box.dart';

enum RadioOption { first, second }

/// This screen displays a radio_button demo and allows customization of radio_button properties
class RadioButtonDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const RadioButtonDemoScreen({super.key, this.indeterminate = false}); // Default value set to false

  @override
  State<RadioButtonDemoScreen> createState() => _RadioButtonDemoScreenState();
}

class _RadioButtonDemoScreenState extends State<RadioButtonDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RadioButtonCustomization(
      child: Scaffold(
        bottomSheet: OudsSheetsBottom(
          onExpansionChanged: _onExpansionChanged,
          sheetContent: const _CustomizationContent(),
          title: context.l10n.app_common_customize_label,
        ),
        key: _scaffoldKey,
        appBar: MainAppBar(title: context.l10n.app_components_radioButton_label),
        body: SafeArea(
          child: ExcludeSemantics(excluding: !_isBottomSheetExpanded, child: _Body(indeterminate: widget.indeterminate)),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the radio_button demo and code will be displayed
class _Body extends StatefulWidget {
  final bool indeterminate;
  const _Body({required this.indeterminate});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  RadioOption _selectedOption = RadioOption.first;
  final String codeString = '''Radio<bool>(\nvalue: true,\ngroupValue: isCheckedFirst,\nonChanged: (bool? newValue) => setState(() => isCheckedFirst = newValue!),\n)''';

  void _handleRadioChanged(RadioOption newValue) {
    setState(() {
      _selectedOption = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: true);
    return DetailScreenDescription(
      description: context.l10n.app_components_radioButton_description_text,
      widget: Column(
        children: [
          _RadioButtonDemo(selectedOption: _selectedOption, updateGlobalValue: _handleRadioChanged),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(code: RadioButtonCodeGenerator.updateCode(context, widget.indeterminate, _selectedOption)),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the radio_button demo.
///
/// Component [RadioButtonDemo] demonstrates the behavior and functionality of a radio_button.
class _RadioButtonDemo extends StatefulWidget {
  final RadioOption selectedOption;
  final ValueChanged<RadioOption> updateGlobalValue;

  const _RadioButtonDemo({
    required this.selectedOption,
    required this.updateGlobalValue,
  });
  @override
  State<_RadioButtonDemo> createState() => _RadioButtonDemoState();
}

class _RadioButtonDemoState extends State<_RadioButtonDemo> {
  ThemeController? themeController;
  RadioButtonCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = RadioButtonCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: false);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnColoredSurface(customizationState?.hasOnColoredBox);
    });

    return CustomizableSection(
      children: [
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsRadioButton<RadioOption>(
                value: RadioOption.first,
                groupValue: widget.selectedOption,
                onChanged: customizationState!.hasEnabled
                    ? (RadioOption? value) {
                        setState(() {
                          widget.updateGlobalValue(value!);
                        });
                      }
                    : null,
                isError: customizationState!.hasError,
              ),
              OudsRadioButton<RadioOption>(
                value: RadioOption.second,
                groupValue: widget.selectedOption,
                onChanged: customizationState!.hasEnabled
                    ? (RadioOption? value) {
                        setState(() {
                          widget.updateGlobalValue(value!);
                        });
                      }
                    : null,
                isError: customizationState!.hasError,
              ),
            ],
          ),
        ),
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsRadioButton<RadioOption>(
                value: RadioOption.first,
                groupValue: widget.selectedOption,
                onChanged: customizationState!.hasEnabled
                    ? (RadioOption? value) {
                        setState(() {
                          widget.updateGlobalValue(value!);
                        });
                      }
                    : null,
                isError: customizationState!.hasError,
              ),
              OudsRadioButton<RadioOption>(
                value: RadioOption.second,
                groupValue: widget.selectedOption,
                onChanged: customizationState!.hasEnabled
                    ? (RadioOption? value) {
                        setState(() {
                          widget.updateGlobalValue(value!);
                        });
                      }
                    : null,
                isError: customizationState!.hasError,
              ),
            ],
          ),
        ),
        SizedBox(height: themeController?.currentTheme.spaceScheme(context).fixedSmall),
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

/// This state class handles the customization options for the Radiobutton
class _CustomizationContentState extends State<_CustomizationContent> {
  _CustomizationContentState();

  @override
  Widget build(BuildContext context) {
    final RadioButtonCustomizationState? customizationState = RadioButtonCustomization.of(context);

    return CustomizableSection(
      children: [
        CustomizableSwitch(
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
        CustomizableSwitch(
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
