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
import 'package:flutter/services.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

/// A widget that displays a code snippet with an optional title.
/// The widget allows the user to toggle the visibility of the code section.
/// If the title text is provided, it shows a collapsible section with the title and an expand/collapse icon.
/// If the title text is empty or null, only the code snippet is displayed without the toggle section.
///
/// - [code]: The code snippet that will be displayed.
/// - [titleText]: An optional title text to be displayed above the code section. If null or empty, the code section is displayed without the title.
///
/// The widget utilizes `ThemeController` to apply consistent styling based on the current theme, including spacing, font styles, and colors.
/// It also supports copying the code to the clipboard via a button.

class Code extends StatefulWidget {
  final String code;
  final String? titleText; // Make titleText nullable

  const Code({
    super.key,
    required this.code,
    this.titleText, // titleText is now optional
  });

  @override
  CodeState createState() => CodeState();
}

class CodeState extends State<Code> {
  bool isCodeVisible = false;

  @override
  void initState() {
    super.initState();
    // If titleText is empty or null, we directly display the code
    isCodeVisible = widget.titleText?.isNotEmpty ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText?.isNotEmpty ?? false) _toggleButtonSection(theme),
        if (isCodeVisible) _codeTokenDisplayCodeSection(theme),
      ],
    );
  }

  Widget _toggleButtonSection(ThemeController theme) {
    return Padding(
      padding: EdgeInsets.only(left: theme.currentTheme.spaceTokens.paddingBlockTall, top: theme.currentTheme.spaceTokens.paddingBlockTall),
      child: GestureDetector(
        onTap: _toggle,
        child: Row(
          children: [
            Text(
              widget.titleText!, // This is safe now because we check for null
              style: TextStyle(
                fontSize: theme.currentTheme.fontTokens.sizeBodyLargeMobile,
                letterSpacing: theme.currentTheme.fontTokens.letterSpacingBodyMediumMobile,
                fontWeight: theme.currentTheme.fontTokens.weightStrong,
              ),
            ),
            const SizedBox(width: 5.0),
            Icon(
              isCodeVisible ? Icons.expand_less : Icons.expand_more,
              color: theme.currentTheme.colorsScheme.surfaceBrandPrimary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _codeTokenDisplayCodeSection(ThemeController theme) {
    return Padding(
      padding: EdgeInsets.only(
        left: theme.currentTheme.spaceTokens.paddingBlockTall,
        right: theme.currentTheme.spaceTokens.paddingBlockTall,
        bottom: theme.currentTheme.spaceTokens.paddingBlockTall,
        top: theme.currentTheme.spaceTokens.paddingBlockShort,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: theme.currentTheme.spaceTokens.paddingInlineShort,
          horizontal: theme.currentTheme.spaceTokens.paddingInlineMedium,
        ),
        decoration: BoxDecoration(
          color: theme.currentTheme.colorsScheme.surfaceStatusNeutralMuted,
          borderRadius: BorderRadius.circular(theme.currentTheme.borderTokens.radiusDefault),
          border: Border.all(color: theme.currentTheme.colorsScheme.borderDefault, width: theme.currentTheme.borderTokens.widthDefault),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.code,
                style: TextStyle(
                  fontSize: theme.currentTheme.fontTokens.sizeBodyMediumMobile,
                  letterSpacing: theme.currentTheme.fontTokens.letterSpacingBodyMediumMobile,
                  fontFamily: 'RobotoMono',
                  package: 'ouds_theme_white_label',
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    theme.currentTheme.colorsScheme.actionEnabled,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/ic_copy.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: widget.code),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      isCodeVisible = !isCodeVisible;
    });
  }
}
