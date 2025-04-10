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
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:provider/provider.dart';

import 'theme_color_tokens.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  _ColorScreenState createState() => _ColorScreenState();

}

class _ColorScreenState extends State<ColorScreen> {
  final ScrollController _scrollController = ScrollController();
  int? _currentPinnedHeader; // Track which header is pinned

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Récupérer la position actuelle du défilement
    final double scrollOffset = _scrollController.offset;

    // Liste des hauteurs des headers (chaque header a une hauteur fixe de 50 dans votre cas)
    final double headerHeight = 50.0;

    // Calculer l'index de l'en-tête actuellement visible en haut de l'écran
    int currentHeaderIndex = (scrollOffset / headerHeight).floor();

    // Vérifier si l'en-tête visible a changé, sinon ne rien faire
    if (_currentPinnedHeader != currentHeaderIndex) {
      setState(() {
        _currentPinnedHeader =
            currentHeaderIndex; // Mettre à jour l'index de l'en-tête épinglé
      });
    }
  }


  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
        context, listen: false);
    final currentTheme = themeController.currentTheme;
    final tokenGroups = ThemeColorTokens.fromTheme(currentTheme).all;

    return Scaffold(
      appBar: MainAppBar(title: context.l10n.app_tokens_color_label),
      body: SafeArea(
        child: ListView(
          children: [
            Image(
              image: AssetImage(AdaptiveImageHelper.getImage(context, 'assets/il_color.png')),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.all(currentTheme.spaceTokens.paddingInlineTall),
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
              code: 'OudsTheme.of(context).colorSchema.disabled',
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: currentTheme.spaceTokens.paddingInlineTall,
                bottom: currentTheme.spaceTokens.paddingInlineTall,
              ),
              children: [
                for (var entry in tokenGroups.entries) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: currentTheme.spaceTokens.rowGapShort,
                      horizontal: currentTheme.spaceTokens.paddingInlineTall,
                    ),
                    child: Text(
                      entry.key, // cat name
                      style: TextStyle(
                        fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                        fontWeight: currentTheme.fontTokens.weightStrong,
                        letterSpacing: currentTheme.fontTokens.letterSpacingBodyMediumMobile,
                        color: currentTheme.colorsScheme.contentDefault,
                      ),
                    ),
                  ),
                  ...entry.value.map(
                        (item) => Padding(
                      padding: EdgeInsets.symmetric(
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
      padding: EdgeInsets.symmetric(vertical: currentTheme.spaceTokens.rowGapShort),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colorTokenItem.value, // Couleur de fond
                border: Border.all(
                  color: Colors.black
                ),
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
                    color: currentTheme.colorsScheme.contentDefault,
                  ),
                ),
                SizedBox(height: currentTheme.spaceTokens.rowGapNone),
                Text(
                  colorTokenItem.colorToHex(colorTokenItem.value),
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyMediumMobile,
                    fontWeight: currentTheme.fontTokens.weightDefault,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyMediumMobile,
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

class ColorTokenItem {
  const ColorTokenItem({required this.name, required this.value});

  final String name;
  final Color value;

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }
}