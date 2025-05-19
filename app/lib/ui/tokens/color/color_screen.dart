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
import 'package:ouds_flutter_demo/ui/tokens/color/color_tokens_model.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:provider/provider.dart';

class ColorScreen extends StatelessWidget {
  final String illustration;
  const ColorScreen({super.key, required this.illustration});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    final tokenGroups = ColorTokensModel.fromTheme(context, currentTheme).all;

    return Scaffold(
      appBar: MainAppBar(title: context.l10n.app_tokens_color_label),
      body: SafeArea(
        child: ListView(
          children: [
            SvgPicture.asset(
              AdaptiveImageHelper.getImage(context, illustration),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(currentTheme.spaceTokens.paddingInlineTall),
              child: Column(
                children: [
                  Text(
                    context.l10n.app_tokens_color_description_text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Code(
              titleText: context.l10n.app_tokens_viewCodeExample_label,
              code: 'OudsTheme.of(context).colorsScheme(context).actionDisabled',
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.only(
                top: currentTheme.spaceTokens.paddingInlineTall,
                bottom: currentTheme.spaceTokens.paddingInlineTall,
              ),
              children: [
                for (var entry in tokenGroups.entries) ...[
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: currentTheme.spaceTokens.rowGapTall,
                      horizontal: currentTheme.spaceTokens.paddingInlineTall,
                    ),
                    child: Semantics(
                      header: true,
                      child: Text(
                        entry.key, // cat name
                        style: TextStyle(
                          fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                          fontWeight: currentTheme.fontTokens.weightStrong,
                          letterSpacing: currentTheme.fontTokens.letterSpacingBodyMediumMobile,
                          color: currentTheme.colorsScheme(context).contentDefault,
                        ),
                      ),
                    ),
                  ),
                  ...entry.value.map(
                    (item) => Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: currentTheme.spaceTokens.paddingInlineTall,
                      ),
                      child: ColorWidget(colorTokenItem: item),
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

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.colorTokenItem});

  final ColorTokenItem colorTokenItem;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: currentTheme.spaceTokens.rowGapShort),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colorTokenItem.value,
              border: Border.all(color: currentTheme.colorsScheme(context).actionEnabled),
            ),
          ),
          SizedBox(width: currentTheme.spaceTokens.paddingInlineTall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  colorTokenItem.name,
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: FontWeight.bold,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                    color: currentTheme.colorsScheme(context).contentDefault,
                  ),
                ),
                SizedBox(height: currentTheme.spaceTokens.rowGapNone),
                Text(
                  colorTokenItem.colorToHex(colorTokenItem.value),
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyMediumMobile,
                    fontWeight: currentTheme.fontTokens.weightDefault,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyMediumMobile,
                    color: currentTheme.colorsScheme(context).contentMuted,
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

class ColorTokenItem {
  const ColorTokenItem({required this.name, required this.value});

  final String name;
  final Color value;

  String colorToHex(Color color) {
    // Convert the individual RGBA components (Red, Green, Blue) from double to int
    String hex = '#${(color.r * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Red
        '${(color.g * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Green
        '${(color.b * 255).toInt().toRadixString(16).padLeft(2, '0')}'; // Blue
    return hex.toUpperCase();
  }
}
