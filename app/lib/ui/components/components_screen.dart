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
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/components/component_variants_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/cards/ouds_illustration_component_card.dart';
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
            padding: EdgeInsetsDirectional.symmetric(
                vertical: themeController.currentTheme.spaceScheme(context).scaledExtraSmall, horizontal: themeController.currentTheme.spaceScheme(context).scaledSmall),
            child: Column(
              children: [
                OudsIllustrationComponentCard(
                  title: component.title,
                  customComponent: component.customComponent,
                  onClick: () {
                    if (component.variants == null) {
                      Get.to(
                        component.screen,
                        transition: Transition.rightToLeft,
                      );
                    } else {
                      Get.to(
                        ComponentVariantsScreen(
                          component: component,
                        ),
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
/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

import 'component_variants_screen.dart';

class ComponentsScreen extends StatelessWidget {
  final List<Component> oudsComponents;

  const ComponentsScreen({super.key, required this.oudsComponents});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final theme = OudsTheme.of(context);
    return SafeArea(
      child: ListView.builder(
        itemCount: oudsComponents.length,
        itemBuilder: (context, index) {
          var component = oudsComponents[index];
          return Padding(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: themeController.currentTheme.spaceScheme(context).scaledExtraSmall, horizontal: themeController.currentTheme.spaceScheme(context).scaledSmall),
            child: Column(
              children: [
                Card.outlined(
                  elevation: 1,
                  color: theme.colorScheme(context).overlayDefault,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  child: Semantics(
                    button: true,
                    child: InkWell(
                      onTap: () {
                        if (component.variants == null) {
                          Get.to(
                            component.screen,
                            transition: Transition.rightToLeft,
                          );
                        } else {
                          Get.to(
                            ComponentVariantsScreen(
                              component: component,
                            ),
                          );
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExcludeSemantics(
                            //child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 180,
                              ),
                              child: Container(
                                color: theme.colorScheme(context).surfaceStatusNeutralMuted,
                                child: Align(
                                  //alignment: Alignment.center, // ou .topLeft, etc.
                                  child: IgnorePointer(
                                    child: Column(
                                      children: [
                                        OudsButton(
                                          label: "Label",
                                          style: OudsButtonStyle.defaultStyle,
                                          hierarchy: OudsButtonHierarchy.defaultHierarchy,
                                          onPressed: () {},
                                        ),
                                        SizedBox(height: 20),
                                        OudsButton(
                                          label: "Label",
                                          style: OudsButtonStyle.defaultStyle,
                                          hierarchy: OudsButtonHierarchy.strong,
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0, vertical: 15.0),
                            child: Text(
                              component.title,
                              style: TextStyle(
                                fontSize: theme.fontTokens.sizeHeadingMediumMobile,
                                letterSpacing: theme.fontTokens.letterSpacingHeadingMediumMobile,
                                fontWeight: theme.fontTokens.weightLabelStrong,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
*/
