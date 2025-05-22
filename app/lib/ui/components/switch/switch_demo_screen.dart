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
import 'package:ouds_core/components/switch/ouds_switch.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/switch/switch_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/switch/switch_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:provider/provider.dart';

/// This screen displays a checkbox demo and allows customization of switch properties
class SwitchDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const SwitchDemoScreen({super.key, this.indeterminate = false}); // Default value set to false

  @override
  State<SwitchDemoScreen> createState() => _SwitchDemoScreenState();
}

class _SwitchDemoScreenState extends State<SwitchDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchCustomization(
      child: Scaffold(
        bottomSheet: OudsSheetsBottom(
          onExpansionChanged: _onExpansionChanged,
          sheetContent: const _CustomizationContent(),
          title: context.l10n.app_common_customize_label,
        ),
        key: _scaffoldKey,
        appBar: MainAppBar(title: context.l10n.app_components_switch_label),
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

/// This widget represents the body of the screen where the checkbox demo and code will be displayed
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
          _SwitchDemo(),
          SizedBox(height: themeController.currentTheme.spaceTokens.fixedTall),
          Code(
            code: SwitchCodeGenerator.updateCode(context),
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the checkbox demo.
///
/// Component [SwitchDemo] demonstrates the behavior and functionality of a checkbox.
class _SwitchDemo extends StatefulWidget {
  @override
  State<_SwitchDemo> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<_SwitchDemo> {
  ThemeController? themeController;

  SwitchCustomizationState? customizationState;
  bool isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    customizationState = SwitchCustomization.of(context);

    return OudsColoredBox(
      color: OudsColoredBoxColor.statusNeutralMuted,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OudsSwitch(
            value: isSwitchOn,
            enabled: customizationState?.hasEnabled == true,
            onChanged: (newValue) {
              setState(() {
                isSwitchOn = newValue;
              });
            },
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
    final SwitchCustomizationState? customizationState = SwitchCustomization.of(context);

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
      ],
    );
  }
}
