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
import 'package:ouds_core/components/bottom_sheet/ouds_bottom_sheet_scaffold.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/bottom_sheet_demo_content.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/standard_bottom_sheet_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/standard_bottom_sheet_customization.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/standard_bottom_sheet_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// Demo screen for [OudsBottomSheetScaffold].
///
/// Mirrors `StandardBottomSheetDemoScreen` from the Android app.
class StandardBottomSheetDemoScreen extends StatefulWidget {
  const StandardBottomSheetDemoScreen({super.key, this.previousPageTitle});

  final String? previousPageTitle;

  @override
  State<StandardBottomSheetDemoScreen> createState() =>
      _StandardBottomSheetDemoScreenState();
}

class _StandardBottomSheetDemoScreenState
    extends State<StandardBottomSheetDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: defaultTargetPlatform == TargetPlatform.android
              ? MediaQuery.of(context).viewPadding.bottom
              : OudsTheme.of(context).spaceScheme(context).paddingBlockNone,
        ),
        child: StandardBottomSheetCustomization(
          child: _StandardBottomSheetScaffold(
            previousPageTitle: widget.previousPageTitle,
          ),
        ),
      ),
    );
  }
}

class _StandardBottomSheetScaffold extends StatefulWidget {
  const _StandardBottomSheetScaffold({this.previousPageTitle});

  final String? previousPageTitle;

  @override
  State<_StandardBottomSheetScaffold> createState() =>
      _StandardBottomSheetScaffoldState();
}

class _StandardBottomSheetScaffoldState
    extends State<_StandardBottomSheetScaffold> {
  final _scaffoldKey = GlobalKey<OudsBottomSheetScaffoldState>();
  final _peekHeightFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final state = StandardBottomSheetCustomization.of(context);
    if (state == null) return const SizedBox.shrink();

    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );

    return OudsBottomSheetScaffold(
      key: _scaffoldKey,
      sheetPeekHeight: state.sheetPeekHeight,
      sheetDragHandle: state.hasSheetDragHandle,
      sheetSwipeEnabled: state.hasSheetSwipeEnabled,
      topBar: MainAppBar(
        title: context.l10n.app_components_bottomSheet_standardBottomSheet_tech,
        showBackButton: true,
        previousPageTitle: widget.previousPageTitle,
      ),
      onExpansionChanged: (isExpanded) {
        state.sheetValue = isExpanded
            ? BottomSheetValue.expanded
            : BottomSheetValue.partiallyExpanded;
      },
      sheetContent: (sheetContext) {
        final sheetTheme = OudsTheme.of(sheetContext);
        return Padding(
          padding: EdgeInsets.only(
            bottom: sheetTheme.spaceScheme(sheetContext).fixedMedium,
            left: sheetTheme.gridScheme(sheetContext).margin,
            right: sheetTheme.gridScheme(sheetContext).margin,
          ),
          child: BottomSheetDemoContent(
            showDragHandle: state.hasSheetDragHandle,
            buttonLabel: context
                .l10n
                .app_components_bottomSheet_standardBottomSheet_collapse_label,
            onButtonPressed: () {
              _scaffoldKey.currentState?.partialExpand();
            },
          ),
        );
      },
      content: (bodyContext) {
        return DetailScreenDescription(
          description: context
              .l10n
              .app_components_bottomSheet_standardBottomSheet_description_text,
          widget: Column(
            children: [
              CustomizableSection(
                children: [
                  CustomizableChips<BottomSheetValue>(
                    title: context
                        .l10n
                        .app_components_bottomSheet_standardBottomSheet_sheetValue_tech,
                    options: BottomSheetValue.values,
                    selectedOption: state.sheetValue,
                    getText: (sheetValue) => sheetValue.stringValue(context),
                    onSelected: (sheetValue) {
                      state.sheetValue = sheetValue;
                      if (sheetValue == BottomSheetValue.expanded) {
                        _scaffoldKey.currentState?.expand();
                      } else {
                        _scaffoldKey.currentState?.partialExpand();
                      }
                    },
                  ),
                  CustomizableSwitch(
                    title: context
                        .l10n
                        .app_components_bottomSheet_standardBottomSheet_sheetDragHandle_tech,
                    value: state.hasSheetDragHandle,
                    onChanged: (isEnabled) =>
                        state.hasSheetDragHandle = isEnabled,
                  ),
                  CustomizableSwitch(
                    title: context
                        .l10n
                        .app_components_bottomSheet_standardBottomSheet_sheetSwipeEnabled_tech,
                    value: state.hasSheetSwipeEnabled,
                    onChanged: (isEnabled) =>
                        state.hasSheetSwipeEnabled = isEnabled,
                  ),
                  CustomizableTextField(
                    title: context
                        .l10n
                        .app_components_bottomSheet_standardBottomSheet_sheetPeekHeight_tech,
                    text: state.sheetPeekHeightText,
                    focusNode: _peekHeightFocus,
                    fieldType: FieldType.customHeight,
                    suffixText: context
                        .l10n
                        .app_components_bottomSheet_standardBottomSheet_sheetPeekHeightSuffix_tech,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              SizedBox(
                height: themeController.currentTheme
                    .spaceScheme(context)
                    .fixedMedium,
              ),
              Code(code: StandardBottomSheetCodeGenerator.updateCode(context)),
              ReferenceDesignVersionComponent(
                version: OudsComponentVersion.bottomSheet,
              ),
            ],
          ),
        );
      },
    );
  }
}
