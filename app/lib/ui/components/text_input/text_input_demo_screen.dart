import 'package:flutter/material.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
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
    return Scaffold(
      key: _scaffoldKey,
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
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);

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

class _TextInputDemo extends StatelessWidget {
  const _TextInputDemo();

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Provider.of<ThemeController>(context, listen: true);

    return Column(
      children: [
        ThemeBox(
          themeContract: themeController.currentTheme,
          themeMode: themeController.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: OudsTextInput(
              label: 'Nom',
              helperText: 'Helper Text',
              suffixIcon: Icon(
                Icons.favorite_border,
              ),
              prefixIcon: AppAssets.icons.icHeart,
            ),
          ),
        ),
        ThemeBox(
          themeContract: themeController.currentTheme,
          themeMode: themeController.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: OudsTextInput(
              label: 'Nom',
              helperText: 'Helper Text',
              suffixIcon: Icon(
                Icons.favorite_border,
              ),
              prefixIcon: AppAssets.icons.icHeart,
            ),
          ),
        ),
        SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedSmall),
      ],
    );
  }
}

class _CustomizationContent extends StatelessWidget {
  const _CustomizationContent();

  @override
  Widget build(BuildContext context) {
    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: true,
          onChanged: (_) {},
        ),
      ],
    );
  }
}
