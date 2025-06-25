import 'package:flutter/material.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/ouds_colored_box.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_customization.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_dropdown_menu.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

import '../../utilities/customizable/customizable_section.dart' show CustomizableSection;
import '../../utilities/theme_colored_box.dart';

class DividerDemoScreen extends StatefulWidget {
  final bool vertical;

  const DividerDemoScreen({super.key, required this.vertical});

  @override
  State<StatefulWidget> createState() => _DividerDemoScreenState();
}

class _DividerDemoScreenState extends State<DividerDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DividerCustomization(
        child: Scaffold(
      bottomSheet: OudsSheetsBottom(
        onExpansionChanged: _onExpansionChanged,
        sheetContent: const _CustomizationContent(),
        title: context.l10n.app_common_customize_label,
      ),
      key: _scaffoldKey,
      appBar: widget.vertical ? MainAppBar(title: context.l10n.app_components_divider_verticalDivider_label) : MainAppBar(title: context.l10n.app_components_divider_horizontalDivider_label),
      body: SafeArea(
        child: ExcludeSemantics(
          excluding: !_isBottomSheetExpanded,
          child: _Body(vertical: widget.vertical),
        ),
      ),
    ));
  }
}

class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the checkbox
class _CustomizationContentState extends State<_CustomizationContent> {
  _CustomizationContentState();

  @override
  Widget build(BuildContext context) {
    final DividerCustomizationState? customizationState = DividerCustomization.of(context);

    var colors = customizationState!.colorState.list;

    return CustomizationDropdownMenu<DividerEnumColor>(
      label: DividerEnumColor.enumName(context),
      options: colors,
      selectedItemIndex: customizationState.selectedIndex,
      selectedOption: customizationState.selectedColor,
      getText: (option) => option.formattedName,
      onSelectionChange: (value, index) {
        setState(() {
          customizationState.selectedColor = value;
          customizationState.selectedIndex = index;
        });
      },
      itemLeadingIcons: customizationState.colorState.list.map((color) {
        return () => Container(
              width: OudsTheme.of(context).spaceScheme(context).paddingBlockMedium,
              height: OudsTheme.of(context).spaceScheme(context).paddingBlockMedium,
              decoration: BoxDecoration(
                color: DividerCustomizationUtils.getOudsDividerColor(color).getColor(context),
                shape: BoxShape.rectangle,
              ),
            );
      }).toList(),
    );
  }
}

class _Body extends StatefulWidget {
  final bool vertical;

  const _Body({required this.vertical});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: true);
    return DetailScreenDescription(
      widget: Column(
        children: [
          _DividerDemo(vertical: widget.vertical),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: DividerCodeGenerator.updateCode(context, widget.vertical),
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the divider demo.
///
/// Component [DividerDemo] demonstrates the behavior and functionality of a divider.
class _DividerDemo extends StatefulWidget {
  final bool vertical;

  const _DividerDemo({required this.vertical});

  @override
  State<_DividerDemo> createState() => _DividerDemoState();
}

class _DividerDemoState extends State<_DividerDemo> {
  ThemeController? themeController;
  DividerCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = DividerCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: false);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnColoredSurface(customizationState?.hasOnColoredBox);
    });

    if (customizationState?.hasOnColoredBox == true) {
      return OudsColoredBox(
        color: customizationState?.hasOnColoredBox == true ? OudsColoredBoxColor.brandPrimary : OudsColoredBoxColor.statusNeutralMuted,
        child: widget.vertical
            ? OudsDivider.vertical(color: DividerCustomizationUtils.getOudsDividerColor(customizationState?.selectedColor))
            : OudsDivider.horizontal(color: DividerCustomizationUtils.getOudsDividerColor(customizationState?.selectedColor)),
      );
    } else {
      return CustomizableSection(
        children: [
          /// [themeMode] we test here theme of system and inverse theme mode if is not dark
          ThemeBox(
            themeContract: themeController!.currentTheme,
            themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
            child: widget.vertical
                ? OudsDivider.vertical(color: DividerCustomizationUtils.getOudsDividerColor(customizationState?.selectedColor))
                : OudsDivider.horizontal(color: DividerCustomizationUtils.getOudsDividerColor(customizationState?.selectedColor)),
          ),
          ThemeBox(
            themeContract: themeController!.currentTheme,
            themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
            child: widget.vertical
                ? OudsDivider.vertical(color: DividerCustomizationUtils.getOudsDividerColor(customizationState?.selectedColor))
                : OudsDivider.horizontal(color: DividerCustomizationUtils.getOudsDividerColor(customizationState?.selectedColor)),
          )
        ],
      );
    }
  }
}
