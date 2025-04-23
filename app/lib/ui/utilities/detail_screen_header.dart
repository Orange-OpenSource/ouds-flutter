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
import 'package:provider/provider.dart';

class DetailScreenDescription extends StatelessWidget {
  final String description;
  final Widget? widget;

  const DetailScreenDescription({
    super.key,
    required this.description,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(themeController.currentTheme.spaceTokens.insetTall),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(description),
              )
            ),
            SizedBox(height: themeController.currentTheme.spaceTokens.fixedTall),
            if (widget != null) widget!,
          ],
        ),
      ),
    );
  }
}
