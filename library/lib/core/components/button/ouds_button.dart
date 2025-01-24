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
    final theme = OudsTheme.of(context).themeData;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
        textStyle: theme.textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              OudsTheme.of(context).componentsTokens.button.borderRadius),
        ),
        minimumSize: const Size(130, 60),
        foregroundColor: theme.cardColor,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
