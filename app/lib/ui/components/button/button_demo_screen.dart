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
import 'package:flutter_gen/gen_l10n/ouds_flutter_app_localizations.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/lists/ouds_list_switch.dart';
import 'package:ouds_core/components/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';

class ButtonDemoScreen extends StatelessWidget {
  ButtonDemoScreen({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ButtonCustomization(
      child: Scaffold(
        bottomSheet: OudsSheetsBottom(
          sheetContent: const _CustomizationContent(),
          title: AppLocalizations.of(context)!.app_common_customize_label,
        ),
        key: _scaffoldKey,
        appBar: MainAppBar(
            title: AppLocalizations.of(context)!.app_components_button_label),
        body: SafeArea(child: _Body()),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DetailScreenDescription(
      description:
          AppLocalizations.of(context)!.app_components_button_description_text,
      widget: Column(
        children: [
          _buttonDemo(context),
          _buttonDemo(context),
        ],
      ),
    );
  }
}

Widget _buttonDemo(BuildContext context) {
  final ButtonCustomizationState? customizationState =
      ButtonCustomization.of(context);

  return Container(
    height: 80,
    width: double.infinity,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white,
    child: Center(
      child: OudsButton(
        label: AppLocalizations.of(context)!.app_components_button_label,
        onClick: customizationState?.hasEnabled == true ? () {} : null,
      ),
    ),
  );
}

class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

class _CustomizationContentState extends State<_CustomizationContent> {
  _CustomizationContentState();

  @override
  Widget build(BuildContext context) {
    final ButtonCustomizationState? customizationState =
        ButtonCustomization.of(context);

    return CustomizableSection(
      children: [
        OudsListSwitch(
          title: AppLocalizations.of(context)!.app_common_enabled_label,
          checked: customizationState!.hasEnabled,
          onCheckedChange: (bool value) {
            customizationState.hasEnabled = value;
          },
        ),
        OudsListSwitch(
          title: AppLocalizations.of(context)!
              .app_components_common_onColoredBackground_label,
          checked: customizationState.hasOnColoredBox,
          onCheckedChange: (bool value) {
            customizationState.hasOnColoredBox = value;
          },
        ),
        CustomizableChips<ButtonsEnumHierarchy>(
          title: ButtonsEnumHierarchy.enumName(context),
          options: customizationState.hierarchy,
          selectedOption: customizationState.selectedHierarchy,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedHierarchy = selectedOption;
            });
          },
        ),
        CustomizableChips<ButtonsEnumStyle>(
          title: ButtonsEnumStyle.enumName(context),
          options: customizationState.style,
          selectedOption: customizationState.selectedStyle,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedStyle = selectedOption;
            });
          },
        ),
        CustomizableChips<ButtonsEnumLayout>(
          title: ButtonsEnumLayout.enumName(context),
          options: customizationState.layout,
          selectedOption: customizationState.selectedLayout,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedLayout = selectedOption;
            });
          },
        ),
      ],
    );
  }
}
