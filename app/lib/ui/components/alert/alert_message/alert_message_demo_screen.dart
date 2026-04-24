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
import 'package:ouds_core/components/alert_message/ouds_alert_message.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_message/alert_enum.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_message/alert_message_customization.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_message/alert_message_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_dropdown_menu.dart';
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

class AlertMessageDemoScreen extends StatefulWidget {
  final String? previousPageTitle;

  const AlertMessageDemoScreen({super.key, this.previousPageTitle});

  @override
  State<AlertMessageDemoScreen> createState() => _AlertMessageDemoScreenState();
}

class _AlertMessageDemoScreenState extends State<AlertMessageDemoScreen> {
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
      child: AlertMessageCustomization(
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
              title: context.l10n.app_components_alert_alertMessage_tech,
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

/// This widget represents the body of the screen where the alert_message demo and code will be displayed
class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    return DetailScreenDescription(
      description:
          context.l10n.app_components_alert_alertMessage_description_text,
      widget: Column(
        children: [
          _AlertMessageDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          // Code(code: AlertMessageCodeGenerator.updateCode(context)),
          const ReferenceDesignVersionComponent(
            version: OudsComponentVersion.alertMessage,
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the alert_message demo.
///
/// Component [AlertMessageDemo] demonstrates the behavior and functionality of an alert_message.

class _AlertMessageDemo extends StatefulWidget {
  @override
  State<_AlertMessageDemo> createState() => _AlertMessageDemoState();
}

class _AlertMessageDemoState extends State<_AlertMessageDemo> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: true);
    final customizationState = AlertMessageCustomization.of(context)!;
    return LightDarkBox(
      child: OudsAlertMessage(
        label: customizationState.label,
        description: customizationState.description.isNotEmpty
            ? customizationState.description
            : null,
        status: AlertMessageCustomizationUtils.getIconStatus(
          context,
          customizationState,
          themeController,
        ),
        bulletList: [
          customizationState.bulletTextOne,
          customizationState.bulletTextTwo,
          customizationState.bulletTextThree,
        ],
        actionLink: OudsAlertMessageActionLink(
          text: customizationState.actionLink,
          onClick: customizationState.actionLink.isNotEmpty ? () {} : null,
          position: AlertMessageCustomizationUtils.getLinkActionPosition(
            customizationState.selectedActionLinkPosition,
          ),
        ),
        onClose: customizationState.hasCloseButton ? () {} : null,
      ),
    );
  }
}

class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode labelFocus;
  late final FocusNode descriptionFocus;
  late final FocusNode actionLinkFocus;
  late final FocusNode bulletOneFocus;
  late final FocusNode bulletTwoFocus;
  late final FocusNode bulletThreeFocus;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
    descriptionFocus = FocusNode();
    actionLinkFocus = FocusNode();
    bulletOneFocus = FocusNode();
    bulletTwoFocus = FocusNode();
    bulletThreeFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    descriptionFocus.dispose();
    actionLinkFocus.dispose();
    bulletOneFocus.dispose();
    bulletTwoFocus.dispose();
    bulletThreeFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = AlertMessageCustomization.of(context)!;
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
              (customizationState.selectedStatus != StatusEnum.accent &&
                      customizationState.selectedStatus != StatusEnum.neutral)
                  ? customizationState.hasIconStatus = true
                  : customizationState.hasIconStatus =
                        customizationState.hasIconStatus;
            });
          },
          itemLeadingIcons: customizationState.statusState.list.map((status) {
            return () => Container(
              width: theme.paddingBlockMedium,
              height: theme.paddingBlockMedium,
              decoration: BoxDecoration(
                color: AlertMessageCustomizationUtils.getStatusColor(
                  context,
                  status,
                  true,
                ),
                shape: BoxShape.rectangle,
              ),
            );
          }).toList(),
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_alert_alertMessage_statusIcon_tech,
          value: customizationState.hasIconStatus,
          onChanged:
              (customizationState.selectedStatus == StatusEnum.accent ||
                  customizationState.selectedStatus == StatusEnum.neutral)
              ? (value) {
                  setState(() {
                    customizationState.hasIconStatus = value;
                  });
                }
              : null,
        ),
        CustomizableSwitch(
          title:
              context.l10n.app_components_alert_alertMessage_closeButton_tech,
          value: customizationState.hasCloseButton,
          onChanged: (value) {
            setState(() {
              customizationState.hasCloseButton = value;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.label,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_common_description_tech,
          text: customizationState.description,
          focusNode: descriptionFocus,
          fieldType: FieldType.description,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_alert_alertMessage_actionLink_tech,
          text: customizationState.actionLink,
          focusNode: actionLinkFocus,
          fieldType: FieldType.helperLink,
        ),
        CustomizableChips<ActionLinkPositionEnum>(
          title: context.l10n.app_components_alert_alertMessage_actionLink_tech,
          options: customizationState.actionLinkPositionState.list,
          selectedOption: customizationState.selectedActionLinkPosition,
          getText: (option) => option.name.toString(),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedActionLinkPosition = selectedOption;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_alert_alertMessage_bullet_tech(1),
          text: customizationState.bulletTextOne,
          focusNode: bulletOneFocus,
          fieldType: FieldType.bulletOne,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_alert_alertMessage_bullet_tech(2),
          text: customizationState.bulletTextTwo,
          focusNode: bulletTwoFocus,
          fieldType: FieldType.bulletTwo,
        ),
        CustomizableTextField(
          title: context.l10n.app_components_alert_alertMessage_bullet_tech(3),
          text: customizationState.bulletTextThree,
          focusNode: bulletThreeFocus,
          fieldType: FieldType.bulletThree,
        ),
      ],
    );
  }
}
