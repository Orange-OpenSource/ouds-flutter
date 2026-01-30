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
import 'package:ouds_core/components/country_selector/countries.dart';
import 'package:ouds_core/components/country_selector/ouds_country_selector.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_decoration.dart';
import 'package:ouds_core/components/form_input/ouds_phone_number_input.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_customization.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

class PhoneNumberInputDemoScreen extends StatefulWidget {
  const PhoneNumberInputDemoScreen({super.key});

  @override
  State<PhoneNumberInputDemoScreen> createState() => _PhoneNumberInputDemoScreenState();
}

class _PhoneNumberInputDemoScreenState extends State<PhoneNumberInputDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = true;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: FormFieldsCustomization(
        key: _scaffoldKey,
        inputType: FormFieldsTypeEnum.phoneNumberInput,
        child: Padding(
          padding: EdgeInsets.only(bottom: defaultTargetPlatform == TargetPlatform.android ? MediaQuery.of(context).viewPadding.bottom : OudsTheme.of(context).spaceScheme(context).paddingBlockNone),
          child: Scaffold(
            appBar: MainAppBar(
              title: context.l10n.app_components_phoneNumberInput_label,
            ),
            bottomSheet: OudsSheetsBottom(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
            body: SafeArea(
              child: ExcludeSemantics(
                excluding: !_isBottomSheetExpanded,
                child: const _Body(),
              ),
            ),
          ),
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
    final themeController = Provider.of<ThemeController>(context, listen: false);
    return DetailScreenDescription(
      description: context.l10n.app_components_phoneNumberInput_description_text,
      widget: Column(
        children: [
          const _PhoneNumberInputDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: FormFieldsCodeGenerator.updateCode(
              context,
              FormFieldsTypeEnum.phoneNumberInput,
            ),
          ),
          ReferenceDesignVersionComponent(version: OudsComponentVersion.textInput),
        ],
      ),
    );
  }
}

class _PhoneNumberInputDemo extends StatefulWidget {
  const _PhoneNumberInputDemo();

  @override
  State<_PhoneNumberInputDemo> createState() => _PhoneNumberInputDemoState();
}

class _PhoneNumberInputDemoState extends State<_PhoneNumberInputDemo> {
  late final TextEditingController controller;
  late final FocusNode textInputFocus;
  bool _isTyping = false;
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    textInputFocus = FocusNode();

