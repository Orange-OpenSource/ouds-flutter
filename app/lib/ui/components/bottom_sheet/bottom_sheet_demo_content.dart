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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Shared content widget displayed inside any bottom sheet demo.
///
/// Mirrors `BottomSheetDemoContent` from the Android app.
class BottomSheetDemoContent extends StatelessWidget {
  const BottomSheetDemoContent({
    super.key,
    required this.buttonLabel,
    required this.onButtonPressed,
    this.showDragHandle = true,
  });

  /// Label for the action button (e.g. "Close" or "Collapse").
  final String buttonLabel;

  /// Called when the action button is pressed.
  final VoidCallback onButtonPressed;

  /// When `false`, extra top padding is added (no drag handle above the content).
  final bool showDragHandle;

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: showDragHandle ? 0 : theme.spaceScheme(context).fixedMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.app_components_bottomSheet_sheetContent_text,
              style: theme.typographyTokens.typeBodyDefaultMedium(context),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: theme.spaceScheme(context).fixedMedium,
                bottom: theme.spaceScheme(context).fixedMedium,
              ),
              child: OudsButton(
                label: buttonLabel,
                appearance: OudsButtonAppearance.defaultAppearance,
                onPressed: onButtonPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
