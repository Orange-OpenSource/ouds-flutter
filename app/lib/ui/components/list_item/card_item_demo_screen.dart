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
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:provider/provider.dart';

/// Screen for the [OudsCardItem] component demo.
class CardItemDemoScreen extends StatefulWidget {
  final String? previousPageTitle;

  const CardItemDemoScreen({super.key, this.previousPageTitle});

  @override
  State<CardItemDemoScreen> createState() => _CardItemDemoScreenState();
}

class _CardItemDemoScreenState extends State<CardItemDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: ListItemCustomization(
        child: CustomizeBottomSheet(
          topBar: MainAppBar(
            title: context.l10n.app_components_listItem_cardItem_tech,
            previousPageTitle: widget.previousPageTitle,
            showBackButton: true,
          ),
          title: context.l10n.app_common_customize_label,
          customizationContent: const ListItemCustomizationPanel(
            variant: ListItemDemoVariant.cardItem,
          ),
          body: _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    final customizationState = ListItemCustomization.of(context)!;
    return DetailScreenDescription(
      description:
          context.l10n.app_components_listItem_cardItem_description_text,
      widget: Column(
        children: [
          _CardItemDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(
            code: ListItemCodeGenerator.updateCardCode(context, isSmall: false),
          ),
          ReferenceDesignVersionComponent(
            version: customizationState.clickable
                ? OudsComponentVersion.navigationCardItem
                : OudsComponentVersion.staticCardItem,
          ),
        ],
      ),
    );
  }
}

class _CardItemDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customizationState = ListItemCustomization.of(context)!;
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );

    return LightDarkBox(
      child: ListItemCustomizationUtils.buildCardItem(
        context,
        customizationState,
        themeController,
      ),
    );
  }
}
