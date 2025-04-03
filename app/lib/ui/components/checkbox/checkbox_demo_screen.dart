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
import 'package:ouds_core/components/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:provider/provider.dart';

/// This screen displays a button demo and allows customization of button properties
class CheckboxDemoScreen extends StatefulWidget {
  const CheckboxDemoScreen({super.key});

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
    return ButtonCustomization(
      child: Scaffold(
        bottomSheet: OudsSheetsBottom(
          onExpansionChanged: _onExpansionChanged,
          sheetContent: const _CustomizationContent(),
          title: context.l10n.app_common_customize_label,
        ),
        key: _scaffoldKey,
        appBar: MainAppBar(title: context.l10n.app_components_checkbox_label),
        body: SafeArea(
          child: ExcludeSemantics(
            excluding: !_isBottomSheetExpanded,
            child: _Body(),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the button demo and code will be displayed
class _Body extends StatefulWidget {
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
          _CheckboxDemo(),
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

/// This widget is now a StatefulWidget for the button demo
class _CheckboxDemo extends StatefulWidget {
  @override
  State<_CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  ThemeController? themeController;
  bool isCheckedFirst = false;
  bool isCheckedSecond = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OudsCheckbox(
          checked: isCheckedFirst,
          onCheckedChange: (bool newValue) {
            setState(() {
              isCheckedFirst = newValue;
            });
          },
          enabled: true,
          error: false,
        ),
        OudsCheckbox(
          checked: isCheckedSecond,
          onCheckedChange: (bool newValue) {
            setState(() {
              isCheckedSecond = newValue;
            });
          },
          enabled: true,
          error: false,
        )
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

/// This state class handles the customization options for the button
class _CustomizationContentState extends State<_CustomizationContent> {
  _CustomizationContentState();

  @override
  Widget build(BuildContext context) {
    return CustomizableSection(
      children: [],
    );
  }
}
