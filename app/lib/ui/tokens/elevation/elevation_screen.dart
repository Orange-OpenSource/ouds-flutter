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

class ElevationScreen extends StatelessWidget {
  final String illustration;
  const ElevationScreen({super.key, required this.illustration});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    final elevationTokenItems = _getElevationTokenItems(currentTheme);

    return Scaffold(
      appBar: MainAppBar(title: context.l10n.app_tokens_elevation_label),
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
                    context.l10n.app_tokens_elevation_description_text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Code(
              titleText: context.l10n.app_tokens_viewCodeExample_label,
              code: 'OudsTheme.of(context).elevationTokens.overlayDefault',
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(currentTheme.spaceTokens.paddingInlineTall),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: elevationTokenItems.length,
                itemBuilder: (context, index) {
                  return ElevationWidget(elevationTokenItem: elevationTokenItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ElevationTokenItem> _getElevationTokenItems(OudsThemeContract currentTheme) {
    return [
      ElevationTokenItem(name: 'none', value: currentTheme.elevationTokens.none),
      ElevationTokenItem(name: 'raised', value: currentTheme.elevationTokens.raised),
      ElevationTokenItem(name: 'overlayDefault', value: currentTheme.elevationTokens.overlayDefault),
      ElevationTokenItem(name: 'stickyDefault', value: currentTheme.elevationTokens.stickyDefault),
      ElevationTokenItem(name: 'stickyEmphasized', value: currentTheme.elevationTokens.stickyEmphasized),
      ElevationTokenItem(name: 'stickyNavigationScrolled', value: currentTheme.elevationTokens.stickyNavigationScrolled),
      ElevationTokenItem(name: 'drag', value: currentTheme.elevationTokens.drag),
      ElevationTokenItem(name: 'overlayEmphasized', value: currentTheme.elevationTokens.overlayEmphasized),
    ];
  }
}

class ElevationWidget extends StatelessWidget {
  const ElevationWidget({super.key, required this.elevationTokenItem});

  final ElevationTokenItem elevationTokenItem;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: currentTheme.spaceTokens.rowGapShort),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: elevationTokenItem.value,
            child: Container(
              width: 64,
              height: 64,
              color: currentTheme.colorScheme(context).surfaceStatusNeutralMuted,
            ),
          ),
          SizedBox(width: currentTheme.spaceTokens.paddingInlineTall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  elevationTokenItem.name,
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: FontWeight.bold,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                    color: currentTheme.colorScheme(context).contentDefault,
                  ),
                ),
                SizedBox(height: currentTheme.spaceTokens.rowGapNone),
                Text(
                  "${elevationTokenItem.value.toInt()} dp",
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyMediumMobile,
                    fontWeight: currentTheme.fontTokens.weightDefault,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyMediumMobile,
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

class ElevationTokenItem {
  const ElevationTokenItem({required this.name, required this.value});

  final String name;
  final double value;
}
