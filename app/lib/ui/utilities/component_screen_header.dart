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
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_global_raw_tokens/dimension_raw_tokens.dart';
import 'package:provider/provider.dart';

class ComponentScreenHeader extends StatelessWidget {
  final String description;
  final Widget? widget;

  const ComponentScreenHeader({
    super.key,
    required this.description,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        // Adds extra space at the bottom to prevent content from being obscured by the custom bottom sheet in landscape mode.
        padding: EdgeInsetsDirectional.only(bottom: DimensionRawTokens.dimension1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.all(themeController.currentTheme.spaceTokens.insetTall),
              child: Text(
                description,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: themeController.currentTheme.spaceTokens.fixedTall),
            if (widget != null) widget!,
          ],
        ),
      ),
    );
  }
}
