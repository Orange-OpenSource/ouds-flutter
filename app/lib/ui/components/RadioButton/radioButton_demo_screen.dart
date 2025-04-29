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
import 'package:ouds_core/components/radio/ouds_radio_button.dart';
import 'package:ouds_core/components/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/RadioButton/radioButton_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:provider/provider.dart';

/// This screen displays a RadioButton demo and allows customization of RadioButton properties
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
           sheetContent: Container(),
          title: context.l10n.app_common_customize_label,
        ),
        key: _scaffoldKey,
        appBar: widget.indeterminate
            ? MainAppBar(title: "Radio Button") // Display IndeterminateRadioButtonDemo if true
            : MainAppBar(title: "Radio Button"),
        body: SafeArea(
          child: ExcludeSemantics(
            excluding: !_isBottomSheetExpanded,
            child: _Body()
          ),
        ),
      ),
    );
  }
}
/// This widget represents the body of the screen where the RadioButton demo and code will be displayed
class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final String codeString = '''Radio<bool>(\nvalue: true,\ngroupValue: isCheckedFirst,\nonChanged: (bool? newValue) => setState(() => isCheckedFirst = newValue!),\n)''';

  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      description: context.l10n.app_components_button_description_text,
      widget: Column(
        children: [
          _RadioButtonDemo(),
          SizedBox(height: themeController.currentTheme.spaceTokens.fixedTall),
          Code(
            code: codeString
          ),
        ],
      ),
    );
  }
}


/// This widget is now a StatefulWidget for the RadioButton demo.
///
/// Component [RadioButtonDemo] demonstrates the behavior and functionality of a RadioButton.
class _RadioButtonDemo extends StatefulWidget {
  @override
  State<_RadioButtonDemo> createState() => _RadioButtonDemoState();
}

class _RadioButtonDemoState extends State<_RadioButtonDemo> {
  ThemeController? themeController;
  bool isCheckedFirst = false;
  bool isCheckedSecond = false;

  RadioButtonCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = RadioButtonCustomization.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OudsRadioButton(
          value: isCheckedFirst,
          onChanged: (bool newValue) {
            setState(() {
              isCheckedFirst = newValue;
            });
          },
          enabled: customizationState!.hasEnabled,
          error: customizationState!.hasError,
        ),
        OudsRadioButton(
          value: isCheckedSecond,
          onChanged: (bool newValue) {
            setState(() {
              isCheckedSecond = newValue;
            });
          },
          enabled: customizationState!.hasEnabled,
          error: customizationState!.hasError,
        ),
      ],
    );
  }
}
