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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:provider/provider.dart';

class BorderScreen extends StatelessWidget {
  final String illustration;

  const BorderScreen({super.key, required this.illustration});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    final List<BorderTokenItem> borderItems = _getBorderTokenItems(currentTheme);
    final Map<String, List<BorderTokenItem>> tokenGroups = BorderTokenGrouper(borderItems).groupBySection();

    return Scaffold(
      appBar: MainAppBar(title: context.l10n.app_tokens_border_label),
      body: SafeArea(
        child: ListView(
          children: [
            SvgPicture.asset(
              AdaptiveImageHelper.getImage(context, illustration),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge),
              child: Column(
                children: [
                  Text(
                    context.l10n.app_tokens_elevation_description_text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Code(
              titleText: context.l10n.app_tokens_viewCodeExample_label,
              code: 'OudsTheme.of(context).borderTokens.widthDefault',
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.only(
                top: currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge,
                bottom: currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge,
              ),
              children: [
                for (var entry in tokenGroups.entries) ...[
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: currentTheme.spaceScheme(context).rowGapLarge,
                      horizontal: currentTheme.spaceScheme(context).rowGapLarge,
                    ),
                    child: Semantics(
                      header: true,
                      child: Text(
                        entry.key,
                        style: currentTheme.typographyTokens.typeHeadingSmall(context).copyWith(color: currentTheme.colorScheme(context).contentDefault),
                      ),
                    ),
                  ),
                  ...entry.value.map(
                    (item) => Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge,
                      ),
                      child: BorderWidget(borderTokenItem: item),
                    ),
                  ),
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BorderWidget extends StatelessWidget {
  const BorderWidget({super.key, required this.borderTokenItem});

  final BorderTokenItem borderTokenItem;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: currentTheme.spaceScheme(context).rowGapSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: currentTheme.colorScheme(context).bgSecondary,
              border: Border.all(
                color: currentTheme.colorScheme(context).borderFocus,
                width: borderTokenItem.sectionName == BorderSection.Width ? borderTokenItem.value as double : 1.0,

                /// ToDo: ----------- Modify this section with the logic of DashedBorderPainter if is OK ------------
                style: borderTokenItem.sectionName == BorderSection.Style
                    ? borderTokenItem.value == "solid"
                        ? BorderStyle.solid
                        : BorderStyle.none
                    : BorderStyle.solid,

                /// ToDo: ---------------------------- End Of the Modification ---------------------------------------
              ),
              borderRadius: BorderRadius.circular(
                borderTokenItem.sectionName == BorderSection.Radius ? borderTokenItem.value as double : 1.0, // utilise le radius si défini
              ),
            ),
          ),
          SizedBox(width: currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  borderTokenItem.tokenName,
                  style: currentTheme.typographyTokens.typeBodyStrongLarge(context).copyWith(
                        color: currentTheme.colorScheme(context).contentDefault,
                      ),
                ),
                SizedBox(height: currentTheme.spaceScheme(context).rowGapNone),
                Text(
                  borderTokenItem.value.toString(),
                  style: currentTheme.typographyTokens.typeBodyDefaultMedium(context).copyWith(
                        color: currentTheme.colorScheme(context).contentMuted,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Enum representing different sections of border properties.
enum BorderSection {
  Width,
  Radius,
  Style,
}

extension BorderSectionExtension on BorderSection {
  String stringValue(BuildContext context) {
    switch (this) {
      case BorderSection.Width:
        return context.l10n.app_tokens_border_width_label;
      case BorderSection.Radius:
        return context.l10n.app_tokens_border_radius_label;
      case BorderSection.Style:
        return context.l10n.app_tokens_border_style_label;
    }
  }
}

/// Represents a border property with a section (like Width, Radius, or Style), a name, and a value.
class BorderTokenItem {
  const BorderTokenItem({
    required this.sectionName,
    required this.tokenName,
    required this.value,
  });

  final BorderSection sectionName;
  final String tokenName;
  final dynamic value;
}

/// Groups a list of border items by their section names.
class BorderTokenGrouper {
  final List<BorderTokenItem> items;

  BorderTokenGrouper(this.items);

  Map<String, List<BorderTokenItem>> groupBySection() {
    final Map<String, List<BorderTokenItem>> grouped = {};

    for (var item in items) {
      grouped.putIfAbsent(item.sectionName.name, () => []).add(item);
    }

    return grouped;
  }
}

/// Creates a list of border items based on the current theme, including widths, radii, and styles.
List<BorderTokenItem> _getBorderTokenItems(OudsThemeContract currentTheme) {
  return [
    BorderTokenItem(sectionName: BorderSection.Width, tokenName: 'borderWidthNone', value: currentTheme.borderTokens.widthNone),
    BorderTokenItem(sectionName: BorderSection.Width, tokenName: 'borderWidthDefault', value: currentTheme.borderTokens.widthDefault),
    BorderTokenItem(sectionName: BorderSection.Width, tokenName: 'borderWidthThin', value: currentTheme.borderTokens.widthThin),
    BorderTokenItem(sectionName: BorderSection.Width, tokenName: 'borderWidthMedium', value: currentTheme.borderTokens.widthMedium),
    BorderTokenItem(sectionName: BorderSection.Width, tokenName: 'borderWidthThick', value: currentTheme.borderTokens.widthThick),
    BorderTokenItem(sectionName: BorderSection.Width, tokenName: 'borderWidthThicker', value: currentTheme.borderTokens.widthThicker),
    BorderTokenItem(sectionName: BorderSection.Width, tokenName: 'borderWidthFocus', value: currentTheme.borderTokens.widthFocus),
    BorderTokenItem(sectionName: BorderSection.Width, tokenName: 'borderWidthFocusInset', value: currentTheme.borderTokens.widthFocusInset),

    // Section Radius
    BorderTokenItem(sectionName: BorderSection.Radius, tokenName: 'borderRadiusNone', value: currentTheme.borderTokens.radiusNone),
    BorderTokenItem(sectionName: BorderSection.Radius, tokenName: 'borderRadiusDefault', value: currentTheme.borderTokens.radiusDefault),
    BorderTokenItem(sectionName: BorderSection.Radius, tokenName: 'borderRadiusSmall', value: currentTheme.borderTokens.radiusSmall),
    BorderTokenItem(sectionName: BorderSection.Radius, tokenName: 'borderRadiusMedium', value: currentTheme.borderTokens.radiusMedium),
    BorderTokenItem(sectionName: BorderSection.Radius, tokenName: 'borderRadiusLarge', value: currentTheme.borderTokens.radiusLarge),
    BorderTokenItem(sectionName: BorderSection.Radius, tokenName: 'borderRadiusPill', value: currentTheme.borderTokens.radiusPill),
    // Section Style
    BorderTokenItem(sectionName: BorderSection.Style, tokenName: 'borderStyleDefault', value: currentTheme.borderTokens.styleDefault),
    BorderTokenItem(sectionName: BorderSection.Style, tokenName: 'borderStyleDrag', value: currentTheme.borderTokens.styleDrag),
  ];
}
