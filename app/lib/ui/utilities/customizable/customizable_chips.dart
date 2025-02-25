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
import 'package:ouds_core/components/chips/ouds_choice_chips.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class CustomizableChips<T> extends StatelessWidget {
  final String? title;
  final List<T> options;
  final T selectedOption;
  final String Function(T) getText;
  final void Function(T) onSelected;

  const CustomizableChips({
    super.key,
    this.title,
    required this.options,
    required this.selectedOption,
    required this.getText,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themeController =
        Provider.of<ThemeController>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          SizedBox(
              height:
                  themeController.currentTheme.spaceTokens.scaledShorterMobile),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(
                  themeController.currentTheme.spaceTokens.scaledMediumMobile),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: themeController
                      .currentTheme.fontTokens.sizeBodyLargeMobile,
                  fontWeight:
                      themeController.currentTheme.fontTokens.weightLabelStrong,
                  letterSpacing: themeController
                      .currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                ),
              ),
            ),
          ),
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(
                options.length,
                (int index) {
                  T currentElement = options[index];
                  bool isSelected = currentElement == selectedOption;
                  return Padding(
                    padding: EdgeInsets.only(
                      right: themeController
                          .currentTheme.spaceTokens.scaledShortestMobile,
                      left: themeController
                          .currentTheme.spaceTokens.scaledShorterMobile,
                    ),
                    child: OudsChoiceChip(
                      text: getText(currentElement),
                      selected: isSelected,
                      onClick: (selected) {
                        onSelected(currentElement);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
