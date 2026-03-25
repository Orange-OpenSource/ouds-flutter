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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// This screen displays a button demo and allows customization of button properties
class ButtonDemoScreen extends StatefulWidget {
  const ButtonDemoScreen({super.key});

  @override
  State<ButtonDemoScreen> createState() => _ButtonDemoScreenState();
}

class _ButtonDemoScreenState extends State<ButtonDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = true;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  late String previousPageTitle;

  @override
  void initState() {
    super.initState();
    previousPageTitle = Get.arguments?['previousPageTitle'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: ButtonCustomization(
        child: Padding(
          padding: EdgeInsets.only(bottom: defaultTargetPlatform == TargetPlatform.android ? MediaQuery.of(context).viewPadding.bottom : OudsTheme.of(context).spaceScheme(context).paddingBlockNone),
          child: Scaffold(
            bottomSheet: OudsSheetsBottom(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: MainAppBar(
              title: context.l10n.app_components_button_label,
              showBackButton: true,
                previousPageTitle: previousPageTitle),
            body: ExcludeSemantics(
              excluding: !_isBottomSheetExpanded,
              child: _Body(),
            ),
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
      description: context.l10n.app_components_button_description_text,
      widget: Column(
        children: [
          _ButtonDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: ButtonCodeGenerator.updateCode(context),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.button,
          )
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
    themeController = Provider.of<ThemeController>(context, listen: true);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnColoredSurface(customizationState?.hasOnColoredBox);
    });

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnBorderRadiusButtonState(customizationState?.hasRoundedCorner);
    });

    if (customizationState?.hasOnColoredBox == true) {
      return ComponentDemoBox(
        colored: customizationState?.hasOnColoredBox == true,
        child: OudsButton(
          label: ButtonCustomizationUtils.getText(customizationState),
          icon: ButtonCustomizationUtils.getIcon(customizationState, themeController!),
          appearance: ButtonCustomizationUtils.getAppearance(customizationState?.selectedAppearance as Object),
          loader: ButtonCustomizationUtils.getLoader(customizationState),
          onPressed: customizationState?.hasEnabled == true ? () {} : null,
          isFullWidth: customizationState?.hasFullWidth,
        ),
      );
    } else {
      return LightDarkBox(
        child: OudsButton(
          label: ButtonCustomizationUtils.getText(customizationState),
          icon: ButtonCustomizationUtils.getIcon(customizationState, themeController!),
          appearance: ButtonCustomizationUtils.getAppearance(customizationState?.selectedAppearance as Object),
          loader: ButtonCustomizationUtils.getLoader(customizationState),
          onPressed: customizationState?.hasEnabled == true ? () {} : null,
          isFullWidth: customizationState?.hasFullWidth,
        ),
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
  late final FocusNode labelFocus;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonCustomizationState? customizationState = ButtonCustomization.of(context);

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_components_common_roundedCorner_label,
          value: customizationState!.hasRoundedCorner,
          onChanged: (value) {
            customizationState.hasRoundedCorner = value;
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.hasEnabled,
          onChanged:

              /// Specific case: Enabled disabled if style is 'Loading'
              customizationState.isEnabledWhenLoading == true
                  ? null
                  : (value) {
                      customizationState.hasEnabled = value;
                    },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_button_fullWidth_label,
          value: customizationState.hasFullWidth,
          onChanged: (value) {
            customizationState.hasFullWidth = value;
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_onColoredBackground_label,
          value: customizationState.hasOnColoredBox,
          onChanged:

              /// Specific case: OnColoredBox disabled if appearance is 'Negative'
              customizationState.isOnColoredBoxDisabled == true
                  ? null
                  : (value) {
                      customizationState.hasOnColoredBox = value;
                    },
        ),
        CustomizableChips<ButtonEnumAppearance>(
          title: ButtonEnumAppearance.enumName(context),
          options: customizationState.appearanceState.list,
          selectedOption: customizationState.selectedAppearance,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedAppearance = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_loader_label,
          value: customizationState.hasLoader,
          onChanged: (value) {
            customizationState.hasLoader = value;
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
          title: context.l10n.app_components_common_label_label,
          text: customizationState.textValue,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        )
      ],
    );
  }
}
