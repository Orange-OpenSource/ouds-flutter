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
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/about/about_screen.dart';
import 'package:ouds_flutter_demo/ui/components/components.dart';
import 'package:ouds_flutter_demo/ui/components/components_screen.dart';
import 'package:ouds_flutter_demo/ui/navigation/navigation_bar/ouds_navigation_bar_item.dart';
import 'package:ouds_flutter_demo/ui/tokens/token_screen.dart';
import 'package:ouds_flutter_demo/ui/tokens/tokens.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

class NavigationItems {
  late BuildContext context;
  late List<OudsNavigationItem> _destinationsStatic;
  late List<Widget> _screens;

  NavigationItems(this.context) {
    _destinationsStatic = [
      OudsNavigationItem(
        context: context,
        label: context.l10n.app_bottomBar_tokens_label,
        icon: AppAssets.icons.icToken,
      ),
      OudsNavigationItem(
        context: context,
        label: context.l10n.app_bottomBar_components_label,
        icon: AppAssets.icons.icAtom,
      ),
      OudsNavigationItem(
        context: context,
        label: context.l10n.app_bottomBar_about_label,
        icon: AppAssets.icons.icAbout,
      ),
    ];

    _screens = [
      TokensScreen(
        oudsTokens: tokens(context),
      ),
      ComponentsScreen(
        oudsComponents: components(context),
      ),
      const AboutScreen()
    ];
  }

  getSelectedMenuItem(int index) {
    return _destinationsStatic[index];
  }

  getBottomNavigationBarItems() {
    return _destinationsStatic;
  }

  getScreens(int index) {
    return _screens[index];
  }
}
