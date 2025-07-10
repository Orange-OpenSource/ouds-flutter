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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_size_semantic_tokens.dart';

/// Responsive size token scheme for OUDS Flutter.
///
/// Provides dynamic access to all size tokens depending on the current window width size class (mobile/tablet).
/// Use [OudsSizeScheme.fromContext] to get an instance, then access any spacing token with the correct value for the device size.
///
/// Example:
/// ```dart
/// final sizeScheme = OudsSizeScheme.fromContext(context: context, sizeTokens: OudsTheme.of(context).sizeTokens);
/// final padding = sizeScheme.scaledMedium;
/// ```
class OudsSizeScheme {
  /// The underlying semantic size tokens.
  final OudsSizeSemanticTokens sizeTokens;

  /// The current window width size class.
  final OudsWindowWidthSizeClass sizeClass;

  OudsSizeScheme._({required this.sizeTokens, required this.sizeClass});

  /// Factory to create a responsive [OudsSizeScheme] from context and size tokens.
  factory OudsSizeScheme.fromContext({
    required BuildContext context,
    required OudsSizeSemanticTokens sizeTokens,
  }) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    return OudsSizeScheme._(
      sizeTokens: sizeTokens,
      sizeClass: sizeClass,
    );
  }

  /// Responsive `size` tokens (mobile/tablet)

  /// IconWithBodySmall
  double get iconWithBodySmallSizeSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodySmallSizeSmMobile,
        tablet: sizeTokens.iconWithBodySmallSizeSmTablet,
      );

  double get iconWithBodySmallSizeMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodySmallSizeMdMobile,
        tablet: sizeTokens.iconWithBodySmallSizeMdTablet,
      );

  double get iconWithBodySmallSizeLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodySmallSizeLgMobile,
        tablet: sizeTokens.iconWithBodySmallSizeLgTablet,
      );

  /// IconWithBodyMedium

  double get iconWithBodyMediumSizeSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyMediumSizeSmMobile,
        tablet: sizeTokens.iconWithBodyMediumSizeSmTablet,
      );

  double get iconWithBodyMediumSizeMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyMediumSizeMdMobile,
        tablet: sizeTokens.iconWithBodyMediumSizeMdTablet,
      );

  double get iconWithBodyMediumSizeLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyMediumSizeLgMobile,
        tablet: sizeTokens.iconWithBodyMediumSizeLgTablet,
      );

  /// IconWithBodyLarge

  double get iconWithBodyLargeSizeSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyLargeSizeSmMobile,
        tablet: sizeTokens.iconWithBodyLargeSizeSmTablet,
      );

  double get iconWithBodyLargeSizeMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyLargeSizeMdMobile,
        tablet: sizeTokens.iconWithBodyLargeSizeMdTablet,
      );

  double get iconWithBodyLargeSizeLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyLargeSizeLgMobile,
        tablet: sizeTokens.iconWithBodyLargeSizeLgTablet,
      );

  /// IconWithHeadingSmall
  double get iconWithHeadingSmallSizeSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingSmallSizeSmMobile,
        tablet: sizeTokens.iconWithHeadingSmallSizeSmTablet,
      );

  double get iconWithHeadingSmallSizeMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingSmallSizeMdMobile,
        tablet: sizeTokens.iconWithHeadingSmallSizeMdTablet,
      );

  double get iconWithHeadingSmallSizeLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingSmallSizeLgMobile,
        tablet: sizeTokens.iconWithHeadingSmallSizeLgTablet,
      );

  /// IconWithHeadingMedium
  double get iconWithHeadingMediumSizeSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingMediumSizeSmMobile,
        tablet: sizeTokens.iconWithHeadingMediumSizeSmTablet,
      );

  double get iconWithHeadingMediumSizeMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingMediumSizeMdMobile,
        tablet: sizeTokens.iconWithHeadingMediumSizeMdTablet,
      );

  double get iconWithHeadingMediumSizeLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingMediumSizeLgMobile,
        tablet: sizeTokens.iconWithHeadingMediumSizeLgTablet,
      );

  /// IconWithHeadingLarge
  double get iconWithHeadingLargeSizeSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingLargeSizeSmMobile,
        tablet: sizeTokens.iconWithHeadingLargeSizeSmTablet,
      );

  double get iconWithHeadingLargeSizeMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingLargeSizeMdMobile,
        tablet: sizeTokens.iconWithHeadingLargeSizeMdTablet,
      );

  double get iconWithHeadingLargeSizeLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingLargeSizeLgMobile,
        tablet: sizeTokens.iconWithHeadingLargeSizeLgTablet,
      );

  /// IconWithHeadingExtraLarge
  double get iconWithHeadingExtraLargeSizeSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingXlargeSizeSmMobile,
        tablet: sizeTokens.iconWithHeadingXlargeSizeSmTablet,
      );

  double get iconWithHeadingExtraLargeSizeMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingXlargeSizeMdMobile,
        tablet: sizeTokens.iconWithHeadingXlargeSizeMdTablet,
      );

  double get iconWithHeadingExtraLargeSizeLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingXlargeSizeLgMobile,
        tablet: sizeTokens.iconWithHeadingXlargeSizeLgTablet,
      );

  /// MaxWidthTypeDisplay
  double get maxWidthTypeDisplaySmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeDisplaySmallMobile,
        tablet: sizeTokens.maxWidthTypeDisplaySmallTablet,
      );

  double get maxWidthTypeDisplayMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeDisplayMediumMobile,
        tablet: sizeTokens.maxWidthTypeDisplayMediumTablet,
      );

  double get maxWidthTypeDisplayLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeDisplayLargeMobile,
        tablet: sizeTokens.maxWidthTypeDisplayLargeTablet,
      );

  /// MaxWidthTypeHeading
  double get maxWidthTypeHeadingSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeHeadingSmallMobile,
        tablet: sizeTokens.maxWidthTypeHeadingSmallTablet,
      );

  double get maxWidthTypeHeadingMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeHeadingMediumMobile,
        tablet: sizeTokens.maxWidthTypeHeadingMediumTablet,
      );

  double get maxWidthTypeHeadingLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeHeadingLargeMobile,
        tablet: sizeTokens.maxWidthTypeHeadingLargeTablet,
      );

  double get maxWidthTypeHeadingExtraLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeHeadingXlargeMobile,
        tablet: sizeTokens.maxWidthTypeHeadingXlargeTablet,
      );

  /// MaxWidthTypeBody
  double get maxWidthTypeBodySmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeBodySmallMobile,
        tablet: sizeTokens.maxWidthTypeBodySmallTablet,
      );

  double get maxWidthTypeBodyMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeBodyMediumMobile,
        tablet: sizeTokens.maxWidthTypeBodyMediumTablet,
      );

  double get maxWidthTypeBodyLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthTypeBodyLargeMobile,
        tablet: sizeTokens.maxWidthTypeBodyLargeTablet,
      );

  /// Non-responsive tokens (direct mapping)

  /// iconDecorative
  double get iconDecorativeExtraExtraSmall => sizeTokens.iconDecorative2xs;
  double get iconDecorativeExtraSmall => sizeTokens.iconDecorativeXs;
  double get iconDecorativeSmall => sizeTokens.iconDecorativeSm;
  double get iconDecorativeMedium => sizeTokens.iconDecorativeMd;
  double get iconDecorativeLarge => sizeTokens.iconDecorativeLg;
  double get iconDecorativeExtraLarge => sizeTokens.iconDecorativeXl;
  double get iconDecorativeExtraExtraLarge => sizeTokens.iconDecorative2xl;

  /// iconWithLabelSmall
  double get iconWithLabelSmallSizeExtraSmall => sizeTokens.iconWithLabelSmallSizeXs;
  double get iconWithLabelSmallSizeSmall => sizeTokens.iconWithLabelSmallSizeSm;
  double get iconWithLabelSmallSizeMedium => sizeTokens.iconWithLabelSmallSizeMd;
  double get iconWithLabelSmallSizeLarge => sizeTokens.iconWithLabelSmallSizeLg;

  /// iconWithLabelMedium
  double get iconWithLabelMediumSizeExtraSmall => sizeTokens.iconWithLabelMediumSizeXs;
  double get iconWithLabelMediumSizeSmall => sizeTokens.iconWithLabelMediumSizeSm;
  double get iconWithLabelMediumSizeMedium => sizeTokens.iconWithLabelMediumSizeMd;
  double get iconWithLabelMediumSizeLarge => sizeTokens.iconWithLabelMediumSizeLg;

  /// iconWithLabelLarge
  double get iconWithLabelLargeSizeExtraSmall => sizeTokens.iconWithLabelLargeSizeXs;
  double get iconWithLabelLargeSizeSmall => sizeTokens.iconWithLabelLargeSizeSm;
  double get iconWithLabelLargeSizeMedium => sizeTokens.iconWithLabelLargeSizeMd;
  double get iconWithLabelLargeSizeLarge => sizeTokens.iconWithLabelLargeSizeLg;
  double get iconWithLabelLargeSizeExtraLarge => sizeTokens.iconWithLabelLargeSizeXl;

  /// iconWithLabelExtraSmall
  double get iconWithLabelExtraLargeSizeSmall => sizeTokens.iconWithLabelXlargeSizeSm;
  double get iconWithLabelExtraLargeSizeMedium => sizeTokens.iconWithLabelXlargeSizeMd;
  double get iconWithLabelExtraLargeSizeLarge => sizeTokens.iconWithLabelXlargeSizeLg;
}
