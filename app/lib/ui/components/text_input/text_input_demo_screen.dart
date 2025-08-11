import 'package:flutter/material.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization_utils.dart';
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
import 'package:provider/provider.dart';

class TextInputDemoScreen extends StatefulWidget {
  const TextInputDemoScreen({super.key});

  @override
  State<TextInputDemoScreen> createState() => _TextInputDemoScreenState();
}

class _TextInputDemoScreenState extends State<TextInputDemoScreen> {
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
          appBar: MainAppBar(title: context.l10n.app_components_text_input_label),
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
      widget: Column(
        children: [
          const _TextInputDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          const Code(code: "OudsTextInput(label: 'Label', helperText: 'Helper text')"),
          ReferenceDesignVersionComponent(version: OudsComponentVersion.textInput),
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
            child: Column(
              children: [
                OudsTextInput(
                  controller: controller,
                  focusNode: textInputFocus,
                  decoration: OudsInputDecoration(
                    labelText: customizationState.labelText.isNotEmpty ? TextInputCustomizationUtils.getLabelText(customizationState) : null,
                    helperText: 'Helper Text',
                    hintText: customizationState.placeholderText.isNotEmpty ? TextInputCustomizationUtils.getPlaceholderText(customizationState) : null,
                    suffixIcon: customizationState.hasTrailingIcon ? const Icon(Icons.favorite_border) : null,
                    suffix: customizationState.suffixText.isNotEmpty ? TextInputCustomizationUtils.getSuffixText(customizationState) : null,
                    prefixIcon: customizationState.hasLeadingIcon ? AppAssets.icons.icHeart : null,
                    prefix: customizationState.prefixText.isNotEmpty ? TextInputCustomizationUtils.getPrefixText(customizationState) : null,
                    errorText: customizationState.hasError ? "This field can’t be empty." : null,
                    loader: customizationState.hasLoader,
                    enabled: customizationState.hasEnabled,
                  ),
                ),
              ],
            ),
          ),
        ),
        ThemeBox(
          themeContract: themeController.currentTheme,
          themeMode: themeController.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: OudsTextInput(
              controller: controller,
              focusNode: textInputFocus,
              decoration: OudsInputDecoration(
                labelText: customizationState.labelText.isNotEmpty ? TextInputCustomizationUtils.getLabelText(customizationState) : null,
                helperText: 'Helper Text',
                hintText: customizationState.placeholderText.isNotEmpty ? TextInputCustomizationUtils.getPlaceholderText(customizationState) : null,
                suffixIcon: customizationState.hasTrailingIcon ? const Icon(Icons.favorite_border) : null,
                suffix: customizationState.suffixText.isNotEmpty ? TextInputCustomizationUtils.getSuffixText(customizationState) : null,
                prefixIcon: customizationState.hasLeadingIcon ? AppAssets.icons.icHeart : null,
                prefix: customizationState.prefixText.isNotEmpty ? TextInputCustomizationUtils.getPrefixText(customizationState) : null,
                errorText: customizationState.hasError ? "This field can’t be empty." : null,
                loader: customizationState.hasLoader,
                enabled: customizationState.hasEnabled,
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

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
    prefixFocus = FocusNode();
    suffixFocus = FocusNode();
    placeholderFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    prefixFocus.dispose();
    suffixFocus.dispose();
    placeholderFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = TextInputCustomization.of(context)!;

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState.hasEnabled,
          onChanged: (value) {
            customizationState.hasEnabled = value;
          },
        ),
        CustomizableSwitch(
          title: "Rounded corner",
          value: customizationState.hasRoundedCorner,
          onChanged: (value) {
            customizationState.hasRoundedCorner = value;
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_error_label,
          value: customizationState.hasError,
          onChanged: customizationState.isErrorWhenEnabled
              ? null
              : (value) {
                  customizationState.hasError = value;
                },
        ),
        CustomizableSwitch(
          title: "Leading Icon",
          value: customizationState.hasLeadingIcon,
          onChanged: (value) {
            customizationState.hasLeadingIcon = value;
          },
        ),
        CustomizableSwitch(
          title: "Trailing action",
          value: customizationState.hasTrailingIcon,
          onChanged: (value) {
            customizationState.hasTrailingIcon = value;
          },
        ),
        CustomizableSwitch(
          title: "Loader",
          value: customizationState.hasLoader,
          onChanged: (value) {
            customizationState.hasLoader = value;
          },
        ),
        /*
        CustomizableChips<TextInputEnumLayout>(
          title: TextInputEnumLayout.enumName(context),
          options: customizationState.layoutState.list,
          selectedOption: customizationState.selectedLayout,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedLayout = selectedOption;
            });
          },
        ),
        */
        CustomizableTextField(
          title: "Label",
          text: customizationState.labelText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
        CustomizableTextField(
          title: "Prefix",
          text: customizationState.prefixText,
          focusNode: prefixFocus,
          fieldType: FieldType.prefix,
        ),
        CustomizableTextField(
          title: "Suffix",
          text: customizationState.suffixText,
          focusNode: suffixFocus,
          fieldType: FieldType.suffix,
        ),
        CustomizableTextField(
          title: "Placeholder",
          text: customizationState.placeholderText,
          focusNode: placeholderFocus,
          fieldType: FieldType.placeholder,
        )
      ],
    );
  }
}
