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
import 'package:provider/provider.dart';

class ComponentVariantsScreen extends StatelessWidget {
  final Component component;
  final String? previousPageTitle;

  const ComponentVariantsScreen({super.key, required this.component, this.previousPageTitle});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        showBackButton: true,
        title: component.title,
        previousPageTitle: previousPageTitle,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: component.customComponent,
              ),
              Padding(
                padding: EdgeInsetsDirectional.all(currentTheme.spaceScheme(context).insetMedium),
                child: Text(
                  component.description,
                  style: currentTheme.typographyTokens.typeBodyDefaultLarge(context),
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
                      previousPageTitle: component.title,
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
  final String? previousPageTitle;

  const VariantEntry({super.key, required this.variant, this.previousPageTitle});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;

    return Semantics(
      button: true,
      child: ListTile(
        title: Text(
          variant.title,
          style: currentTheme.typographyTokens.typeHeadingMedium(context),
        ),
        onTap: () {
          Get.to(variant.screen);
        },
      ),
    );
  }
}