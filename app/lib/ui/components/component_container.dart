/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

// Exemple de widget personnalisé qui peut contenir un composant
import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class ComponentContainer extends StatelessWidget {
  final Widget child;

  const ComponentContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 180),
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: OudsTheme.of(context).gridScheme(context).margin,
              ),
              color: theme.colorScheme(context).surfaceSecondary,
              child: Align(child: IgnorePointer(child: child)),
            ),
          ),
        ),
      ],
    );
  }
}
