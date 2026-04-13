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
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/constants_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// OUDS Sheets Bottom.

class OudsSheetsBottom extends StatefulWidget {
  /// Creates an OUDS Sheets Bottom.
  const OudsSheetsBottom({
    super.key,
    required this.title,
    required this.sheetContent,
    this.onExpansionChanged,
  });

  /// The title of the sheet bottom.
  final String title;

  /// The content of the sheets bottom
  final Widget sheetContent;

  final Function(bool)? onExpansionChanged;

  @override
  State<OudsSheetsBottom> createState() => OudsSheetsBottomState();
}

class OudsSheetsBottomState extends State<OudsSheetsBottom> {
  bool expanded = true;


  void _changeChevronRotation() {
    setState(() => ConstantSheetBottom.chevronTurns += ConstantSheetBottom.chevronTurns);
  }

  void _expandCloseBottomSheet() {
    setState(() {
      expanded = !expanded;
      _changeChevronRotation();
    });

    // Call the callback to notify the updated state
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(expanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);

    return Semantics(
      label: OudsLocalizations.of(context)?.core_bottom_sheets_label_a11y,
      value: expanded ? OudsLocalizations.of(context)?.core_bottom_sheets_collapsed_a11y : OudsLocalizations.of(context)?.core_bottom_sheets_expanded_a11y,
      hint: OudsLocalizations.of(context)?.core_bottom_sheets_hint_a11y,
      child: Container(
                decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(theme.spaceScheme(context).scaledExtraLarge),
            topRight: Radius.circular(theme.spaceScheme(context).scaledExtraLarge),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.5 * 255).round()),
              blurRadius: 1,
            ),
          ],
          color: theme.colorScheme(context).bgPrimary,
        ),
        child: AnimatedContainer(
          duration: Duration(seconds: ConstantSheetBottom.animatedContainerDuration),
          height: !expanded ? ConstantSheetBottom.collapsedHeight : null,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _expandCloseBottomSheet,
                onPanEnd: (details) {
                  if (details.velocity.pixelsPerSecond.dy.abs() > 100 && details.velocity.pixelsPerSecond.dy != 0.0) {
                    _expandCloseBottomSheet();
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: theme.spaceScheme(context).scaledMedium),
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: EdgeInsetsDirectional.symmetric(vertical: theme.spaceScheme(context).scaledTwoExtraSmall),
                          decoration: BoxDecoration(
                            color: theme.colorScheme(context).contentDefault,
                            borderRadius: BorderRadius.circular(ConstantSheetBottom.sheetRadius),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ExcludeSemantics(
                child: GestureDetector(
                  onTap: _expandCloseBottomSheet,
                  onPanEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dy.abs() > 100 && details.velocity.pixelsPerSecond.dy != 0.0) {
                      _expandCloseBottomSheet();
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        AnimatedRotation(
                          turns: ConstantSheetBottom.chevronTurns,
                          duration: Duration(milliseconds: ConstantSheetBottom.animatedRotationDuration),
                          child: IconButton(
                            icon: Icon(
                              Icons.expand_more,
                              size: ConstantSheetBottom.expandIconSize,
                            ),
                            onPressed: _expandCloseBottomSheet,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: theme.typographyTokens.typeBodyStrongLarge(context),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!expanded)
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(bottom: theme.spaceScheme(context).scaledExtraLarge),
                      child: widget.sheetContent,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
