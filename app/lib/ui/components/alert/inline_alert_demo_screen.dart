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
import 'package:ouds_core/components/alert/ouds_inline_alert.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_customization.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_dropdown_menu.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// Screen for the [OudsInlineAlert] component demo.
class InlineAlertDemoScreen extends StatefulWidget {
  final String? previousPageTitle;

  const InlineAlertDemoScreen({super.key, this.previousPageTitle});

  @override
  State<InlineAlertDemoScreen> createState() => _InlineAlertDemoScreenState();
}

class _InlineAlertDemoScreenState extends State<InlineAlertDemoScreen> {
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
      child: AlertCustomization(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: defaultTargetPlatform == TargetPlatform.android
                ? MediaQuery.of(context).viewPadding.bottom
                : OudsTheme.of(context).spaceScheme(context).paddingBlockNone,
          ),
          child: Scaffold(
            bottomSheet: OudsSheetsBottom(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: MainAppBar(
              title: context.l10n.app_components_alert_inlineAlert_tech,
              previousPageTitle: widget.previousPageTitle,
              showBackButton: true,
            ),
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

/// Body of the screen, displaying the component demo and description.
class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    return DetailScreenDescription(
      description:
          context.l10n.app_components_alert_inlineAlert_description_text,
      widget: Column(
        children: [
          _InlineAlertDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(code: AlertCodeGenerator.updateInlineAlertCode(context)),
          const ReferenceDesignVersionComponent(
            version: OudsComponentVersion.inlineAlert,
          ),
        ],
      ),
    );
  }
}

/// Widget that displays the [OudsInlineAlert] with the current customizations.
class _InlineAlertDemo extends StatefulWidget {
  @override
  State<_InlineAlertDemo> createState() => _InlineAlertDemoState();
}

class _InlineAlertDemoState extends State<_InlineAlertDemo> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    final customizationState = AlertCustomization.of(context)!;

    return LightDarkBox(
      child: OudsInlineAlert(
        label: customizationState.label,
        status: AlertCustomizationUtils.getIconStatus(
          context,
          customizationState,
          themeController,
        ),
      ),
    );
  }
}

/// Content of the bottom sheet with customization controls.
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

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
    final customizationState = AlertCustomization.of(context)!;
    final theme = OudsTheme.of(context).spaceScheme(context);

    return CustomizableSection(
      children: [
        CustomizationDropdownMenu<StatusEnum>(
          label: StatusEnum.enumName(context),
          options: customizationState.statusState.list,
          selectedItemIndex: customizationState.selectedIndex,
          selectedOption: customizationState.selectedStatus,
          getText: (option) => option.stringValue(context),
          onSelectionChange: (value, index) {
            setState(() {
              customizationState.selectedStatus = value;
              customizationState.selectedIndex = index;
            });
          },
          itemLeadingIcons: customizationState.statusState.list.map((status) {
            return () => Container(
              width: theme.paddingBlockMedium,
              height: theme.paddingBlockMedium,
              decoration: BoxDecoration(
                color: AlertCustomizationUtils.getInlineAlertStatusColor(
                  context,
                  status,
                ),
                shape: BoxShape.rectangle,
              ),
            );
          }).toList(),
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.label,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
      ],
    );
  }
}
