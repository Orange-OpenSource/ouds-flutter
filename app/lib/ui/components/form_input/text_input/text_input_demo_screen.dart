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
import 'package:ouds_core/components/form_input/internal/ouds_form_input_decoration.dart';
import 'package:ouds_core/components/form_input/ouds_text_input.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_customization.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_enum.dart';
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
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/customize_bottom_sheet.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:provider/provider.dart';

class TextInputDemoScreen extends StatefulWidget {
  final String? previousPageTitle;
  const TextInputDemoScreen({super.key, this.previousPageTitle});

  @override
  State<TextInputDemoScreen> createState() => _TextInputDemoScreenState();
}

/// State for the demo screen showcasing a TextInput.
class _TextInputDemoScreenState extends State<TextInputDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: FormFieldsCustomization(
        inputType: FormFieldsTypeEnum.textInput,
        child: CustomizeBottomSheet(
          topBar: MainAppBar(
            title: context.l10n.app_components_textInput_label,
            showBackButton: true,
            previousPageTitle: widget.previousPageTitle,
          ),
          title: context.l10n.app_common_customize_label,
          customizationContent: const _CustomizationContent(),
          body: _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    return DetailScreenDescription(
      description: context.l10n.app_components_textInput_description_text,
      widget: Column(
        children: [
          const _TextInputDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(
            code: FormFieldsCodeGenerator.updateCode(
              context,
              FormFieldsTypeEnum.textInput,
            ),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.textInput,
          ),
        ],
      ),
    );
  }
}

class _TextInputDemo extends StatefulWidget {
  const _TextInputDemo();

  @override
  State<_TextInputDemo> createState() => _TextInputDemoState();
}

class _TextInputDemoState extends State<_TextInputDemo> {
  late final TextEditingController controller;
  late final FocusNode textInputFocus;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    textInputFocus = FocusNode();

    controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    controller.dispose();
    textInputFocus.dispose();
    controller.removeListener(_handleTextChanged);
    super.dispose();
  }

  void _handleTextChanged() {
    // Get the current text from the controller
    final text = controller.text;

    // Trigger a rebuild only when the "typing" state actually changes
    // (prevents unnecessary rebuilds on every keystroke)
    final typing = text.isNotEmpty;
    if (typing != _isTyping) {
      setState(() {
        _isTyping = typing;
      });
    }

    final customizationState = FormFieldsCustomization.of(context);
    if (customizationState != null) {
      customizationState.isTyping = typing;
    }
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = FormFieldsCustomization.of(
      context,
    )!; // safe to use !
    final themeController = Provider.of<ThemeController>(context, listen: true);

    return LightDarkBox(
      hasConstrainedMaxWidthOption: true,
      child: OudsTextField(
        controller: controller,
        focusNode: textInputFocus,
        enabled: customizationState.hasEnabled,
        readOnly: customizationState.hasReadOnly,
        onEditingComplete: (textTapped) {
          ///
          /// To Be implemented if needed
          ///
        },
        helperLink: OudsLink(
          label: customizationState.helperLinkText,
          onPressed: () {
            ///
            /// To Be implemented if needed
            ///
          },
        ),
        trailingIconContentDescription:
            context.l10n.app_components_textInput_trailingAction_a11y,
        decoration: OudsInputDecoration(
          labelText: customizationState.labelText.isNotEmpty
              ? FormFieldsCustomizationUtils.getLabelText(customizationState)
              : null,
          helperText: customizationState.hasAnnotatedHelper
              ? customizationState.annotatedHelperText
              : (customizationState.helperText.isNotEmpty
                    ? FormFieldsCustomizationUtils.getHelperText(
                        customizationState,
                      )
                    : null),
          hintText: customizationState.placeholderText.isNotEmpty
              ? FormFieldsCustomizationUtils.getPlaceholderText(
                  customizationState,
                )
              : null,
          suffixIcon: customizationState.getSuffixIcon(themeController),
          suffix: customizationState.suffixText.isNotEmpty
              ? FormFieldsCustomizationUtils.getSuffixText(customizationState)
              : null,
          prefixIcon: customizationState.getPrefixIcon(themeController),
          prefix: customizationState.prefixText.isNotEmpty
              ? FormFieldsCustomizationUtils.getPrefixText(customizationState)
              : null,
          errorText: customizationState.hasError
              ? (customizationState.hasAnnotatedHelper
                    ? customizationState.annotatedErrorText
                    : context.l10n.app_components_textInput_error_label)
              : null,
          loader: customizationState.loader,
          outlined: customizationState.hasOutlined,
          constrainedMaxWidth: customizationState.hasConstrainedMaxWidth
              ? true
              : false,
        ),
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

/// This state class handles the customization options for the text input
class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode labelFocus;
  late final FocusNode prefixFocus;
  late final FocusNode suffixFocus;
  late final FocusNode placeholderFocus;
  late final FocusNode helperFocus;
  late final FocusNode helperLinkFocus;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
    prefixFocus = FocusNode();
    suffixFocus = FocusNode();
    placeholderFocus = FocusNode();
    helperFocus = FocusNode();
    helperLinkFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    prefixFocus.dispose();
    suffixFocus.dispose();
    placeholderFocus.dispose();
    helperFocus.dispose();
    helperLinkFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = FormFieldsCustomization.of(context)!;

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_components_common_outlined_label,
          value: customizationState.hasOutlined,
          onChanged: (value) {
            customizationState.hasOutlined = value;
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.hasEnabled,
          onChanged:
              /// Specific case: The switch is disabled if there is an error (hasError is true).
              customizationState.isEnabledWhenError == true
              ? null // Disable the switch if there is an error
              : (value) {
                  customizationState.hasEnabled = value;
                },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_readOnly_label,
          value: customizationState.hasReadOnly,
          onChanged: customizationState.isReadOnlyWhenError
              ? null
              : (value) {
                  customizationState.hasReadOnly = value;
                },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_error_label,
          value: customizationState.hasError,
          onChanged:
              customizationState.isErrorWhenEnabled ||
                  customizationState.isErrorWhenLoader ||
                  customizationState.isErrorWhenReadOnly
              ? null
              : (value) {
                  customizationState.hasError = value;
                },
        ),
        CustomizableChips<LeadingIconOptionEnum>(
          title: LeadingIconOptionEnum.enumName(context),
          options: customizationState.leadingIconState.list,
          selectedOption: customizationState.selectedLeadingIcon,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            customizationState.selectedLeadingIcon = selectedOption;
          },
        ),
        CustomizableChips<TrailingIconOptionEnum>(
          title: TrailingIconOptionEnum.enumName(context),
          options: customizationState.trailingIconState.list,
          selectedOption: customizationState.selectedTrailingIcon,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            customizationState.selectedTrailingIcon = selectedOption;
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_loader_label,
          value: customizationState.hasLoader,
          // The switch is disabled when the user is not typing
          onChanged:
              (!customizationState.isTyping ||
                  customizationState.isLoaderWhenError)
              ? null
              : (value) {
                  customizationState.hasLoader = value;
                },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.labelText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_textInput_prefix_label,
          text: customizationState.prefixText,
          focusNode: prefixFocus,
          fieldType: FieldType.prefix,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_textInput_suffix_label,
          text: customizationState.suffixText,
          focusNode: suffixFocus,
          fieldType: FieldType.suffix,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_placeholder_label,
          text: customizationState.placeholderText,
          focusNode: placeholderFocus,
          fieldType: FieldType.placeholder,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_helperText_label,
          text: customizationState.helperText,
          focusNode: helperFocus,
          fieldType: FieldType.helper,
          fieldEnable: customizationState.isHelperTextEnabled,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_textInput_helperLink_label,
          text: customizationState.helperLinkText,
          focusNode: helperLinkFocus,
          fieldType: FieldType.helperLink,
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
        CustomizableSwitch(
          title: context.l10n.app_components_common_annotatedText_tech,
          value: customizationState.hasAnnotatedHelper,
          onChanged: (value) {
            setState(() {
              customizationState.hasAnnotatedHelper = value;
            });
          },
        ),
      ],
    );
  }
}
