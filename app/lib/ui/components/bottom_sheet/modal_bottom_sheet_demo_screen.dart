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
import 'package:ouds_core/components/bottom_sheet/ouds_modal_bottom_sheet.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/bottom_sheet_demo_content.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/modal_bottom_sheet_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/modal_bottom_sheet_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// Demo screen for [OudsModalBottomSheet].
///
/// Mirrors `ModalBottomSheetDemoScreen` from the Android app.
class ModalBottomSheetDemoScreen extends StatelessWidget {
  const ModalBottomSheetDemoScreen({super.key, this.previousPageTitle});

  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: defaultTargetPlatform == TargetPlatform.android
              ? MediaQuery.of(context).viewPadding.bottom
              : OudsTheme.of(context).spaceScheme(context).paddingBlockNone,
        ),
        child: ModalBottomSheetCustomization(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: MainAppBar(
              title:
                  context.l10n.app_components_bottomSheet_modalBottomSheet_tech,
              showBackButton: true,
              previousPageTitle: previousPageTitle,
            ),
            body: const _Body(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    return DetailScreenDescription(
      description: context
          .l10n
          .app_components_bottomSheet_modalBottomSheet_description_text,
      widget: Column(
        children: [
          const _CustomizationContent(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          const _ModalBottomSheetDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(code: ModalBottomSheetCodeGenerator.updateCode(context)),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.bottomSheet,
          ),
        ],
      ),
    );
  }
}

/// Customization switches for the modal bottom sheet demo (drag handle, gestures).
class _CustomizationContent extends StatelessWidget {
  const _CustomizationContent();

  @override
  Widget build(BuildContext context) {
    final state = ModalBottomSheetCustomization.of(context);
    if (state == null) return const SizedBox.shrink();

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context
              .l10n
              .app_components_bottomSheet_modalBottomSheet_dragHandle_tech,
          value: state.hasDragHandle,
          onChanged: (isEnabled) => state.hasDragHandle = isEnabled,
        ),
        CustomizableSwitch(
          title: context
              .l10n
              .app_components_bottomSheet_modalBottomSheet_sheetGestureEnabled_tech,
          value: state.hasSheetGesturesEnabled,
          onChanged: (isEnabled) => state.hasSheetGesturesEnabled = isEnabled,
        ),
      ],
    );
  }
}

class _ModalBottomSheetDemo extends StatelessWidget {
  const _ModalBottomSheetDemo();

  @override
  Widget build(BuildContext context) {
    final state = ModalBottomSheetCustomization.of(context);
    final dragHandle = state?.hasDragHandle ?? true;
    final gesturesEnabled = state?.hasSheetGesturesEnabled ?? true;

    return OudsButton(
      label: context
          .l10n
          .app_components_bottomSheet_modalBottomSheet_showButton_label,
      appearance: OudsButtonAppearance.defaultAppearance,
      onPressed: () => OudsModalBottomSheet(
        dragHandle: dragHandle,
        sheetGesturesEnabled: gesturesEnabled,
        builder: (sheetContext) {
          final sheetTheme = OudsTheme.of(sheetContext);
          return Padding(
            padding: EdgeInsets.only(
              bottom: sheetTheme.spaceScheme(sheetContext).paddingBlockNone,
              left: sheetTheme.gridScheme(sheetContext).margin,
              right: sheetTheme.gridScheme(sheetContext).margin,
            ),
            child: BottomSheetDemoContent(
              showDragHandle: dragHandle,
              buttonLabel: context
                  .l10n
                  .app_components_bottomSheet_modalBottomSheet_close_label,
              onButtonPressed: () => Navigator.of(sheetContext).pop(),
            ),
          );
        },
      ).show(context: context),
    );
  }
}
