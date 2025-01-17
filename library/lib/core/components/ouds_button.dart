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
import 'package:ouds_flutter/core/ouds_theme.dart';

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

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorTokens.primaryColor,
          textStyle: theme.fontTokens.bodyTextStyle,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(theme.borderTokens.borderRadius),
          ),
          minimumSize: Size(
              theme.sizeTokens.buttonHeight, theme.sizeTokens.buttonHeight)),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
