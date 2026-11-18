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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/card/card_customization.dart';
import 'package:ouds_flutter_demo/ui/components/card/card_enum.dart';

class CardCodeGenerator {
  /// Generates a code example matching the current card customization.
  static String updateCode(BuildContext context, {required bool actionCard}) {
    final state = CardCustomization.of(context)!;
    final style = state.style;
    final component = switch ((actionCard, style)) {
      (true, CardStyleEnum.filled) => 'OudsActionCard.filled',
      (true, CardStyleEnum.outlined) => 'OudsActionCard.outlined',
      (true, CardStyleEnum.elevated) => 'OudsActionCard.elevated',
      (false, CardStyleEnum.filled) => 'OudsCard.filled',
      (false, CardStyleEnum.outlined) => 'OudsCard.outlined',
      (false, CardStyleEnum.elevated) => 'OudsCard.elevated',
    };
    final semanticsLabel =
        context.l10n.app_components_card_actionCard_semantics_a11y;
    final properties = <String>[
      if (actionCard)
        'semanticsLabel: ${_stringLiteral(semanticsLabel)}'
      'enabled: ${state.enabled}',
      if (style != CardStyleEnum.outlined)
        'backgroundColor: ${state.coloredBackground}',
      if (style == CardStyleEnum.filled) 'divider: ${state.divider}',
      if (state.skeleton) 'skeleton: OudsSkeleton()',
      if (actionCard) ...[
        'onPressed: () {}',
        if (state.loading)
          'loader: OudsCardLoader()',
      ],
      'child: /* custom widget */ ',
    ];

    return '$component(\n${properties.map((line) => '  $line').join(',\n')}\n)';
  }

  /// Escapes [value] as a Dart string literal.
  static String _stringLiteral(String value) =>
      jsonEncode(value).replaceAll(r'$', r'\$');
}
