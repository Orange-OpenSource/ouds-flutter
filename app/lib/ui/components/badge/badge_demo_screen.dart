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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/badge/internal/ouds_badge_status_modifier.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_dropdown_menu.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_flutter_demo/ui/utilities/theme_colored_box.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// This screen displays a radio_button demo and allows customization of radio_button properties
class BadgeDemoScreen extends StatefulWidget {
  final bool indeterminate;

  const BadgeDemoScreen({super.key, this.indeterminate = false}); // Default value set to false

  @override
  State<BadgeDemoScreen> createState() => _BadgeDemoScreenState();
}

class _BadgeDemoScreenState extends State<BadgeDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BadgeCustomization(
      child: Scaffold(
        bottomSheet: OudsSheetsBottom(
          onExpansionChanged: _onExpansionChanged,
          sheetContent: const _CustomizationContent(),
          title: context.l10n.app_common_customize_label,
        ),
        key: _scaffoldKey,
        appBar: MainAppBar(title: context.l10n.app_components_badge_label),
        body: SafeArea(
          child: ExcludeSemantics(excluding: !_isBottomSheetExpanded, child: _Body(indeterminate: widget.indeterminate)),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the radio_button demo and code will be displayed
class _Body extends StatefulWidget {
  final bool indeterminate;
  const _Body({required this.indeterminate});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: true);
    return DetailScreenDescription(
      //description: context.l10n.app_components_badge_description_text,
      widget: Column(
        children: [
          _BadgeDemo(),
          SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedMedium),
          Code(code: BadgeCodeGenerator.updateCode(context)),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the radio_button demo.
///
/// Component [BadgeDemo] demonstrates the behavior and functionality of a radio_button.
class _BadgeDemo extends StatefulWidget {
  const _BadgeDemo();
  @override
  State<_BadgeDemo> createState() => _BadgeDemoState();
}

class _BadgeDemoState extends State<_BadgeDemo> {
  ThemeController? themeController;
  BadgeCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = BadgeCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: false);

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController?.setOnColoredSurface(customizationState?.hasOnColoredBox);
    });

    return Column(
      children: [
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.light : ThemeMode.dark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsBadge(
                //label: "1",
                size: BadgeCustomizationUtils.getSize(customizationState!.selectedState),
                status: BadgeCustomizationUtils.getStatus(customizationState!.selectedStatus),
              )
            ],
          ),
        ),
        ThemeBox(
          themeContract: themeController!.currentTheme,
          themeMode: themeController!.isInverseDarkTheme ? ThemeMode.dark : ThemeMode.light,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OudsBadge(
                //icon: AppAssets.icons.icHeart,
                size: BadgeCustomizationUtils.getSize(customizationState!.selectedState),
                status: BadgeCustomizationUtils.getStatus(customizationState!.selectedStatus),
              )
            ],
          ),
        ),
        SizedBox(height: themeController?.currentTheme.spaceScheme(context).fixedSmall),
      ],
    );
  }
}

/// This widget represents the customization content section that appears in the bottom sheet
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the Badge
class _CustomizationContentState extends State<_CustomizationContent> {
  _CustomizationContentState();

  @override
  Widget build(BuildContext context) {
    final BadgeCustomizationState? customizationState = BadgeCustomization.of(context);
    final badgeStatusModifier = OudsBadgeStatusModifier(context);
    final theme = OudsTheme.of(context).spaceScheme(context);
    var status = customizationState!.statusState.list;
    var size = customizationState.sizeState.list;

    return CustomizableSection(
      children: [
        CustomizableChips<BadgeEnumSize>(
          title: BadgeEnumSize.enumName(context),
          options: size,
          selectedOption: customizationState.selectedState,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedState = selectedOption;
            });
          },
        ),
        CustomizationDropdownMenu<BadgeEnumStatus>(
          label: BadgeEnumStatus.enumName(context),
          options: status,
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
                    color: badgeStatusModifier.getStatusColor(BadgeCustomizationUtils.getStatus(status)),
                    shape: BoxShape.rectangle,
                  ),
                );
          }).toList(),
        ),
      ],
    );
  }
}
