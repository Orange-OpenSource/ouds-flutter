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
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
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

    return ListView.builder(
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
                      arguments: {'previousTitle': context.l10n.app_bottomBar_components_label},
                      transition: Transition.rightToLeft,
                    );
                  } else {
                    Get.to(
                      ComponentVariantsScreen(
                        component: component,
                      ),
                      arguments: {'previousTitle': context.l10n.app_bottomBar_components_label},
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
