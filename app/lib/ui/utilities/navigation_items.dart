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
import 'package:ouds_flutter_demo/ui/about/about_screen.dart';
import 'package:ouds_flutter_demo/ui/components/components_screen.dart';
import 'package:ouds_flutter_demo/ui/tokens/token_screen.dart';

class NavigationItems {
  late BuildContext context;
  late List<NavigationDestination> _destinationsStatic;
  late List<NavigationRailDestination> _destinationsRailStatic;
  late List<Widget> _screens;

  NavigationItems(this.context) {
    _destinationsStatic = [
      NavigationDestination(
        label: AppLocalizations.of(context)!.app_bottomBar_tokens_label,
        icon: _buildSvgIcon('assets/ic_token.svg'),
      ),
      NavigationDestination(
        label: AppLocalizations.of(context)!.app_bottomBar_components_label,
        icon: _buildSvgIcon('assets/ic_atom.svg'),
      ),
      NavigationDestination(
        label: AppLocalizations.of(context)!.app_bottomBar_about_label,
        icon: _buildSvgIcon('assets/ic_about.svg'),
      ),
    ];

    _destinationsRailStatic = [
      NavigationRailDestination(
        label: Text(AppLocalizations.of(context)!.app_bottomBar_tokens_label),
        icon: _buildSvgIcon('assets/ic_token.svg'),
      ),
      NavigationRailDestination(
        label:
            Text(AppLocalizations.of(context)!.app_bottomBar_components_label),
        icon: _buildSvgIcon('assets/ic_atom.svg'),
      ),
      NavigationRailDestination(
        label: Text(AppLocalizations.of(context)!.app_bottomBar_about_label),
        icon: _buildSvgIcon('assets/ic_about.svg'),
      ),
    ];
    _screens = [
      const TokensScreen(),
      const ComponentsScreen(),
      const AboutScreen()
    ];
  }

  Widget _buildSvgIcon(String assetPath) {
    return Builder(
      builder: (BuildContext context) {
        var colorScheme = Theme.of(context).colorScheme;
        return SvgPicture.asset(
          assetPath,
          width: 28.0,
          height: 28.0,
          colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
        );
      },
    );
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
