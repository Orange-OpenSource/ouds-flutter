/*
 * Software Name : Orange Design System
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:provider/provider.dart';

class TypographyScreen extends StatelessWidget {
  final String illustration;
  const TypographyScreen({super.key, required this.illustration});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    final fontTokenItems = _getFontTokenItems(currentTheme, context);

    return Scaffold(
      appBar: MainAppBar(title: context.l10n.app_tokens_typography_label),
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
                    context.l10n.app_tokens_typography_description_text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Code(
              titleText: context.l10n.app_tokens_viewCodeExample_label,
              code: 'OudsTheme.of(context).typographyTokens.typeDisplayLarge(context)',
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: fontTokenItems.length,
                itemBuilder: (context, index) {
                  return FontWidget(fontTokenItem: fontTokenItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FontTokenItem> _getFontTokenItems(OudsThemeContract currentTheme, BuildContext context) {
    return [
      FontTokenItem(
        tokenName: "DisplayLarge",
        style: currentTheme.typographyTokens.typeDisplayLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeDisplayLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeDisplayLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeDisplayLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeDisplayLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "DisplayMedium",
        style: currentTheme.typographyTokens.typeDisplayMedium(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeDisplayMedium(context).fontWeight!,
        size: currentTheme.typographyTokens.typeDisplayMedium(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeDisplayMedium(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeDisplayMedium(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "DisplaySmall",
        style: currentTheme.typographyTokens.typeDisplaySmall(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeDisplaySmall(context).fontWeight!,
        size: currentTheme.typographyTokens.typeDisplaySmall(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeDisplaySmall(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeDisplaySmall(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "HeadingXLarge",
        style: currentTheme.typographyTokens.typeHeadingXLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeHeadingXLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeHeadingXLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeHeadingXLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeHeadingXLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "HeadingLarge",
        style: currentTheme.typographyTokens.typeHeadingLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeHeadingLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeHeadingLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeHeadingLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeHeadingLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "HeadingMedium",
        style: currentTheme.typographyTokens.typeHeadingMedium(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeHeadingMedium(context).fontWeight!,
        size: currentTheme.typographyTokens.typeHeadingMedium(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeHeadingMedium(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeHeadingMedium(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "HeadingSmall",
        style: currentTheme.typographyTokens.typeHeadingSmall(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeHeadingSmall(context).fontWeight!,
        size: currentTheme.typographyTokens.typeHeadingSmall(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeHeadingSmall(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeHeadingSmall(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "BodyDefaultLarge",
        style: currentTheme.typographyTokens.typeBodyDefaultLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeBodyDefaultLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeBodyDefaultLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeBodyDefaultLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeBodyDefaultLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "BodyDefaultMedium",
        style: currentTheme.typographyTokens.typeBodyDefaultMedium(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeBodyDefaultMedium(context).fontWeight!,
        size: currentTheme.typographyTokens.typeBodyDefaultMedium(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeBodyDefaultMedium(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeBodyDefaultMedium(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "BodyDefaultSmall",
        style: currentTheme.typographyTokens.typeBodyDefaultSmall(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeBodyDefaultSmall(context).fontWeight!,
        size: currentTheme.typographyTokens.typeBodyDefaultSmall(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeBodyDefaultSmall(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeBodyDefaultSmall(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "BodyStrongLarge",
        style: currentTheme.typographyTokens.typeBodyStrongLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeBodyStrongLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeBodyStrongLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeBodyStrongLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeBodyStrongLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "BodyStrongMedium",
        style: currentTheme.typographyTokens.typeBodyStrongMedium(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeBodyStrongMedium(context).fontWeight!,
        size: currentTheme.typographyTokens.typeBodyStrongMedium(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeBodyStrongMedium(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeBodyStrongMedium(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "BodyStrongSmall",
        style: currentTheme.typographyTokens.typeBodyStrongSmall(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeBodyStrongSmall(context).fontWeight!,
        size: currentTheme.typographyTokens.typeBodyStrongSmall(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeBodyStrongSmall(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeBodyStrongSmall(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "LabelDefaultXLarge",
        style: currentTheme.typographyTokens.typeLabelDefaultXLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeLabelDefaultXLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeLabelDefaultXLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeLabelDefaultXLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeLabelDefaultXLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "LabelDefaultLarge",
        style: currentTheme.typographyTokens.typeLabelDefaultLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeLabelDefaultLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeLabelDefaultLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeLabelDefaultLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeLabelDefaultLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "LabelDefaultMedium",
        style: currentTheme.typographyTokens.typeLabelDefaultMedium(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeLabelDefaultMedium(context).fontWeight!,
        size: currentTheme.typographyTokens.typeLabelDefaultMedium(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeLabelDefaultMedium(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeLabelDefaultMedium(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "LabelDefaultSmall",
        style: currentTheme.typographyTokens.typeLabelDefaultSmall(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeLabelDefaultSmall(context).fontWeight!,
        size: currentTheme.typographyTokens.typeLabelDefaultSmall(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeLabelDefaultSmall(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeLabelDefaultSmall(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "LabelStrongXLarge",
        style: currentTheme.typographyTokens.typeLabelStrongXLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeLabelStrongXLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeLabelStrongXLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeLabelStrongXLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeLabelStrongXLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "LabelStrongLarge",
        style: currentTheme.typographyTokens.typeLabelStrongLarge(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeLabelStrongLarge(context).fontWeight!,
        size: currentTheme.typographyTokens.typeLabelStrongLarge(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeLabelStrongLarge(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeLabelStrongLarge(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "LabelStrongMedium",
        style: currentTheme.typographyTokens.typeLabelStrongMedium(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeLabelStrongMedium(context).fontWeight!,
        size: currentTheme.typographyTokens.typeLabelStrongMedium(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeLabelStrongMedium(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeLabelStrongMedium(context).letterSpacing!,
      ),
      FontTokenItem(
        tokenName: "LabelStrongSmall",
        style: currentTheme.typographyTokens.typeLabelStrongSmall(context),
        family: currentTheme.fontFamily,
        weight: currentTheme.typographyTokens.typeLabelStrongSmall(context).fontWeight!,
        size: currentTheme.typographyTokens.typeLabelStrongSmall(context).fontSize!,
        lineHeight: roundToOneDecimal(currentTheme.typographyTokens.typeLabelStrongSmall(context).height!),
        letterSpacing: currentTheme.typographyTokens.typeLabelStrongSmall(context).letterSpacing!,
      ),
    ];
  }
}

class FontWidget extends StatelessWidget {
  const FontWidget({super.key, required this.fontTokenItem});

  final FontTokenItem fontTokenItem;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: currentTheme.spaceScheme(context).rowGapSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fontTokenItem.tokenName,
                  style: fontTokenItem.style,
                ),
                SizedBox(height: currentTheme.spaceScheme(context).fixedSmall),
                Text(
                  "family (${fontTokenItem.family}),"
                  " weight (${fontTokenItem.weight.value}),"
                  " size (${fontTokenItem.size}),"
                  " lineHeight (${fontTokenItem.lineHeight}),"
                  " letterSpacing (${fontTokenItem.letterSpacing})",
                  style: currentTheme.typographyTokens.typeBodyDefaultMedium(context).copyWith(color: currentTheme.colorScheme(context).contentMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FontTokenItem {
  const FontTokenItem({required this.tokenName, required this.style, required this.family, required this.weight, required this.size, required this.lineHeight, required this.letterSpacing});

  final String tokenName;
  final TextStyle style;
  final String family;
  final FontWeight weight;
  final double size;
  final double lineHeight;
  final double letterSpacing;
}

double roundToOneDecimal(double value) {
  return (value * 10).round() / 10;
}
