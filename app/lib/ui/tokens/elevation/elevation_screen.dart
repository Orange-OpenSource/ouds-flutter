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
import 'package:flutter_gen/gen_l10n/ouds_flutter_app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:provider/provider.dart';

class ElevationScreen extends StatelessWidget {
  const ElevationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;

    List<ElevationTokenItem> elevationTokenItems = [
      ElevationTokenItem(name: 'none', value: currentTheme.elevationTokens.none),
      ElevationTokenItem(name: 'raised', value: currentTheme.elevationTokens.raised),
      ElevationTokenItem(name: 'overlayDefault', value: currentTheme.elevationTokens.overlayDefault),
      ElevationTokenItem(name: 'stickyDefault', value: currentTheme.elevationTokens.stickyDefault),
      ElevationTokenItem(name: 'stickyEmphasized', value: currentTheme.elevationTokens.stickyEmphasized),
      ElevationTokenItem(name: 'stickyNavigationScrolled', value: currentTheme.elevationTokens.stickyNavigationScrolled),
      ElevationTokenItem(name: 'drag', value: currentTheme.elevationTokens.drag),
      ElevationTokenItem(name: 'overlayEmphasized', value: currentTheme.elevationTokens.overlayEmphasized),
    ];

    return Scaffold(
        appBar: MainAppBar(title: AppLocalizations.of(context)!.app_tokens_elevation_label),
        body: SafeArea(
          child: ListView(children: [
            Image(
              image: AssetImage(AdaptiveImageHelper.getImage(context, 'assets/il_elevation.png')),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.app_tokens_elevation_description_text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16.0),
                  ...elevationTokenItems.map((elevationTokenItem) => ElevationWidget(elevationTokenItem: elevationTokenItem))
                ],
              ),
            )
          ]),
        ));
  }
}

class ElevationWidget extends StatelessWidget {
  const ElevationWidget({
    super.key,
    required this.elevationTokenItem,
  });

  final ElevationTokenItem elevationTokenItem;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Material(
            elevation: elevationTokenItem.value,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(
              width: 64,
              height: 64,
              color: currentTheme.colorsScheme.surfaceStatusNeutralMuted,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                elevationTokenItem.name,
                style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: FontWeight.bold,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                    color: currentTheme.colorsScheme.contentDefault),
              ),
              SizedBox(height: currentTheme.spaceTokens.fixedShortest),
              Text(
                "${elevationTokenItem.value.toInt()} dp",
                style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyMediumMobile,
                    fontWeight: currentTheme.fontTokens.weightDefault,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyMediumMobile,
                    color: currentTheme.colorsScheme.contentMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/*
class ElevationTokenWidget extends StatelessWidget {
  const ElevationTokenWidget({
    Key? key,
    required this.elevationTokenItem,
  }) : super(key: key);

  final ElevationTokenItem elevationTokenItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        textStyleItem.name,
        style: textStyleItem.textStyle,
      ),
      subtitle: Text(
        textStyleItem.code,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}

 */

class ElevationTokenItem {
  const ElevationTokenItem({
    required this.name,
    required this.value,
  });

  final String name;
  final double value;
}
