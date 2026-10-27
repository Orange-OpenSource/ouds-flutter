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

import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_contract/theme/scheme/typography/ouds_system_monospace_font.dart';
import 'package:provider/provider.dart';

class TypographyScreen extends StatelessWidget {
  final String illustration;
  final String? previousPageTitle;
  const TypographyScreen({
    super.key,
    required this.illustration,
    this.previousPageTitle,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    final currentTheme = themeController.currentTheme;
    final fontTokenItems = _getFontTokenItems(currentTheme, context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        showBackButton: true,
        title: context.l10n.app_tokens_typography_label,
        previousPageTitle: previousPageTitle,
      ),
      body: ListView(
        children: [
          SvgPicture.asset(
            AdaptiveImageHelper.getImage(context, illustration),
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: EdgeInsetsDirectional.all(
              currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge,
            ),
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
            code:
                'OudsTheme.of(context).typographyTokens.typeDisplayLarge(context)',
          ),
          Padding(
            padding: EdgeInsetsDirectional.all(
              currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge,
            ),
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
    );
  }

  List<FontTokenItem> _getFontTokenItems(
    OudsThemeContract currentTheme,
    BuildContext context,
  ) {
    final tokens = currentTheme.typographyTokens;

    // Builds a [FontTokenItem] from a typography token getter (e.g. `tokens.typeDisplayLarge`),
    // deriving the displayed token name directly from the function itself
    FontTokenItem buildItem(
      TextStyle Function(BuildContext) tokenGetter, {
      String? familyOverride,
    }) {
      final style = tokenGetter(context);
      // typeCodeMedium disables text-style inheritance to preserve the platform’s native monospace font,
      // so its color must be set explicitly.
      final resolvedStyle = style.inherit
          ? style
          : style.copyWith(
              color:
                  style.color ??
                  currentTheme.colorScheme(context).contentDefault,
            );
      debugPrint("typo : ${style.fontFamily ?? ''}");
      debugPrint("typo1 : ${currentTheme.fontFamily ?? ''}");
      return FontTokenItem(
        tokenName: _tokenDisplayName(tokenGetter),
        style: resolvedStyle,
        // currentTheme.fontFamily is null when the theme defers to the platform's native font
        // (e.g. Roboto/SF Pro); fall back to an empty label rather than crash in that case.
        family: familyOverride ?? currentTheme.fontFamily ?? '',
        weight: style.fontWeight!,
        size: style.fontSize!,
        lineHeight: roundToOneDecimal(style.height!),
        letterSpacing: style.letterSpacing!,
      );
    }

    return [
      buildItem(tokens.typeDisplayLarge),
      buildItem(tokens.typeDisplayMedium),
      buildItem(tokens.typeDisplaySmall),
      buildItem(tokens.typeHeadingXLarge),
      buildItem(tokens.typeHeadingLarge),
      buildItem(tokens.typeHeadingMedium),
      buildItem(tokens.typeHeadingSmall),
      buildItem(tokens.typeBodyDefaultLarge),
      buildItem(tokens.typeBodyDefaultMedium),
      buildItem(tokens.typeBodyDefaultSmall),
      buildItem(tokens.typeBodyModerateLarge),
      buildItem(tokens.typeBodyModerateMedium),
      buildItem(tokens.typeBodyModerateSmall),
      buildItem(tokens.typeBodyStrongLarge),
      buildItem(tokens.typeBodyStrongMedium),
      buildItem(tokens.typeBodyStrongSmall),
      buildItem(tokens.typeLabelDefaultXLarge),
      buildItem(tokens.typeLabelDefaultLarge),
      buildItem(tokens.typeLabelDefaultMedium),
      buildItem(tokens.typeLabelDefaultSmall),
      buildItem(tokens.typeLabelModerateXLarge),
      buildItem(tokens.typeLabelModerateLarge),
      buildItem(tokens.typeLabelModerateMedium),
      buildItem(tokens.typeLabelModerateSmall),
      buildItem(tokens.typeLabelStrongXLarge),
      buildItem(tokens.typeLabelStrongLarge),
      buildItem(tokens.typeLabelStrongMedium),
      buildItem(tokens.typeLabelStrongSmall),
      buildItem(
        tokens.typeCodeMedium,
        familyOverride: oudsSystemMonospaceFontFamily,
      ),
    ];
  }

  /// Derives the displayed token name directly from a typography token getter's own
  /// [Function.toString] representation (e.g. "typeDisplayLarge" -> "DisplayLarge"), stripping
  /// the leading "type" prefix.
  String _tokenDisplayName(Function tokenGetter) {
    final match = RegExp(
      r"Function '(\w+)'",
    ).firstMatch(tokenGetter.toString());
    final rawName = match?.group(1) ?? '';
    const prefix = 'type';
    return rawName.startsWith(prefix)
        ? rawName.substring(prefix.length)
        : rawName;
  }
}

class FontWidget extends StatelessWidget {
  const FontWidget({super.key, required this.fontTokenItem});

  final FontTokenItem fontTokenItem;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    final currentTheme = themeController.currentTheme;
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: currentTheme.spaceScheme(context).rowGapSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fontTokenItem.tokenName, style: fontTokenItem.style),
                SizedBox(height: currentTheme.spaceScheme(context).fixedSmall),
                Text(
                  "${context.l10n.app_tokens_typography_family_tech(fontTokenItem.family.toString())},"
                  " ${context.l10n.app_tokens_typography_weight_tech(fontTokenItem.weight.toString())},"
                  " ${context.l10n.app_tokens_typography_size_tech(fontTokenItem.size.toString())} ,"
                  " ${context.l10n.app_tokens_typography_lineHeight_tech(fontTokenItem.lineHeight.toString())},"
                  " ${context.l10n.app_tokens_typography_letterSpacing_tech(fontTokenItem.letterSpacing.toString())}",
                  style: currentTheme.typographyTokens
                      .typeBodyDefaultMedium(context)
                      .copyWith(
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

class FontTokenItem {
  const FontTokenItem({
    required this.tokenName,
    required this.style,
    required this.family,
    required this.weight,
    required this.size,
    required this.lineHeight,
    required this.letterSpacing,
  });

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
