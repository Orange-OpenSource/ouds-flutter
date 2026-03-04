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
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_customization.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_enum.dart';
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

class LinkDemoScreen extends StatefulWidget {
  const LinkDemoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LinkDemoScreenState();
}

class _LinkDemoScreenState extends State<LinkDemoScreen> {
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
      child: LinkCustomization(
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
            appBar: MainAppBar(showBackButton: true,title: context.l10n.app_components_link_label),
            body: ExcludeSemantics(excluding: !_isBottomSheetExpanded, child: _Body()),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the link demo and code will be displayed
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
      description: context.l10n.app_components_link_description_text,
      widget: Column(
        children: [
          _LinkDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(
            code: LinkCodeGenerator.updateCode(context),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.link,
          )
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the link demo.
///
/// Component [LinkDemo] demonstrates the behavior and functionality of a link.
class _LinkDemo extends StatefulWidget {
  const _LinkDemo();

  @override
  State<_LinkDemo> createState() => _LinkDemoState();
}

class _LinkDemoState extends State<_LinkDemo> {
  ThemeController? themeController;
  LinkCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = LinkCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: true);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnColoredSurface(customizationState?.hasOnColoredBox);
    });

    if (customizationState?.hasOnColoredBox == true) {
      return ComponentDemoBox(
        colored: customizationState?.hasOnColoredBox == true,
        child: OudsLink(
          label: customizationState!.labelText,
          icon: LinkCustomizationUtils.getIcon(customizationState, themeController!),
          size: LinkCustomizationUtils.getSize(customizationState?.selectedSize as Object),
          layout: LinkCustomizationUtils.getLayout(customizationState?.selectedLayout as Object),
          onPressed: customizationState?.hasEnabled == true ? () {} : null,
        ),
      );
    } else {
      return LightDarkBox(
          child: OudsLink(
        label: customizationState!.labelText,
        icon: LinkCustomizationUtils.getIcon(customizationState, themeController!),
        size: LinkCustomizationUtils.getSize(customizationState?.selectedSize as Object),
        layout: LinkCustomizationUtils.getLayout(customizationState?.selectedLayout as Object),
        onPressed: customizationState?.hasEnabled == true ? () {} : null,
      ));
    }
  }
}

/// This widget represents the customization content section that appears in the bottom sheet
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the link
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
    final LinkCustomizationState? customizationState = LinkCustomization.of(context);

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: customizationState!.hasEnabled,
          onChanged: (value) {
            setState(() {
              customizationState.hasEnabled = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_onColoredBackground_label,
          value: customizationState.hasOnColoredBox,
          onChanged: (value) {
            customizationState.hasOnColoredBox = value;
          },
        ),
        CustomizableChips<LinkEnumSize>(
          title: LinkEnumSize.enumName(context),
          options: customizationState.sizeState.list,
          selectedOption: customizationState.selectedSize,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedSize = selectedOption;
            });
          },
        ),
        CustomizableChips<LinkEnumLayout>(
          title: LinkEnumLayout.enumName(context),
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