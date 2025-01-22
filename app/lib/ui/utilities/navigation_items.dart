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
import 'package:flutter_gen/gen_l10n/ouds_flutter_app_localizations.dart';
import 'package:ouds_flutter/core/components/navigation_bar/ouds_navigation_bar_item.dart';
import 'package:ouds_flutter/core/components/navigation_rail/ouds_navigation_rail_item.dart';
import 'package:ouds_flutter_demo/ui/about/about_screen.dart';
import 'package:ouds_flutter_demo/ui/components/components_screen.dart';
import 'package:ouds_flutter_demo/ui/tokens/token_screen.dart';

class NavigationItems {
  late BuildContext context;
  late List<OudsNavigationItem> _destinationsStatic;
  late List<OudsNavigationRailItem> _destinationsRailStatic;
  late List<Widget> _screens;

  NavigationItems(this.context) {
    _destinationsStatic = [
      OudsNavigationItem(
        context: context,
        label: AppLocalizations.of(context)!.app_bottomBar_tokens_label,
        icon: "assets/ic_token.svg",
      ),
      OudsNavigationItem(
        context: context,
        label: AppLocalizations.of(context)!.app_bottomBar_components_label,
        icon: "assets/ic_atom.svg",
      ),
      OudsNavigationItem(
        context: context,
        label: AppLocalizations.of(context)!.app_bottomBar_about_label,
        icon: "assets/ic_about.svg",
      ),
    ];

    _destinationsRailStatic = [
      OudsNavigationRailItem(
        context: context,
        label: AppLocalizations.of(context)!.app_bottomBar_tokens_label,
        icon: "assets/ic_token.svg",
      ),
      OudsNavigationRailItem(
        context: context,
        label: AppLocalizations.of(context)!.app_bottomBar_components_label,
        icon: "assets/ic_atom.svg",
      ),
      OudsNavigationRailItem(
        context: context,
        label: AppLocalizations.of(context)!.app_bottomBar_about_label,
        icon: "assets/ic_about.svg",
      ),
    ];
    _screens = [
      const TokensScreen(),
      const ComponentsScreen(),
      const AboutScreen()
    ];
  }

  getSelectedMenuItem(int index) {
    return _destinationsStatic[index];
  }

  getBottomNavigationBarItems() {
    return _destinationsStatic;
  }

  getNavigationRailDestinations() {
    return _destinationsRailStatic;
  }

  getScreens(int index) {
    return _screens[index];
  }
}
