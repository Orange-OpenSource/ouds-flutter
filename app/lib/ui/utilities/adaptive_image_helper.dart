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

import 'package:flutter/widgets.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class AdaptiveImageHelper {
  static String getImage(BuildContext context, String imagePath) {
    final themeController =
        Provider.of<ThemeController>(context, listen: false);

    if (themeController.isDarkTheme) {
      final fileExtension = imagePath.substring(imagePath.lastIndexOf('.'));
      final baseName = imagePath.substring(0, imagePath.lastIndexOf('.'));
      return '${baseName}_dark$fileExtension';
    }
    return imagePath;
  }
}
