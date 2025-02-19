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
import 'package:ouds_core/ouds_theme.dart';

class OudsButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OudsButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);

    /// ElevatedButtonTheme
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: theme.componentsTokens.button.colorBgDefaultEnabled,
        textStyle: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(theme.componentsTokens.button.borderRadius),
          side: BorderSide(
              color: theme.componentsTokens.button.colorBorderDefaultEnabled,
              width: theme.componentsTokens.button.borderWidthDefault),
        ),
        minimumSize: Size(theme.componentsTokens.button.sizeMinWidth,
            theme.componentsTokens.button.sizeMinHeight),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
