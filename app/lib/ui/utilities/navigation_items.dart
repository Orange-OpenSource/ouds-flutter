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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_flutter/ui/about/about_screen.dart';
import 'package:ouds_flutter/ui/components/components_screen.dart';
import 'package:ouds_flutter/ui/tokens/token_screen.dart';

class NavigationItems {
  late BuildContext context;
  late List<NavigationDestination> _destinationsStatic;
  late List<NavigationRailDestination> _destinationsRailStatic;
  late List<Widget> _screens;

  NavigationItems(this.context) {
    _destinationsStatic = [
      NavigationDestination(
        label: AppLocalizations.of(context)!.app_bottomBar_tokens_label,
        icon: SvgPicture.asset(
          'assets/ic_token.svg',
          width: 28.0,
          height: 28.0,
        ),
      ),
      NavigationDestination(
        label: AppLocalizations.of(context)!.app_bottomBar_components_label,
        icon: SvgPicture.asset(
          'assets/ic_atom.svg',
          width: 28.0,
          height: 28.0,
        ),
      ),
      NavigationDestination(
        label: AppLocalizations.of(context)!.app_bottomBar_about_label,
        icon: SvgPicture.asset(
          'assets/ic_about.svg',
          width: 28.0,
          height: 28.0,
        ),
      ),
    ];

    _destinationsRailStatic = [
      NavigationRailDestination(
        label: Text(AppLocalizations.of(context)!.app_bottomBar_tokens_label),
        icon: SvgPicture.asset(
          'assets/ic_token.svg',
          width: 28.0,
          height: 28.0,
        ),
      ),
      NavigationRailDestination(
        label:
            Text(AppLocalizations.of(context)!.app_bottomBar_components_label),
        icon: SvgPicture.asset(
          'assets/ic_atom.svg',
          width: 28.0,
          height: 28.0,
        ),
      ),
      NavigationRailDestination(
        label: Text(AppLocalizations.of(context)!.app_bottomBar_about_label),
        icon: SvgPicture.asset(
          'assets/ic_about.svg',
          width: 28.0,
          height: 28.0,
        ),
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
