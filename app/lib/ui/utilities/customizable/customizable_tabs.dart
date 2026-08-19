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
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A customizable tabs component for demo screens.
/// Replaces section headers with tabbed navigation between sections.
class CustomizableTabs extends StatefulWidget {
  /// List of tab labels.
  final List<String> tabs;

  /// List of tab contents corresponding to each tab.
  final List<Widget> children;

  const CustomizableTabs({
    super.key,
    required this.tabs,
    required this.children,
  });

  @override
  State<CustomizableTabs> createState() => _CustomizableTabsState();
}

class _CustomizableTabsState extends State<CustomizableTabs> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    final colorScheme = theme.colorScheme(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: colorScheme.bgPrimary,
          child: Row(
            children: List.generate(widget.tabs.length, (index) {
              final isSelected = index == _selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected
                              ? colorScheme.contentBrandPrimary
                              : colorScheme.borderDefault,
                          width: isSelected ? 2.0 : 1.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: Text(
                      widget.tabs[index],
                      style: TextStyle(
                        color: isSelected
                            ? colorScheme.contentDefault
                            : colorScheme.contentMuted,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: widget.children[_selectedIndex],
          ),
        ),
      ],
    );
  }
}
