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
import 'package:ouds_flutter_demo/ui/utilities/global_app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:provider/provider.dart';

class OpacityScreen extends StatelessWidget {
  final String illustration;
  const OpacityScreen({super.key, required this.illustration});

  @override
  Widget build(BuildContext context) {
    final themeController =
        Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    final opacityTokenItems = _getOpacityTokenItems(currentTheme);

    return Scaffold(
      appBar: MainAppBar(title: context.l10n.app_tokens_opacity_label),
      body: SafeArea(
        child: ListView(
          children: [
            SvgPicture.asset(
              AdaptiveImageHelper.getImage(context, illustration),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding:
                  EdgeInsets.all(currentTheme.spaceTokens.paddingInlineTall),
              child: Column(
                children: [
                  Text(
                    context.l10n.app_tokens_opacity_description_text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Code(
              titleText: context.l10n.app_tokens_viewCodeExample_label,
              code: 'OudsTheme.of(context).opacityTokens.invisible',
            ),
            Padding(
              padding:
                  EdgeInsets.all(currentTheme.spaceTokens.paddingInlineTall),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: opacityTokenItems.length,
                itemBuilder: (context, index) {
                  return OpacityWidget(
                      opacityTokenItem: opacityTokenItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<OpacityTokenItem> _getOpacityTokenItems(OudsThemeContract currentTheme) {
    return [
      OpacityTokenItem(
          name: 'invisible', value: currentTheme.opacityTokens.invisible),
      OpacityTokenItem(
          name: 'weaker', value: currentTheme.opacityTokens.weaker),
      OpacityTokenItem(name: 'weak', value: currentTheme.opacityTokens.weak),
      OpacityTokenItem(
          name: 'medium', value: currentTheme.opacityTokens.medium),
      OpacityTokenItem(
          name: 'strong', value: currentTheme.opacityTokens.strong),
      OpacityTokenItem(
          name: 'opaque', value: currentTheme.opacityTokens.opaque),
    ];
  }
}

class OpacityWidget extends StatelessWidget {
  const OpacityWidget({super.key, required this.opacityTokenItem});

  final OpacityTokenItem opacityTokenItem;

  @override
  Widget build(BuildContext context) {
    final themeController =
        Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;

    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: currentTheme.spaceTokens.rowGapShort),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: SizedBox(
              width: 64,
              height: 64,
              child: Stack(
                children: [
                  // Background image
                  Positioned(
                    top: currentTheme.spaceTokens.insetNone,
                    left: currentTheme.spaceTokens.insetNone,
                    child:
                    SvgPicture.asset(
                      AdaptiveImageHelper.getImage(context, AppAssets.images.ilUnion),
                      fit: BoxFit.fitWidth,
                      width: 48,
                      height: 48,
                    ),
                  ),
                  Positioned(
                    top: currentTheme.spaceTokens.insetMedium,
                    left: currentTheme.spaceTokens.insetMedium,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color:
                            currentTheme.colorsScheme.contentDefault.withValues(
                          alpha: opacityTokenItem.value,
                        ),
                        border: Border.all(
                            color: currentTheme.colorsScheme.borderDefault,
                            width: currentTheme.borderTokens.widthDefault),
                      ),
                      // Make content invisible, but border stays visible
                      child: Opacity(
                        opacity: currentTheme.opacityTokens.invisible,
                        // Invisible content
                        child: Container(
                          color: currentTheme.colorsScheme
                              .contentDefault, // Invisible background
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: currentTheme.spaceTokens.paddingInlineTall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  opacityTokenItem.name,
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: currentTheme.fontTokens.weightBodyStrong,
                    letterSpacing:
                        currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                    color: currentTheme.colorsScheme.contentDefault,
                  ),
                ),
                SizedBox(height: currentTheme.spaceTokens.rowGapNone),
                Text(
                  opacityTokenItem.value.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyMediumMobile,
                    fontWeight: currentTheme.fontTokens.weightDefault,
                    letterSpacing:
                        currentTheme.fontTokens.letterSpacingBodyMediumMobile,
                    color: currentTheme.colorsScheme.contentMuted,
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

class OpacityTokenItem {
  const OpacityTokenItem({required this.name, required this.value});

  final String name;
  final double value;
}
