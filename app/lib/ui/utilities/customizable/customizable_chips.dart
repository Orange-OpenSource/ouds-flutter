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
import 'package:ouds_core/components/chip/ouds_filter_chip.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
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
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return Semantics(
      label: context.l10n.app_common_customizeChips_label_a11y,
      hint: context.l10n.app_common_customizeChips_hint_a11y,
      value: title!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: themeController.currentTheme.spaceScheme(context).scaledMedium,
                  end: themeController.currentTheme.spaceScheme(context).scaledMedium,
                  bottom: themeController.currentTheme.spaceScheme(context).scaledSmall,
                  top: themeController.currentTheme.spaceScheme(context).scaledSmall),
              child: ExcludeSemantics(
                child: Text(
                  title!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: themeController.currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: themeController.currentTheme.fontTokens.weightLabelStrong,
                    letterSpacing: themeController.currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(
                  options.length,
                  (int index) {
                    T currentElement = options[index];
                    bool isSelected = currentElement == selectedOption;
                    return Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: themeController.currentTheme.spaceScheme(context).fixedThreeExtraSmall,
                        end: themeController.currentTheme.spaceScheme(context).fixedThreeExtraSmall,
                      ),
                      child: OudsFilterChip(
                        label: getText(currentElement), // Use getText to get the label
                        selected: isSelected,
                        onSelected: (bool selected) {
                          if (selected) {
                            onSelected(currentElement); // Call the onSelected callback
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
