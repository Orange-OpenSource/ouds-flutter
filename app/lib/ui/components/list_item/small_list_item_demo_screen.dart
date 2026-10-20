/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 *
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 *
 * // Software description: Flutter library of reusable graphical components
 *
 */

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization_panel.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/customize_bottom_sheet.dart';
import 'package:provider/provider.dart';

/// Screen for the [OudsSmallListItem] component demo.
class SmallListItemDemoScreen extends StatefulWidget {
  final String? previousPageTitle;

  const SmallListItemDemoScreen({super.key, this.previousPageTitle});

  @override
  State<SmallListItemDemoScreen> createState() =>
      _SmallListItemDemoScreenState();
}

class _SmallListItemDemoScreenState extends State<SmallListItemDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: ListItemCustomization(
        child: CustomizeBottomSheet(
          topBar: MainAppBar(
            title: context.l10n.app_components_listItem_smallListItem_tech,
            previousPageTitle: widget.previousPageTitle,
            showBackButton: true,
          ),
          title: context.l10n.app_common_customize_label,
          customizationContent: const ListItemCustomizationPanel(
            variant: ListItemDemoVariant.smallListItem,
          ),
          body: _Body(),
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
          context.l10n.app_components_listItem_smallListItem_description_text,
      widget: Column(
        children: [
          _SmallListItemDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(code: ListItemCodeGenerator.updateCode(context, isSmall: true)),
          const ReferenceDesignVersionComponent(version: '0.1.0'),
        ],
      ),
    );
  }
}

/// Widget that displays [OudsSmallListItem] with the current customizations.
class _SmallListItemDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customizationState = ListItemCustomization.of(context)!;
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );

    return LightDarkBox(
      isEdgeToEdge: customizationState.edgeToEdge,
      child: Column(
        children: [
          customizationState.clickable
              ? ListItemCustomizationUtils.buildNavigationSmallListItem(
                  context,
                  customizationState,
                  themeController,
                )
              : ListItemCustomizationUtils.buildSmallListItem(
                  context,
                  customizationState,
                  themeController,
                ),
        ],
      ),
    );
  }
}
