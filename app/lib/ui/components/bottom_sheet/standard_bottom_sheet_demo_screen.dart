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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/bottom_sheet/ouds_bottom_sheet_scaffold.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/bottom_sheet_demo_content.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/standard_bottom_sheet_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/standard_bottom_sheet_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
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
      child: StandardBottomSheetCustomization(
        child: _StandardBottomSheetScaffold(
          previousPageTitle: widget.previousPageTitle,
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
        title: context.l10n.app_components_bottomSheet_standard_label,
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
            buttonLabel:
                context.l10n.app_components_bottomSheet_standard_collapse_label,
            onButtonPressed: () {
              _scaffoldKey.currentState?.partialExpand();
            },
          ),
        );
      },
      content: (bodyContext) {
        return DetailScreenDescription(
          description:
              context.l10n.app_components_bottomSheet_standard_description_text,
          widget: Column(
            children: [
              CustomizableSection(
                children: [
                  CustomizableChips<BottomSheetValue>(
                    title: context
                        .l10n
                        .app_components_bottomSheet_sheetValue_label,
                    options: BottomSheetValue.values,
                    selectedOption: state.sheetValue,
                    getText: (v) => v == BottomSheetValue.expanded
                        ? context
                              .l10n
                              .app_components_bottomSheet_sheetValue_expanded_label
                        : context
                              .l10n
                              .app_components_bottomSheet_sheetValue_partiallyExpanded_label,
                    onSelected: (v) {
                      state.sheetValue = v;
                      if (v == BottomSheetValue.expanded) {
                        _scaffoldKey.currentState?.expand();
                      } else {
                        _scaffoldKey.currentState?.partialExpand();
                      }
                    },
                  ),
                  CustomizableSwitch(
                    title: context
                        .l10n
                        .app_components_bottomSheet_dragHandle_label,
                    value: state.hasSheetDragHandle,
                    onChanged: (v) => state.hasSheetDragHandle = v,
                  ),
                  CustomizableSwitch(
                    title: context
                        .l10n
                        .app_components_bottomSheet_sheetSwipeEnabled_label,
                    value: state.hasSheetSwipeEnabled,
                    onChanged: (v) => state.hasSheetSwipeEnabled = v,
                  ),
                  CustomizableTextField(
                    title: context
                        .l10n
                        .app_components_bottomSheet_sheetPeekHeight_label,
                    text: state.sheetPeekHeightText,
                    focusNode: _peekHeightFocus,
                    fieldType: FieldType.customHeight,
                    suffixText: context
                        .l10n
                        .app_components_bottomSheet_sheetPeekHeightSuffix_label,
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
            ],
          ),
        );
      },
    );
  }
}
