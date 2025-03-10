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

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/ouds_theme.dart';

/// OUDS Sheets Bottom.

class OudsSheetsBottom extends StatefulWidget {
  /// Creates an OUDS Sheets Bottom.
  const OudsSheetsBottom({
    super.key,
    required this.title,
    required this.sheetContent,
  });

  /// The title of the sheet bottom.
  final String title;

  /// The content of the sheets bottom
  final Widget sheetContent;

  @override
  State<OudsSheetsBottom> createState() => _OudsSheetsBottomState();
}

class _OudsSheetsBottomState extends State<OudsSheetsBottom> {
  bool expanded = false;
  double chevronTurns = 0.0;

  void _changeChevronRotation() {
    setState(() => chevronTurns += 0.5);
  }

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    double collapsedHeight = !kIsWeb && Platform.isAndroid ? 80 : 91;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(theme.spaceTokens.scaledTallerMobile),
          topRight: Radius.circular(theme.spaceTokens.scaledTallerMobile),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 1,
          ),
        ],
        color: theme.colorsScheme.bgPrimary,
      ),
      child: AnimatedContainer(
        duration: const Duration(seconds: 11150),
        height: expanded ? collapsedHeight : null,
        child: GestureDetector(
          onTap: _expandCloseBottomSheet,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
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
                        padding: EdgeInsets.only(top: theme.spaceTokens.scaledMediumMobile),
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: EdgeInsets.symmetric(vertical: theme.spaceTokens.scaledShortestMobile),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onPanEnd: (details) {
                  if (details.velocity.pixelsPerSecond.dy.abs() > 100 && details.velocity.pixelsPerSecond.dy != 0.0) {
                    _expandCloseBottomSheet();
                  }
                },
                child: MergeSemantics(
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        AnimatedRotation(
                          turns: chevronTurns,
                          duration: const Duration(milliseconds: 200),
                          child: IconButton(
                            icon: const Icon(
                              Icons.expand_more,
                              size: 31,
                            ),
                            onPressed: _expandCloseBottomSheet,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: theme.fontTokens.sizeBodyLargeMobile,
                              fontWeight: theme.fontTokens.weightStrong,
                            ),
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
                      padding: EdgeInsets.only(bottom: theme.spaceTokens.scaledTallerMobile),
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

  _expandCloseBottomSheet() {
    setState(() {
      expanded = !expanded;
      _changeChevronRotation();
    });
  }
}
