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
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:ouds_flutter_demo/ui/utilities/display_image.dart';
import 'package:provider/provider.dart';

class ComponentVariantsScreen extends StatelessWidget {
  final Component component;

  const ComponentVariantsScreen({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;

    return Scaffold(
      appBar: MainAppBar(
        title: component.title,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              displayImage(
                AdaptiveImageHelper.getImage(context, component.imageResourceName),
                MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsetsDirectional.all(currentTheme.spaceScheme(context).insetTall),
                child: Text(
                  component.description,
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: currentTheme.fontTokens.weightDefault,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                    height: 1.5,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: component.variants?.length,
                itemBuilder: (BuildContext context, int index) {
                  if (component.variants != null && index < component.variants!.length) {
                    return VariantEntry(
                      variant: component.variants![index],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VariantEntry extends StatelessWidget {
  final VariantComponent variant;

  const VariantEntry({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;

    return Semantics(
      button: true,
      onTap: () {
        Get.to(variant.screen);
      },
      child: ListTile(
        title: Text(
          variant.title,
          style: TextStyle(
            fontSize: currentTheme.fontTokens.sizeHeadingMediumMobile,
            fontWeight: currentTheme.fontTokens.weightHeading,
          ),
        ),
        onTap: () {
          Get.to(variant.screen);
        },
      ),
    );
  }
}
