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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/tag/ouds_tag_input.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_input_code_generator.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

class TagInputDemoScreen extends StatefulWidget {
  const TagInputDemoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TagInputDemoScreenState();
}

class _TagInputDemoScreenState extends State<TagInputDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = true;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TagCustomization(
      child: Padding(
        padding:EdgeInsets.only(bottom: Platform.isAndroid
            ? MediaQuery.of(context).viewPadding.bottom
            : OudsTheme.of(context).spaceScheme(context).paddingBlockNone
        ),
        child: Scaffold(
          bottomSheet: OudsSheetsBottom(
            onExpansionChanged: _onExpansionChanged,
            sheetContent: const _CustomizationContent(),
            title: context.l10n.app_common_customize_label,
          ),
          key: _scaffoldKey,
          appBar: MainAppBar(title: context.l10n.app_components_tagInput_label),
          body: SafeArea(
            child: ExcludeSemantics(excluding: !_isBottomSheetExpanded, child: _Body()),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the tag demo and code will be displayed
class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      description: context.l10n.app_components_tagInput_description_text,
      widget: Column(
        children: [
          _TagInputDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: TagInputCodeGenerator.updateCode(context),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.tag,
          )
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the tag demo.
///
/// Component [ChipSuggestionDemo] demonstrates the behavior and functionality of a tag.
class _TagInputDemo extends StatefulWidget {
  const _TagInputDemo();

  @override
  State<_TagInputDemo> createState() => _TagInputDemoState();
}

class _TagInputDemoState extends State<_TagInputDemo> {
  ThemeController? themeController;
  TagCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = TagCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: true);

    return Column(
      children: [
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
          child: OudsTagInput(
            label: customizationState?.labelText ?? "",
            onPressed: customizationState?.hasEnabled == true ? () {} : null,
          ),
        ),
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: OudsTagInput(
            label: customizationState?.labelText ?? "",
            onPressed: customizationState?.hasEnabled == true ? () {} : null,
          ),
        ),
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

/// This state class handles the customization options for the tag
class _CustomizationContentState extends State<_CustomizationContent> {
  _CustomizationContentState();

  @override
  Widget build(BuildContext context) {
    final TagCustomizationState? customizationState = TagCustomization.of(context);
    final labelFocus = FocusNode();

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState!.hasEnabled,
          onChanged: (value) {
            customizationState.hasEnabled = value;
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.labelText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        )
      ],
    );
  }
}
