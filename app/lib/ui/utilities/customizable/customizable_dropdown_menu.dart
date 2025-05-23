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
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

class CustomizationDropdownMenu<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final int selectedItemIndex;
  final String Function(T) getText;
  final Function(T, int) onSelectionChange;
  final List<Widget Function()>? itemLeadingIcons;
  final T? selectedOption;
  final bool isSelected;

  const CustomizationDropdownMenu({
    super.key,
    required this.label,
    required this.options,
    required this.selectedItemIndex,
    required this.onSelectionChange,
    required this.selectedOption,
    this.itemLeadingIcons,
    required this.getText,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: currentTheme.spaceScheme(context).fixedMedium),
          child: Text(
            label,
            style: TextStyle(
              fontSize: themeController.currentTheme.fontTokens.sizeBodyLargeMobile,
              fontWeight: themeController.currentTheme.fontTokens.weightLabelStrong,
              letterSpacing: themeController.currentTheme.fontTokens.letterSpacingBodyLargeMobile,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: currentTheme.spaceScheme(context).fixedMedium, vertical: currentTheme.spaceScheme(context).fixedShorter),
          child: DropdownMenu<T>(
            initialSelection: options[selectedItemIndex],
            expandedInsets: EdgeInsets.zero,
            inputDecorationTheme: const InputDecorationTheme(isDense: true),
            textStyle: TextStyle(
              fontSize: OudsTheme.of(context).fontTokens.sizeBodyLargeMobile,
              fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
              letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingBodyLargeMobile,
            ),
            onSelected: (value) {
              if (value != null) {
                final newIndex = options.indexOf(value);
                onSelectionChange(value, newIndex);
              }
            },
            leadingIcon: itemLeadingIcons != null ? buildDropdownLeadingIcon(context, itemLeadingIcons, selectedItemIndex) : null,
            dropdownMenuEntries: List.generate(options.length, (index) {
              return DropdownMenuEntry<T>(
                labelWidget: Text(getText(options[index]),
                    style: TextStyle(
                      fontSize: OudsTheme.of(context).fontTokens.sizeBodyLargeMobile,
                      fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
                      letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingBodyLargeMobile,
                    )),
                value: options[index],
                label: getText(options[index]),
                leadingIcon: itemLeadingIcons != null ? buildDropdownLeadingIcon(context, itemLeadingIcons, index) : null,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget? buildDropdownLeadingIcon(BuildContext context, List<Widget Function()>? builders, int index) {
    if (builders != null && index < builders.length) {
      return Padding(padding: EdgeInsetsDirectional.all(OudsTheme.of(context).spaceScheme(context).paddingInlineShort), child: builders[index]());
    }
    return null;
  }
}
