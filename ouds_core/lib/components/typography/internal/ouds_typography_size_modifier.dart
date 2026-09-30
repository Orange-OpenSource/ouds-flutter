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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/typography/ouds_body_text.dart';
import 'package:ouds_core/components/typography/ouds_display_text.dart';
import 'package:ouds_core/components/typography/ouds_heading_text.dart';
import 'package:ouds_core/components/typography/ouds_label_text.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTypographySizeModifier {
  final BuildContext context;

  // Constructor that initializes the modifier with the current build context
  OudsTypographySizeModifier(this.context);

  /// Returns the maximum width size for display text based on its size
  double getDisplayWidthMaxSize(OudsDisplayTextSize size) {
    final sizeTokens = OudsTheme.of(context).sizeScheme(context);

    switch (size) {
      case OudsDisplayTextSize.large:
        return sizeTokens.maxWidthDisplayLarge;
      case OudsDisplayTextSize.medium:
        return sizeTokens.maxWidthDisplayMedium;
      case OudsDisplayTextSize.small:
        return sizeTokens.maxWidthDisplaySmall;
    }
  }

  /// Returns the maximum width size for heading text based on its size
  double getHeadingWidthMaxSize(OudsHeadingTextSize size) {
    final sizeTokens = OudsTheme.of(context).sizeScheme(context);

    switch (size) {
      case OudsHeadingTextSize.xLarge:
        return sizeTokens.maxWidthHeadingExtraLarge;
      case OudsHeadingTextSize.large:
        return sizeTokens.maxWidthHeadingLarge;
      case OudsHeadingTextSize.medium:
        return sizeTokens.maxWidthHeadingMedium;
      case OudsHeadingTextSize.small:
        return sizeTokens.maxWidthHeadingSmall;
    }
  }

  /// Returns the maximum width size for body text based on its size
  double getBodyWidthMaxSize(OudsBodyTextSize size) {
    final sizeTokens = OudsTheme.of(context).sizeScheme(context);

    switch (size) {
      case OudsBodyTextSize.large:
        return sizeTokens.maxWidthBodyLarge;
      case OudsBodyTextSize.medium:
        return sizeTokens.maxWidthBodyMedium;
      case OudsBodyTextSize.small:
        return sizeTokens.maxWidthBodySmall;
    }
  }

  /// Returns the maximum width size for label text based on its size
  double getLabelWidthMaxSize(OudsLabelTextSize size) {
    final sizeTokens = OudsTheme.of(context).sizeScheme(context);

    switch (size) {
      case OudsLabelTextSize.xLarge:
        return sizeTokens.maxWidthLabelXLarge;
      case OudsLabelTextSize.large:
        return sizeTokens.maxWidthLabelLarge;
      case OudsLabelTextSize.medium:
        return sizeTokens.maxWidthLabelMedium;
      case OudsLabelTextSize.small:
        return sizeTokens.maxWidthLabelSmall;
    }
  }
}
