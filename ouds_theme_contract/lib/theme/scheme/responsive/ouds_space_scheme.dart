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
        mobile: spaceTokens.scaled3xsmallMobile,
        tablet: spaceTokens.scaled3xsmallTablet,
      );
  double get scaledTwoExtraSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaled2xsmallMobile,
        tablet: spaceTokens.scaled2xsmallTablet,
      );
  double get scaledExtraSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledXsmallMobile,
        tablet: spaceTokens.scaledXsmallTablet,
      );

  double get scaledSmall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledSmallMobile,
        tablet: spaceTokens.scaledSmallTablet,
      );
  double get scaledMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledMediumMobile,
        tablet: spaceTokens.scaledMediumTablet,
      );
  double get scaledLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledLargeMobile,
        tablet: spaceTokens.scaledLargeTablet,
      );
  double get scaledExtraLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledXlargeMobile,
        tablet: spaceTokens.scaledXlargeTablet,
      );
  double get scaledTwoExtraLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaled2xlargeMobile,
        tablet: spaceTokens.scaled2xlargeTablet,
      );
  double get scaledThreeExtraLarge => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaled3xlargeMobile,
        tablet: spaceTokens.scaled3xlargeTablet,
      );

  /// Non-responsive tokens (direct mapping)
  double get fixedNone => spaceTokens.fixedNone;
  double get fixedThreeExtraSmall => spaceTokens.fixed3xsmall;
  double get fixedTwoExtraSmall => spaceTokens.fixed2xsmall;
  double get fixedExtraSmall => spaceTokens.fixedXsmall;
  double get fixedSmall => spaceTokens.fixedSmall;
  double get fixedMedium => spaceTokens.fixedMedium;
  double get fixedLarge => spaceTokens.fixedLarge;
  double get fixedExtraLarge => spaceTokens.fixedXlarge;
  double get fixedTwoExtraLarge => spaceTokens.fixed2xlarge;
  double get fixedThreeExtraLarge => spaceTokens.fixed3xlarge;
  double get fixedFourExtraLarge => spaceTokens.fixed4xlarge;
  double get fixedFiveExtraLarge => spaceTokens.fixed5xlarge;
  double get paddingInlineNone => spaceTokens.paddingInlineNone;
  double get paddingInlineFourExtraSmall => spaceTokens.paddingInline4xsmall;
  double get paddingInlineThreeExtraSmall => spaceTokens.paddingInline3xsmall;
  double get paddingInlineTwoExtraSmall => spaceTokens.paddingInline2xsmall;
  double get paddingInlineExtraSmall => spaceTokens.paddingInlineXsmall;
  double get paddingInlineSmall => spaceTokens.paddingInlineSmall;
  double get paddingInlineMedium => spaceTokens.paddingInlineMedium;
  double get paddingInlineLarge => spaceTokens.paddingInlineLarge;
  double get paddingInlineExtraLarge => spaceTokens.paddingInlineXlarge;
  double get paddingInlineTwoExtraLarge => spaceTokens.paddingInline2xlarge;
  double get paddingInlineThreeExtraLarge => spaceTokens.paddingInline3xlarge;
  double get paddingInlineFourExtraLarge => spaceTokens.paddingInline4xlarge;
  double get paddingBlockNone => spaceTokens.paddingBlockNone;
  double get paddingBlockThreeExtraSmall => spaceTokens.paddingBlock3xsmall;
  double get paddingBlockTwoExtraSmall => spaceTokens.paddingBlock2xsmall;
  double get paddingBlockExtraSmall => spaceTokens.paddingBlockXsmall;
  double get paddingBlockSmall => spaceTokens.paddingBlockSmall;
  double get paddingBlockMedium => spaceTokens.paddingBlockMedium;
  double get paddingBlockLarge => spaceTokens.paddingBlockLarge;
  double get paddingBlockExtraLarge => spaceTokens.paddingBlockXlarge;
  double get paddingBlockTwoExtraLarge => spaceTokens.paddingBlock2xlarge;
  double get paddingBlockThreeExtraLarge => spaceTokens.paddingBlock3xlarge;
  double get paddingBlockFourExtraLarge => spaceTokens.paddingBlock4xlarge;
  double get insetNone => spaceTokens.insetNone;
  double get insetFourExtraSmall => spaceTokens.inset4xsmall;
  double get insetThreeExtraSmall => spaceTokens.inset3xsmall;
  double get insetTwoExtraSmall => spaceTokens.inset2xsmall;
  double get insetExtraSmall => spaceTokens.insetXsmall;
  double get insetSmall => spaceTokens.insetSmall;
  double get insetMedium => spaceTokens.insetMedium;
  double get insetLarge => spaceTokens.insetLarge;
  double get insetExtraLarger => spaceTokens.insetXlarge;
  double get insetTwoExtraLarge => spaceTokens.inset2xlarge;
  double get insetThreeExtraLarge => spaceTokens.inset3xlarge;
  double get columnGapNone => spaceTokens.columnGapNone;
  double get columnGapThreeExtraSmall => spaceTokens.columnGap3xsmall;
  double get columnGapTwoExtraSmall => spaceTokens.columnGap2xsmall;
  double get columnGapExtraSmall => spaceTokens.columnGapXsmall;
  double get columnGapSmall => spaceTokens.columnGapSmall;
  double get columnGapMedium => spaceTokens.columnGapMedium;
  double get columnGapLarge => spaceTokens.columnGapLarge;
  double get columnGapExtraLarge => spaceTokens.columnGapXlarge;
  double get columnGapTwoExtraLarge => spaceTokens.columnGap2xlarge;
  double get rowGapNone => spaceTokens.rowGapNone;
  double get rowGapThreeExtraSmall => spaceTokens.rowGap3xsmall;
  double get rowGapTwoExtraSmall => spaceTokens.rowGap2xsmall;
  double get rowGapExtraSmall => spaceTokens.rowGapXsmall;
  double get rowGapSmall => spaceTokens.rowGapSmall;
  double get rowGapMedium => spaceTokens.rowGapMedium;
  double get rowGapLarge => spaceTokens.rowGapLarge;
}
