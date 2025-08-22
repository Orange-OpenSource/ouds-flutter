import 'package:flutter/material.dart';
import 'package:ouds_core/components/pin_code_input/ouds_pin_code_input.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:provider/provider.dart';

class PinCodeInputDemoScreen extends StatefulWidget {
  const PinCodeInputDemoScreen({super.key});

  @override
  State<PinCodeInputDemoScreen> createState() => _PinCodeInputDemoScreenState();
}

class _PinCodeInputDemoScreenState extends State<PinCodeInputDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: TextInputCustomization(
        key: _scaffoldKey,
        child: Scaffold(
          appBar: MainAppBar(title: context.l10n.app_components_pin_code_input_label),
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
      description: context.l10n.app_components_pin_code_input_description_text,
      widget: Column(
        children: [
          const _PinCodeInputDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          ReferenceDesignVersionComponent(version: OudsComponentVersion.pinCodeInput),
        ],
      ),
    );
  }
}

class _PinCodeInputDemo extends StatefulWidget {
  const _PinCodeInputDemo();

  @override
  State<_PinCodeInputDemo> createState() => _PinCodeInputDemoState();
}

class _PinCodeInputDemoState extends State<_PinCodeInputDemo> {
  late final TextEditingController controller;
  late final FocusNode textInputFocus;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    textInputFocus = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    textInputFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = TextInputCustomization.of(context)!; // safe to use !
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
            padding: const EdgeInsets.all(16.0),
              child: Expanded(
                  child: OudsPinCodeInput(
                      digitInputDecoration: OudsDigitInputDecoration()
                    )
              )
          ),
        ),
        ThemeBox(
          themeContract: themeController.currentTheme,
          themeMode: themeController.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flexible(
                child: OudsPinCodeInput(
                    digitInputDecoration: OudsDigitInputDecoration()
                )
            )
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
  late final FocusNode placeholderFocus;
  late final FocusNode helperFocus;

  @override
  void initState() {
    super.initState();
    placeholderFocus = FocusNode();
    helperFocus = FocusNode();
  }

  @override
  void dispose() {
    placeholderFocus.dispose();
    helperFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = TextInputCustomization.of(context)!;

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_components_common_roundedCorner_label,
          value: customizationState.hasRoundedCorner,
          onChanged: (value) {
            customizationState.hasRoundedCorner = value;
          },
        ),
        CustomizableChips<TextInputEnumStyle>(
          title: TextInputEnumStyle.enumName(context),
          options: customizationState.styleState.list,
          selectedOption: customizationState.selectedStyle,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedStyle = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_label_label,
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
          title: context.l10n.app_components_common_error_label,
          value: customizationState.hasError,
          onChanged: customizationState.isErrorWhenEnabled  || customizationState.isErrorWhenReadOnly
              ? null
              : (value) {
                  customizationState.hasError = value;
                },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_pin_code_input_placeholder_label,
          text: customizationState.placeholderText,
          focusNode: placeholderFocus,
          fieldType: FieldType.placeholder,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_pin_code_input_helperText_label,
          text: customizationState.helperText,
          focusNode: helperFocus,
          fieldType: FieldType.helper,
        )
      ],
    );
  }
}
