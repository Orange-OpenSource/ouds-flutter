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
    return OudsSizeScheme._(sizeTokens: sizeTokens, sizeClass: sizeClass);
  }

  /// Responsive `size` tokens (mobile/tablet)

  /// IconWithBodySmall
  double get iconWithBodySmallSizeSmall =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodySmallSizeSmallMobile,
        tablet: sizeTokens.iconWithBodySmallSizeSmallTablet,
      );

  double get iconWithBodySmallSizeMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodySmallSizeMediumMobile,
        tablet: sizeTokens.iconWithBodySmallSizeMediumTablet,
      );

  double get iconWithBodySmallSizeLarge =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodySmallSizeLargeMobile,
        tablet: sizeTokens.iconWithBodySmallSizeLargeTablet,
      );

  /// IconWithBodyMedium

  double get iconWithBodyMediumSizeSmall =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyMediumSizeSmallMobile,
        tablet: sizeTokens.iconWithBodyMediumSizeSmallTablet,
      );

  double get iconWithBodyMediumSizeMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyMediumSizeMediumMobile,
        tablet: sizeTokens.iconWithBodyMediumSizeMediumTablet,
      );

  double get iconWithBodyMediumSizeLarge =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyMediumSizeLargeMobile,
        tablet: sizeTokens.iconWithBodyMediumSizeLargeTablet,
      );

  /// IconWithBodyLarge

  double get iconWithBodyLargeSizeSmall =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyLargeSizeSmallMobile,
        tablet: sizeTokens.iconWithBodyLargeSizeSmallTablet,
      );

  double get iconWithBodyLargeSizeMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyLargeSizeMediumMobile,
        tablet: sizeTokens.iconWithBodyLargeSizeMediumTablet,
      );

  double get iconWithBodyLargeSizeLarge =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithBodyLargeSizeLargeMobile,
        tablet: sizeTokens.iconWithBodyLargeSizeLargeTablet,
      );

  /// IconWithHeadingSmall
  double get iconWithHeadingSmallSizeSmall =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingSmallSizeSmallMobile,
        tablet: sizeTokens.iconWithHeadingSmallSizeSmallTablet,
      );

  double get iconWithHeadingSmallSizeMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingSmallSizeMediumMobile,
        tablet: sizeTokens.iconWithHeadingSmallSizeMediumTablet,
      );

  double get iconWithHeadingSmallSizeLarge =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingSmallSizeLargeMobile,
        tablet: sizeTokens.iconWithHeadingSmallSizeLargeTablet,
      );

  /// IconWithHeadingMedium
  double get iconWithHeadingMediumSizeSmall =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingMediumSizeSmallMobile,
        tablet: sizeTokens.iconWithHeadingMediumSizeSmallTablet,
      );

  double get iconWithHeadingMediumSizeMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingMediumSizeMediumMobile,
        tablet: sizeTokens.iconWithHeadingMediumSizeMediumTablet,
      );

  double get iconWithHeadingMediumSizeLarge =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingMediumSizeLargeMobile,
        tablet: sizeTokens.iconWithHeadingMediumSizeLargeTablet,
      );

  /// IconWithHeadingLarge
  double get iconWithHeadingLargeSizeSmall =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingLargeSizeSmallMobile,
        tablet: sizeTokens.iconWithHeadingLargeSizeSmallTablet,
      );

  double get iconWithHeadingLargeSizeMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingLargeSizeMediumMobile,
        tablet: sizeTokens.iconWithHeadingLargeSizeMediumTablet,
      );

  double get iconWithHeadingLargeSizeLarge =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingLargeSizeLargeMobile,
        tablet: sizeTokens.iconWithHeadingLargeSizeLargeTablet,
      );

  /// IconWithHeadingExtraLarge
  double get iconWithHeadingExtraLargeSizeSmall =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingXlargeSizeSmallMobile,
        tablet: sizeTokens.iconWithHeadingXlargeSizeSmallTablet,
      );

  double get iconWithHeadingExtraLargeSizeMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingXlargeSizeMediumMobile,
        tablet: sizeTokens.iconWithHeadingXlargeSizeMediumTablet,
      );

  double get iconWithHeadingExtraLargeSizeLarge =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.iconWithHeadingXlargeSizeLargeMobile,
        tablet: sizeTokens.iconWithHeadingXlargeSizeLargeTablet,
      );

  /// MaxWidthDisplay
  double get maxWidthDisplaySmall => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthDisplaySmallMobile,
    tablet: sizeTokens.maxWidthDisplaySmallTablet,
  );

  double get maxWidthDisplayMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthDisplayMediumMobile,
        tablet: sizeTokens.maxWidthDisplayMediumTablet,
      );

  double get maxWidthDisplayLarge => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthDisplayLargeMobile,
    tablet: sizeTokens.maxWidthDisplayLargeTablet,
  );

  /// MaxWidthHeading
  double get maxWidthHeadingSmall => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthHeadingSmallMobile,
    tablet: sizeTokens.maxWidthHeadingSmallTablet,
  );

  double get maxWidthHeadingMedium =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthHeadingMediumMobile,
        tablet: sizeTokens.maxWidthHeadingMediumTablet,
      );

  double get maxWidthHeadingLarge => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthHeadingLargeMobile,
    tablet: sizeTokens.maxWidthHeadingLargeTablet,
  );

  double get maxWidthHeadingExtraLarge =>
      OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: sizeTokens.maxWidthHeadingXlargeMobile,
        tablet: sizeTokens.maxWidthHeadingXlargeTablet,
      );

  /// MaxWidthBody
  double get maxWidthBodySmall => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthBodySmallMobile,
    tablet: sizeTokens.maxWidthBodySmallTablet,
  );

  double get maxWidthBodyMedium => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthBodyMediumMobile,
    tablet: sizeTokens.maxWidthBodyMediumTablet,
  );

  double get maxWidthBodyLarge => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthBodyLargeMobile,
    tablet: sizeTokens.maxWidthBodyLargeTablet,
  );


  /// MaxWidthTypeLabel
  double get maxWidthLabelSmall => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthLabelSmallMobile,
    tablet: sizeTokens.maxWidthLabelSmallTablet,
  );

  double get maxWidthLabelMedium => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthLabelMediumMobile,
    tablet: sizeTokens.maxWidthLabelMediumTablet,
  );

  double get maxWidthLabelLarge => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthLabelLargeMobile,
    tablet: sizeTokens.maxWidthLabelLargeTablet,
  );

  double get maxWidthLabelXlarge => OudsWindowSizeClassUtil.selectMobileTablet(
    sizeClass: sizeClass,
    mobile: sizeTokens.maxWidthLabelXlargeMobile,
    tablet: sizeTokens.maxWidthLabelXlargeTablet,
  );


  /// Non-responsive tokens (direct mapping)

  /// iconDecorative
  double get iconDecorativeExtraExtraSmall => sizeTokens.iconDecorative2xsmall;
  double get iconDecorativeExtraSmall => sizeTokens.iconDecorativeXsmall;
  double get iconDecorativeSmall => sizeTokens.iconDecorativeSmall;
  double get iconDecorativeMedium => sizeTokens.iconDecorativeMedium;
  double get iconDecorativeLarge => sizeTokens.iconDecorativeLarge;
  double get iconDecorativeExtraLarge => sizeTokens.iconDecorativeXlarge;
  double get iconDecorativeExtraExtraLarge => sizeTokens.iconDecorative2xlarge;

  /// iconWithLabelSmall
  double get iconWithLabelSmallSizeExtraSmall =>
      sizeTokens.iconWithLabelSmallSizeXsmall;
  double get iconWithLabelSmallSizeSmall =>
      sizeTokens.iconWithLabelSmallSizeSmall;
  double get iconWithLabelSmallSizeMedium =>
      sizeTokens.iconWithLabelSmallSizeMedium;
  double get iconWithLabelSmallSizeLarge =>
      sizeTokens.iconWithLabelSmallSizeLarge;

  /// iconWithLabelMedium
  double get iconWithLabelMediumSizeExtraSmall =>
      sizeTokens.iconWithLabelMediumSizeXsmall;
  double get iconWithLabelMediumSizeSmall =>
      sizeTokens.iconWithLabelMediumSizeSmall;
  double get iconWithLabelMediumSizeMedium =>
      sizeTokens.iconWithLabelMediumSizeMedium;
  double get iconWithLabelMediumSizeLarge =>
      sizeTokens.iconWithLabelMediumSizeLarge;

  /// iconWithLabelLarge
  double get iconWithLabelLargeSizeExtraSmall =>
      sizeTokens.iconWithLabelLargeSizeXsmall;
  double get iconWithLabelLargeSizeSmall =>
      sizeTokens.iconWithLabelLargeSizeSmall;
  double get iconWithLabelLargeSizeMedium =>
      sizeTokens.iconWithLabelLargeSizeMedium;
  double get iconWithLabelLargeSizeLarge =>
      sizeTokens.iconWithLabelLargeSizeLarge;
  double get iconWithLabelLargeSizeExtraLarge =>
      sizeTokens.iconWithLabelLargeSizeXlarge;

  /// iconWithLabelExtraSmall
  double get iconWithLabelExtraLargeSizeSmall =>
      sizeTokens.iconWithLabelXlargeSizeSmall;
  double get iconWithLabelExtraLargeSizeMedium =>
      sizeTokens.iconWithLabelXlargeSizeMedium;
  double get iconWithLabelExtraLargeSizeLarge =>
      sizeTokens.iconWithLabelXlargeSizeLarge;
}
