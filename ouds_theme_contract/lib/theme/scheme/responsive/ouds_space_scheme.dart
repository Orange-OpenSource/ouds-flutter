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
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_space_semantic_tokens.dart';

/// Responsive space token scheme for OUDS Flutter.
///
/// Provides dynamic access to all space tokens depending on the current window width size class (mobile/tablet).
/// Use [OudsSpaceScheme.fromContext] to get an instance, then access any spacing token with the correct value for the device size.
///
/// Example:
/// ```dart
/// final spaceScheme = OudsSpaceScheme.fromContext(context: context, spaceTokens: OudsTheme.of(context).spaceTokens);
/// final padding = spaceScheme.scaledMedium;
/// ```
class OudsSpaceScheme {
  /// The underlying semantic space tokens.
  final OudsSpaceSemanticTokens spaceTokens;

  /// The current window width size class.
  final OudsWindowWidthSizeClass sizeClass;

  OudsSpaceScheme._({required this.spaceTokens, required this.sizeClass});

  /// Factory to create a responsive [OudsSpaceScheme] from context and space tokens.
  factory OudsSpaceScheme.fromContext({
    required BuildContext context,
    required OudsSpaceSemanticTokens spaceTokens,
  }) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    return OudsSpaceScheme._(
      spaceTokens: spaceTokens,
      sizeClass: sizeClass,
    );
  }

  /// Responsive tokens (mobile/tablet)
  double get scaledNone => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledNoneMobile,
        tablet: spaceTokens.scaledNoneTablet,
      );
  double get scaledThreeExtraSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaled3xsMobile,
        tablet: spaceTokens.scaled3xsTablet,
      );
  double get scaledTwoExtraSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaled2xsMobile,
        tablet: spaceTokens.scaled2xsTablet,
      );
  double get scaledExtraSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledXsMobile,
        tablet: spaceTokens.scaledXsTablet,
      );

  double get scaledSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledSmMobile,
        tablet: spaceTokens.scaledSmTablet,
      );
  double get scaledMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledMdMobile,
        tablet: spaceTokens.scaledMdTablet,
      );
  double get scaledLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledLgMobile,
        tablet: spaceTokens.scaledLgTablet,
      );
  double get scaledExtraLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledXlMobile,
        tablet: spaceTokens.scaledXlTablet,
      );
  double get scaledTwoExtraLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaled2xlMobile,
        tablet: spaceTokens.scaled2xlTablet,
      );
  double get scaledThreeExtraLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaled3xlMobile,
        tablet: spaceTokens.scaled3xlTablet,
      );

  /// Non-responsive tokens (direct mapping)
  double get fixedNone => spaceTokens.fixedNone;
  double get fixedThreeExtraSmall => spaceTokens.fixed3xs;
  double get fixedTwoExtraSmall => spaceTokens.fixed2xs;
  double get fixedExtraSmall => spaceTokens.fixedXs;
  double get fixedSmall => spaceTokens.fixedSm;
  double get fixedMedium => spaceTokens.fixedMd;
  double get fixedLarge => spaceTokens.fixedLg;
  double get fixedExtraLarge => spaceTokens.fixedXl;
  double get fixedTwoExtraLarge => spaceTokens.fixed2xl;
  double get fixedThreeExtraLarge => spaceTokens.fixed3xl;
  double get fixedFourExtraLarge => spaceTokens.fixed4xl;
  double get fixedFiveExtraLarge => spaceTokens.fixed5xl;
  double get paddingInlineNone => spaceTokens.paddingInlineNone;
  double get paddingInlineFourExtraSmall => spaceTokens.paddingInline4xs;
  double get paddingInlineThreeExtraSmall => spaceTokens.paddingInline3xs;
  double get paddingInlineTwoExtraSmall => spaceTokens.paddingInline2xs;
  double get paddingInlineExtraSmall => spaceTokens.paddingInlineXs;
  double get paddingInlineSmall => spaceTokens.paddingInlineSm;
  double get paddingInlineMedium => spaceTokens.paddingInlineMd;
  double get paddingInlineLarge => spaceTokens.paddingInlineLg;
  double get paddingInlineExtraLarge => spaceTokens.paddingInlineXl;
  double get paddingInlineTwoExtraLarge => spaceTokens.paddingInline2xl;
  double get paddingInlineThreeExtraLarge => spaceTokens.paddingInline3xl;
  double get paddingInlineFourExtraLarge => spaceTokens.paddingInline4xl;
  double get paddingBlockNone => spaceTokens.paddingBlockNone;
  double get paddingBlockThreeExtraSmall => spaceTokens.paddingBlock3xs;
  double get paddingBlockTwoExtraSmall => spaceTokens.paddingBlock2xs;
  double get paddingBlockExtraSmall => spaceTokens.paddingBlockXs;
  double get paddingBlockSmall => spaceTokens.paddingBlockSm;
  double get paddingBlockMedium => spaceTokens.paddingBlockMd;
  double get paddingBlockLarge => spaceTokens.paddingBlockLg;
  double get paddingBlockExtraLarge => spaceTokens.paddingBlockXl;
  double get paddingBlockTwoExtraLarge => spaceTokens.paddingBlock2xl;
  double get paddingBlockThreeExtraLarge => spaceTokens.paddingBlock3xl;
  double get paddingBlockFourExtraLarge => spaceTokens.paddingBlock4xl;
  double get insetNone => spaceTokens.insetNone;
  double get insetFourExtraSmall => spaceTokens.inset4xs;
  double get insetThreeExtraSmall => spaceTokens.inset3xs;
  double get insetTwoExtraSmall => spaceTokens.inset2xs;
  double get insetExtraSmall => spaceTokens.insetXs;
  double get insetSmall => spaceTokens.insetSm;
  double get insetMedium => spaceTokens.insetMd;
  double get insetLarge => spaceTokens.insetLg;
  double get insetExtraLarger => spaceTokens.insetXl;
  double get insetTwoExtraLarge => spaceTokens.inset2xl;
  double get insetThreeExtraLarge => spaceTokens.inset3xl;
  double get columnGapNone => spaceTokens.columnGapNone;
  double get columnGapThreeExtraSmall => spaceTokens.columnGap3xs;
  double get columnGapTwoExtraSmall => spaceTokens.columnGap2xs;
  double get columnGapExtraSmall => spaceTokens.columnGapXs;
  double get columnGapSmall => spaceTokens.columnGapSm;
  double get columnGapMedium => spaceTokens.columnGapMd;
  double get columnGapLarge => spaceTokens.columnGapLg;
  double get columnGapExtraLarge => spaceTokens.columnGapXl;
  double get columnGapTwoExtraLarge => spaceTokens.columnGap2xl;
  double get rowGapNone => spaceTokens.rowGapNone;
  double get rowGapThreeExtraSmall => spaceTokens.rowGap3xs;
  double get rowGapTwoExtraSmall => spaceTokens.rowGap2xs;
  double get rowGapExtraSmall => spaceTokens.rowGapXs;
  double get rowGapSmall => spaceTokens.rowGapSm;
  double get rowGapMedium => spaceTokens.rowGapMd;
  double get rowGapLarge => spaceTokens.rowGapLg;
}
