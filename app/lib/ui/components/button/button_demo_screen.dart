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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/ouds_colored_box.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/component_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:provider/provider.dart';

/// This screen displays a button demo and allows customization of button properties
class ButtonDemoScreen extends StatefulWidget {
  const ButtonDemoScreen({super.key});

  @override
  State<ButtonDemoScreen> createState() => _ButtonDemoScreenState();
}

class _ButtonDemoScreenState extends State<ButtonDemoScreen> {
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
        appBar: MainAppBar(title: context.l10n.app_components_button_label),
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
    return ComponentScreenHeader(
      description: context.l10n.app_components_button_description_text,
      widget: Column(
        children: [
          _ButtonDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedTall),
          Code(
            code: ButtonCodeGenerator.updateCode(context),
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the button demo
class _ButtonDemo extends StatefulWidget {
  @override
  State<_ButtonDemo> createState() => _ButtonDemoState();
}

class _ButtonDemoState extends State<_ButtonDemo> {
  ButtonCustomizationState? customizationState;
  ThemeController? themeController;

  @override
  Widget build(BuildContext context) {
    customizationState = ButtonCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: false);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnColoredSurface(customizationState?.hasOnColoredBox);
    });

    if (customizationState?.hasOnColoredBox == true) {
      return OudsColoredBox(
        color: customizationState?.hasOnColoredBox == true ? OudsColoredBoxColor.brandPrimary : OudsColoredBoxColor.statusNeutralMuted,
        child: OudsButton(
          label: ButtonCustomizationUtils.getText(customizationState),
          icon: ButtonCustomizationUtils.getIcon(customizationState),
          hierarchy: ButtonCustomizationUtils.getHierarchy(customizationState?.selectedHierarchy as Object),
          style: ButtonCustomizationUtils.getStyle(customizationState?.selectedStyle as Object),
          onPressed: customizationState?.hasEnabled == true ? () {} : null,
        ),
      );
    } else {
      return Column(
        children: [
          /// [themeMode] we test here theme of system and inverse theme mode if is not dark
          ThemeBox(
            themeContract: themeController!.currentTheme,
            themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
            child: OudsButton(
              label: ButtonCustomizationUtils.getText(customizationState),
              icon: ButtonCustomizationUtils.getIcon(customizationState),
              hierarchy: ButtonCustomizationUtils.getHierarchy(customizationState?.selectedHierarchy as Object),
              style: ButtonCustomizationUtils.getStyle(customizationState?.selectedStyle as Object),
              onPressed: customizationState?.hasEnabled == true ? () {} : null,
            ),
          ),
          ThemeBox(
            themeContract: themeController!.currentTheme,
            themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
            child: OudsButton(
              label: ButtonCustomizationUtils.getText(customizationState),
              icon: ButtonCustomizationUtils.getIcon(customizationState),
              hierarchy: ButtonCustomizationUtils.getHierarchy(customizationState?.selectedHierarchy as Object),
              style: ButtonCustomizationUtils.getStyle(customizationState?.selectedStyle as Object),
              onPressed: customizationState?.hasEnabled == true ? () {} : null,
            ),
          )
        ],
      );
    }
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
    final ButtonCustomizationState? customizationState = ButtonCustomization.of(context);
    final labelFocus = FocusNode();

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState!.hasEnabled,
          onChanged:

              /// Specific case: Enabled disabled if style is 'Loading'
              customizationState.isEnabledWhenLoading == true
                  ? null
                  : (value) {
                      customizationState.hasEnabled = value;
                    },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_onColoredBackground_label,
          value: customizationState.hasOnColoredBox,
          onChanged:

              /// Specific case: OnColoredBox disabled if hierarchy is 'Negative'
              customizationState.isOnColoredBoxDisabled == true
                  ? null
                  : (value) {
                      customizationState.hasOnColoredBox = value;
                    },
        ),
        CustomizableChips<ButtonEnumHierarchy>(
          title: ButtonEnumHierarchy.enumName(context),
          options: customizationState.hierarchyState.list,
          selectedOption: customizationState.selectedHierarchy,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedHierarchy = selectedOption;
            });
          },
        ),
        CustomizableChips<ButtonEnumStyle>(
          title: ButtonEnumStyle.enumName(context),
          options: customizationState.styleState.list,
          selectedOption: customizationState.selectedStyle,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedStyle = selectedOption;
            });
          },
        ),
        CustomizableChips<ButtonEnumLayout>(
          title: ButtonEnumLayout.enumName(context),
          options: customizationState.layoutState.list,
          selectedOption: customizationState.selectedLayout,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedLayout = selectedOption;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_button_label,
          text: customizationState.textValue,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        )
      ],
    );
  }
}