    controller.addListener(_handleTextChanged);
  }

  void onCountryChanged(Country country) {
    setState(() {
      if (selectedCountry != country) {
        onFlagChanged();
      }
      selectedCountry = country;
    });
  }

  void onFlagChanged() {
    setState(() {
      controller.text = '';
    });
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
    final text = controller.text ?? '';

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
    final customizationState = FormFieldsCustomization.of(context)!; // safe to use !
    final themeController = Provider.of<ThemeController>(context, listen: true);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController.setOnBorderRadiusTextInputState(customizationState.hasRoundedCorner);
    });

    return Column(
      children: [
        ThemeBox(
          themeContract: themeController.currentTheme,
          themeMode: themeController.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
          child: Padding(
            padding: EdgeInsets.all(themeController.currentTheme.spaceScheme(context).insetLarge),
            child: OudsPhoneNumberInput(
              controller: controller,
              focusNode: textInputFocus,
              enabled: customizationState.hasEnabled,
              readOnly: customizationState.hasReadOnly,
              countrySelector: customizationState.hasCountrySelector
                  ? CountrySelector(
                      readOnly: customizationState.isCountrySelectorWhenReadOnlyAndEnable,
                      countryFilter: CountryFilter.all,
                      //codes: ["fr", "tn", "us"],
                      selectedCountry: selectedCountry,
                      onCountryChanged: onCountryChanged,
                    )
                  : null,
              keyboardType: TextInputType.phone,
              onEditingComplete: (phoneNumberTapped) {
                ///
                /// To Be implemented if needed
                ///
              },
              decoration: OudsInputDecoration(
                labelText: customizationState.labelText.isNotEmpty ? FormFieldsCustomizationUtils.getLabelText(customizationState) : null,
                helperText: customizationState.helperText.isNotEmpty ? FormFieldsCustomizationUtils.getHelperText(customizationState) : null,
                hintText: customizationState.placeholderText.isNotEmpty ? FormFieldsCustomizationUtils.getPlaceholderText(customizationState) : null,
                prefix: customizationState.prefixText.isNotEmpty ? FormFieldsCustomizationUtils.getPrefixText(customizationState) : null,
                hasPrefix: customizationState.hasPrefix,
                prefixIcon: customizationState.hasLeadingIcon ? AppAssets.icons.deviceSmartphone(themeController) : null,
                errorText: customizationState.hasError ? context.l10n.app_components_phoneNumberInput_error_label : null,
                loader: customizationState.hasLoader,
                outlined: customizationState.hasOutlined,
                constrainedMaxWidth: customizationState.hasConstrainedMaxWidth ? true : false,
              ),
            ),
          ),
        ),
        ThemeBox(
          themeContract: themeController.currentTheme,
          themeMode: themeController.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: Padding(
            padding: EdgeInsets.all(themeController.currentTheme.spaceScheme(context).insetLarge),
            child: OudsPhoneNumberInput(
              controller: controller,
              focusNode: textInputFocus,
              enabled: customizationState.hasEnabled,
              readOnly: customizationState.hasReadOnly,
              countrySelector: customizationState.hasCountrySelector
                  ? CountrySelector(
                      readOnly: customizationState.isCountrySelectorWhenReadOnlyAndEnable,
                      countryFilter: CountryFilter.all,
                      //codes: ["fr", "tn", "us"],
                      selectedCountry: selectedCountry,
                      onCountryChanged: onCountryChanged,
                    )
                  : null,
              keyboardType: TextInputType.phone,
              onEditingComplete: (phoneNumberTapped) {
                ///
                /// To Be implemented if needed
                ///
              },
              decoration: OudsInputDecoration(
                labelText: customizationState.labelText.isNotEmpty ? FormFieldsCustomizationUtils.getLabelText(customizationState) : null,
                helperText: customizationState.helperText.isNotEmpty ? FormFieldsCustomizationUtils.getHelperText(customizationState) : null,
                hintText: customizationState.placeholderText.isNotEmpty ? FormFieldsCustomizationUtils.getPlaceholderText(customizationState) : null,
                prefix: customizationState.prefixText.isNotEmpty ? FormFieldsCustomizationUtils.getPrefixText(customizationState) : null,
                hasPrefix: customizationState.hasPrefix,
                prefixIcon: customizationState.hasLeadingIcon ? AppAssets.icons.deviceSmartphone(themeController) : null,
                errorText: customizationState.hasError ? context.l10n.app_components_phoneNumberInput_error_label : null,
                loader: customizationState.hasLoader,
                outlined: customizationState.hasOutlined,
                constrainedMaxWidth: customizationState.hasConstrainedMaxWidth ? true : false,
              ),
            ),
          ),
        ),
        SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedSmall),
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

/// This state class handles the customization options for the text input
class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode labelFocus;
  late final FocusNode prefixFocus;
  late final FocusNode suffixFocus;
  late final FocusNode placeholderFocus;
  late final FocusNode helperFocus;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
    prefixFocus = FocusNode();
    suffixFocus = FocusNode();
    placeholderFocus = FocusNode();
    helperFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    prefixFocus.dispose();
    suffixFocus.dispose();
    placeholderFocus.dispose();
    helperFocus.dispose();
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
          title: context.l10n.app_components_common_roundedCorner_label,
          value: customizationState.hasRoundedCorner,
          onChanged: (value) {
            customizationState.hasRoundedCorner = value;
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
          onChanged: customizationState.isErrorWhenEnabled || customizationState.isErrorWhenLoader || customizationState.isErrorWhenReadOnly
              ? null
              : (value) {
                  customizationState.hasError = value;
                },
        ),
        CustomizableSwitch(
            title: context.l10n.app_components_textInput_leadingIcon_label,
            value: !customizationState.hasCountrySelector,
            onChanged: (value) {
              customizationState.hasLeadingIcon = value;
              customizationState.hasCountrySelector = !value;
            }),
        CustomizableSwitch(
          title: context.l10n.app_components_phoneNumberInput_country_selector_label,
          value: !customizationState.hasLeadingIcon,
          onChanged: (value) {
            customizationState.hasCountrySelector = value;
            customizationState.hasLeadingIcon = !value;
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_phoneNumberInput_prefix_label,
          value: customizationState.hasPrefix,
          onChanged: (value) {
            customizationState.hasPrefix = value;
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_loader_label,
          value: customizationState.hasLoader,
          onChanged: customizationState.isLoaderWhenError || !customizationState.isTyping || customizationState.isLoaderWhenEnabled || customizationState.isEnabledWhenPlaceHolderIsNotEmpty
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
          fieldEnable: !customizationState.hasCountrySelector,
          title: context.l10n.app_components_textInput_prefix_label,
          text: customizationState.prefixText,
          focusNode: prefixFocus,
          fieldType: FieldType.prefix,
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
