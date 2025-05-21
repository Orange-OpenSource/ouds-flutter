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
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_window_size_class.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_grid_semantic_tokens.dart';

/// Responsive grid token scheme for OUDS Flutter.
///
/// Provides dynamic access to all grid tokens depending on the current window width size class (extraCompact, compact, medium).
/// Use [OudsGridScheme.fromContext] to get an instance, then access any grid token with the correct value for the device size.
///
class OudsGridScheme {
  final OudsGridSemanticTokens gridTokens;
  final OudsWindowWidthSizeClass sizeClass;

  OudsGridScheme._({required this.gridTokens, required this.sizeClass});

  /// Factory to create a responsive [OudsGridScheme] from context and grid tokens.
  factory OudsGridScheme.fromContext({
    required BuildContext context,
    required OudsGridSemanticTokens gridTokens,
  }) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    return OudsGridScheme._(
      gridTokens: gridTokens,
      sizeClass: sizeClass,
    );
  }

  /// Returns the gap depending on the window size class.
  int get minWidth => OudsWindowSizeClassUtil.select(
        sizeClass: sizeClass,
        extraCompact: gridTokens.extraCompactMinWidth,
        compact: gridTokens.compactMinWidth,
        medium: gridTokens.mediumMinWidth,
      );

  int get maxWidth => OudsWindowSizeClassUtil.select(
        sizeClass: sizeClass,
        extraCompact: gridTokens.extraCompactMaxWidth,
        compact: gridTokens.compactMaxWidth,
        medium: gridTokens.mediumMaxWidth,
      );

  double get margin => OudsWindowSizeClassUtil.select(
        sizeClass: sizeClass,
        extraCompact: gridTokens.extraCompactMargin,
        compact: gridTokens.compactMargin,
        medium: gridTokens.mediumMargin,
      );

  double get columnGap => OudsWindowSizeClassUtil.select(
        sizeClass: sizeClass,
        extraCompact: gridTokens.extraCompactColumnGap,
        compact: gridTokens.compactColumnGap,
        medium: gridTokens.mediumColumnGap,
      );
}
