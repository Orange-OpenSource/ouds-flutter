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
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/utilities/navigation_items.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  NavigationItems get _navigationItems => NavigationItems(context);

  @override
  Widget build(BuildContext context) {
    var selectedItem = _navigationItems.getSelectedMenuItem(_selectedIndex);

    return Scaffold(
      appBar: MainAppBar(title: selectedItem.label),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640) _buildNavigationRail(),
          Expanded(
            child: _navigationItems.getScreens(_selectedIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return MediaQuery.of(context).size.width < 640
        ? NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: _navigationItems.getBottomNavigationBarItems(),
          )
        : const SizedBox.shrink();
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: _navigationItems.getNavigationRailDestinations(),
    );
  }
}
