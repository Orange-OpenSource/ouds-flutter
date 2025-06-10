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
  final String? description;
  final Widget? widget;

  const DetailScreenDescription({
    super.key,
    this.description,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (description != null)
              Padding(
                padding: EdgeInsetsDirectional.all(themeController.currentTheme.spaceScheme(context).insetTall),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    description!,
                    style: TextStyle(
                      fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                      fontWeight: currentTheme.fontTokens.weightDefault,
                      letterSpacing: currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            SizedBox(height: themeController.currentTheme.spaceScheme(context).fixedTall),
            if (widget != null) widget!,
          ],
        ),
      ),
    );
  }
}
