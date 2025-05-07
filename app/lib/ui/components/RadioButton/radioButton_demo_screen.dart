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
import 'package:ouds_core/components/radio/ouds_radio_button.dart';
import 'package:ouds_core/components/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/RadioButton/radioButton_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/RadioButton/radioButton_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:provider/provider.dart';

/// This screen displays a RadioButton demo and allows customization of RadioButton properties
class RadioButtonDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const RadioButtonDemoScreen(
      {super.key, this.indeterminate = false}); // Default value set to false

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
        appBar:
            MainAppBar(title: context.l10n.app_components_radioButton_label),
        body: SafeArea(
          child: ExcludeSemantics(
              excluding: !_isBottomSheetExpanded,
              child: _Body(indeterminate: widget.indeterminate)),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the RadioButton demo and code will be displayed
class _Body extends StatefulWidget {
  final bool indeterminate;
  const _Body({required this.indeterminate});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController =
        Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      description: context.l10n.app_components_radioButton_description_text,
      widget: Column(
        children: [
          _RadioButtonDemo(),
          SizedBox(height: themeController.currentTheme.spaceTokens.fixedTall),
          Code(code: RadiobuttonCodeGenerator.updateCode(context, widget.indeterminate)),
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

  bool isSelectedFirst = false;
  //bool isSelectedSecond = false;
  RadioButtonCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = RadioButtonCustomization.of(context);

    return CustomizableSection(
      children: [
        OudsColoredBox(
          color:  OudsColoredBoxColor.statusNeutralMuted,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsRadioButton(
              value: isSelectedFirst,
                onClick: (bool newValue) {
                setState(() {
                  isSelectedFirst = newValue;
                });
              },
              enabled: customizationState!.hasEnabled,
              error: customizationState!.hasError,
            ),
            OudsRadioButton(
              value: !isSelectedFirst,
              onClick: (bool newValue) {
                setState(() {
                  isSelectedFirst = !newValue;
                });
              },
              enabled: customizationState!.hasEnabled,
              error: customizationState!.hasError,
            ),
          ],
          ),
        ),
        SizedBox(height: themeController?.currentTheme.spaceTokens.fixedShort),
        /*OudsColoredBox(
          color: OudsColoredBoxColor.statusNeutralEmphasized,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsRadioButton(
                value: isCheckedFirst,
                onChanged: (bool newValue) {
                  setState(() {
                    isCheckedFirst = newValue;
                    isCheckedSecond = !newValue;
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
                    isCheckedFirst = !newValue;
                  });
                },
                enabled: customizationState!.hasEnabled,
                error: customizationState!.hasError,
              ),
            ],
          ),
        ),*/
      ],
    );
  }
}
