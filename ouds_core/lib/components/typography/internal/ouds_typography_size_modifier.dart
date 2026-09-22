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
import 'package:ouds_core/components/typography/ouds_typography.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTypographySizeModifier {
  final BuildContext context;

  OudsTypographySizeModifier(this.context);

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
