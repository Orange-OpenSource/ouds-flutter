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

class CustomizableSection extends StatelessWidget {
  final List<Widget> children;

  const CustomizableSection({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return Column(
      children: [
        SizedBox(height: themeController.currentTheme.spaceScheme(context).scaledShorter),
        ...children,
      ],
    );
  }
}
