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
import 'package:get/get.dart';
import 'package:ouds_core/components/cards/ouds_cards_common.dart';
import 'package:ouds_core/components/cards/ouds_vertical_image_first_card.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/tokens/token_detail_screen.dart';
import 'package:ouds_flutter_demo/ui/tokens/token_entities.dart';
import 'package:provider/provider.dart';

class TokensScreen extends StatelessWidget {
  final List<Token> oudsTokens;

  const TokensScreen({super.key, required this.oudsTokens});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return SafeArea(
      child: ListView.builder(
        itemCount: oudsTokens.length,
        itemBuilder: (context, index) {
          var token = oudsTokens[index];
          return Padding(
            padding: EdgeInsetsDirectional.symmetric(vertical: themeController.currentTheme.spaceTokens.scaledShortestMobile, horizontal: themeController.currentTheme.spaceTokens.scaledShortMobile),
            child: Column(
              children: [
                OudsVerticalImageFirstCard(
                  title: token.title,
                  image: OudsCardImage(
                    image: token.imageResourceName,
                    contentDescription: '', //Optional
                    alignment: Alignment.center,
                    contentScale: BoxFit.cover,
                  ),
                  onClick: () {
                    if (token.screen != null) {
                      Get.to(
                        token.screen!,
                        transition: Transition.rightToLeft,
                      );
                    } else {
                      Get.to(
                        TokenDetailScreen(
                          token: token,
                        ),
                        transition: Transition.rightToLeft,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
