import 'package:flutter/material.dart';
import 'package:ouds_core/components/chip/ouds_chip.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:provider/provider.dart';

class ChipDemoScreen extends StatefulWidget {
  const ChipDemoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChipDemoScreenState();
}

class _ChipDemoScreenState extends State<ChipDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return ChipCustomization(
      child: Scaffold(
        bottomSheet: OudsSheetsBottom(
          sheetContent: const _CustomizationContent(),
          title: context.l10n.app_common_customize_label,
        ),
        appBar: MainAppBar(title: context.l10n.app_components_suggestionChip_label),
        body: SafeArea(
          child: ExcludeSemantics(
            child: _Body(),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the chip demo and code will be displayed
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
      widget: Column(
        children: [
          _ChipDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: ChipCodeGenerator.updateCode(context),
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the checkbox demo.
///
/// Component [CheckboxDemo] demonstrates the behavior and functionality of a checkbox.
class _ChipDemo extends StatefulWidget {
  const _ChipDemo();

  @override
  State<_ChipDemo> createState() => _ChipDemoState();
}

class _ChipDemoState extends State<_ChipDemo> {
  ThemeController? themeController;

  ChipCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = ChipCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: true);

    return Column(
      children: [
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsChip(label: ChipCustomizationUtils.getText(customizationState), avatar: ChipCustomizationUtils.getIcon(customizationState), onPressed: customizationState?.hasEnabled == true ? () {} : null),
            ],
          ),
        ),
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsChip(label: ChipCustomizationUtils.getText(customizationState), avatar: ChipCustomizationUtils.getIcon(customizationState), onPressed: customizationState?.hasEnabled == true ? () {} : null),
            ],
          ),
        ),
        SizedBox(height: themeController?.currentTheme.spaceScheme(context).fixedSmall),
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

/// This state class handles the customization options for the chip
class _CustomizationContentState extends State<_CustomizationContent> {
  _CustomizationContentState();

  @override
  Widget build(BuildContext context) {
    final ChipCustomizationState? customizationState = ChipCustomization.of(context);
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
        CustomizableChips<ChipEnumLayout>(
          title: ChipEnumLayout.enumName(context),
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
          text: customizationState.labelText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        )
      ],
    );
  }
}
