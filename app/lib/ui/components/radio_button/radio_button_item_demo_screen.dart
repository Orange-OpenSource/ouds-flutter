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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/radio_button/ouds_radio_button_item.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_controller.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_enum.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
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

/// State for the demo screen showcasing a ControlItem.
///
/// This screen integrates a customizable bottom sheet used for editing
/// the control item. For accessibility reasons, the main body content is
/// wrapped in an [ExcludeSemantics] widget:
///
/// - When the bottom sheet is **expanded**, the body is excluded from the
///   semantics tree so screen readers don't announce “ghost” elements
///   behind the sheet.
/// - When the bottom sheet is **collapsed**, semantics are restored and
///   the body becomes readable again.
///
/// The `_isBottomSheetExpanded` flag is updated via the callback from
/// [OudsSheetsBottom], keeping semantic behavior aligned with the sheet’s
/// state.
class RadioButtonItemDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const RadioButtonItemDemoScreen({super.key, this.indeterminate = false});

  @override
  State<RadioButtonItemDemoScreen> createState() => _RadioButtonDemoScreenState();
}

class _RadioButtonDemoScreenState extends State<RadioButtonItemDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // True to avoid initial "ghost" elements being read before the sheet updates.
  bool _isBottomSheetExpanded = true;

  /// Triggered whenever the bottom sheet expands or collapses.
  /// Updates the internal state so accessibility can react accordingly.
  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Injecting the ControlItemController into GetX with the specified control item type
    Get.put(ControlItemController(controlItemType: ControlItemType.radioButton));
    final previousTitle = Get.arguments?['previousTitle'] ?? '';

    return DismissKeyboard(
      child: ControlItemCustomization(
        child: Padding(
          padding: EdgeInsets.only(bottom: defaultTargetPlatform == TargetPlatform.android ? MediaQuery.of(context).viewPadding.bottom : OudsTheme.of(context).spaceScheme(context).paddingBlockNone),
          child: Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: MainAppBar(
                showBackButton: true,
                title: context.l10n.app_components_radioButton_radioButtonItem_label,
                previousTitle: previousTitle,
            ),
            body:
            // Excluding the body from accessibility when the bottom sheet is expanded.
            ExcludeSemantics(
              excluding: !_isBottomSheetExpanded,
              child: _Body(indeterminate: widget.indeterminate),
            ),
            bottomSheet: OudsSheetsBottom(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the checkbox demo and code will be displayed.
class _Body extends StatefulWidget {
  final bool indeterminate;

  const _Body({required this.indeterminate});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: true);
    return DetailScreenDescription(
      widget: Column(
        children: [
          _RadioButtonItemDemo(indeterminate: widget.indeterminate),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: ControlItemCodeGenerator.updateCode(context, widget.indeterminate, ControlItemType.radioButton),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.radioButton,
          )
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the radio_button demo.
class _RadioButtonItemDemo extends StatefulWidget {
  final bool indeterminate;

  const _RadioButtonItemDemo({required this.indeterminate});

  @override
  _RadioButtonItemDemoState createState() => _RadioButtonItemDemoState();
}

class _RadioButtonItemDemoState extends State<_RadioButtonItemDemo> {
  RadioOption _selectedOption = RadioOption.first;

  ThemeController? themeController;
  ControlItemCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = ControlItemCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: false);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnColoredSurface(customizationState?.hasOnColoredBox);
    });
    return LightDarkBox(
      hasConstrainedMaxWidthOption: true,
      child: MergeSemantics(
        child: Column(
          children: [
            OudsRadioButtonItem<RadioOption>(
              value: RadioOption.first,
              groupValue: _selectedOption,
              onChanged: customizationState!.hasEnabled
                  ? (RadioOption? value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    }
                  : null,
              title: ControlItemCustomizationUtils.getLabelText(customizationState!),
              extraLabelText: ControlItemCustomizationUtils.getAdditionalLabelText(customizationState!),
              helperTitle: ControlItemCustomizationUtils.getHelperLabelText(customizationState!),
              outlined: customizationState!.hasOutlined ? true : false,
              reversed: customizationState!.hasReversed ? true : false,
              readOnly: customizationState!.hasReadOnly ? true : false,
              icon: customizationState!.hasIcon ? AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!) : null,
              isError: customizationState!.hasError ? true : false,
              divider: customizationState!.hasDivider ? true : false,
              constrainedMaxWidth: customizationState!.hasConstrainedMaxWidth ? true : false,
            ),
            OudsRadioButtonItem<RadioOption>(
              value: RadioOption.second,
              groupValue: _selectedOption,
              onChanged: customizationState!.hasEnabled
                  ? (RadioOption? value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    }
                  : null,
              title: ControlItemCustomizationUtils.getLabelText(customizationState!),
              extraLabelText: ControlItemCustomizationUtils.getAdditionalLabelText(customizationState!),
              helperTitle: ControlItemCustomizationUtils.getHelperLabelText(customizationState!),
              outlined: customizationState!.hasOutlined ? true : false,
              reversed: customizationState!.hasReversed ? true : false,
              readOnly: customizationState!.hasReadOnly ? true : false,
              icon: customizationState!.hasIcon ? AppAssets.icons.functionalSocialAndEngagementHeartEmpty(themeController!) : null,
              isError: customizationState!.hasError ? true : false,
              errorText: ControlItemCustomizationUtils.getErrorMessageLabelText(customizationState!),
              divider: customizationState!.hasDivider ? true : false,
              constrainedMaxWidth: customizationState!.hasConstrainedMaxWidth ? true : false,
            ),
          ],
        ),
      ),
    );
  }
}

/// This widget represents the customization content section that appears in the bottom sheet.
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the Radiobutton.
class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode labelFocus;
  late final FocusNode extraFocus;
  late final FocusNode descriptionFocus;
  late final FocusNode errorMessageFocus;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
    extraFocus = FocusNode();
    descriptionFocus = FocusNode();
    errorMessageFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    extraFocus.dispose();
    descriptionFocus.dispose();
    errorMessageFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = ControlItemCustomization.of(context);

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_components_controlItem_icon_label,
          value: customizationState!.hasIcon,
          onChanged: customizationState.isReadOnlyWhenError || customizationState.isReadOnlyWhenEnabled
              ? null
              : (value) {
                  setState(() {
                    customizationState.hasIcon = value;
                  });
                },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_controlItem_divider_label,
          value: customizationState.hasDivider,
          onChanged: (value) {
            setState(() {
              customizationState.hasDivider = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_outlined_label,
          value: customizationState.hasOutlined,
          onChanged: (value) {
            setState(() {
              customizationState.hasOutlined = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_controlItem_reversed_label,
          value: customizationState.hasReversed,
          onChanged: (value) {
            setState(() {
              customizationState.hasReversed = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.hasEnabled,
          onChanged: customizationState.isEnabledWhenError || customizationState.isEnabledWhenReadOnly
              ? null // Disable the switch if there is an error
              : (value) {
                  setState(() {
                    customizationState.hasEnabled = value;
                  });
                },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_readOnly_label,
          value: customizationState.hasReadOnly,
          onChanged: customizationState.isReadOnlyWhenError || customizationState.isReadOnlyWhenEnabled
              ? null
              : (value) {
                  setState(() {
                    customizationState.hasReadOnly = value;
                  });
                },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_error_label,
          value: customizationState.hasError,
          onChanged: customizationState.isErrorWhenEnabled || customizationState.isErrorWhenReadOnly
              ? null // Disable the switch if not enabled
              : (value) {
                  setState(() {
                    customizationState.hasError = value;
                  });
                },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.labelText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_radioButton_radioButtonItem_extraLabel_label,
          text: customizationState.extraLabelText,
          focusNode: extraFocus,
          fieldType: FieldType.extra,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_controlItem_description_label,
          text: customizationState.descriptionLabel,
          focusNode: descriptionFocus,
          fieldType: FieldType.description,
        ),
        CustomizableTextField(
          fieldEnable: customizationState.hasError,
          title: context.l10n.app_components_common_error_message,
          text: customizationState.errorMessageLabel,
          focusNode: errorMessageFocus,
          fieldType: FieldType.error,
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_constrainedMaxWidth_label,
          value: customizationState.hasConstrainedMaxWidth,
          onChanged: (value) {
            setState(() {
              customizationState.hasConstrainedMaxWidth = value;
            });
          },
        ),
      ],
    );
  }
}
