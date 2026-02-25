/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_selector.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const MainAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return  OudsTopBar(
      centerTitle: false,
      title: title,
      translucent: true,
      leadingActions: [
        OudsTopBarActionConfig(
            type: showBackButton
                ? OudsTopBarActionType.back
                : OudsTopBarActionType.none,
            onActionPressed: showBackButton ? (){
              Navigator.pop(context);
            } : null
        )
      ],
      trailingActions: [
        OudsTopBarActionConfig(
          type: OudsTopBarActionType.widget,
          widget: ThemeSelector(),
          onActionPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}