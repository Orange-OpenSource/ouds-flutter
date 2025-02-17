//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/cards/ouds_cards_common.dart';
import 'package:ouds_core/components/cards/ouds_vertical_image_first_card.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class ComponentsScreen extends StatelessWidget {
  final List<Component> oudsComponents;

  const ComponentsScreen({super.key, required this.oudsComponents});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return SafeArea(
      child: ListView.builder(
        itemCount: oudsComponents.length,
        itemBuilder: (context, index) {
          var component = oudsComponents[index];
          return Padding(
            padding: EdgeInsets.all(themeController.currentTheme.spaceTokens.scaledShortMobile),
            child: Column(
              children: [
                OudsVerticalImageFirstCard(
                  title: component.title,
                  image: OudsCardImage(
                    image: component.imageResourceName,
                    contentDescription: '', //Optional
                    alignment: Alignment.center,
                    contentScale: BoxFit.cover,
                  ),
                  onClick: () {
                    Get.to(
                      component.screen,
                      transition: Transition.rightToLeft,
                    );
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
