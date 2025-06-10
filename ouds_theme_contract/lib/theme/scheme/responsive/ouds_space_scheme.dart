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
  double get scaledMedium => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledMediumMobile,
        tablet: spaceTokens.scaledMediumTablet,
      );
  double get scaledNone => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledNoneMobile,
        tablet: spaceTokens.scaledNoneTablet,
      );
  double get scaledShort => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledShortMobile,
        tablet: spaceTokens.scaledShortTablet,
      );
  double get scaledShorter => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledShorterMobile,
        tablet: spaceTokens.scaledShorterTablet,
      );
  double get scaledShortest => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledShortestMobile,
        tablet: spaceTokens.scaledShortestTablet,
      );
  double get scaledSmash => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledSmashMobile,
        tablet: spaceTokens.scaledSmashTablet,
      );
  double get scaledSpacious => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledSpaciousMobile,
        tablet: spaceTokens.scaledSpaciousTablet,
      );
  double get scaledTall => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledTallMobile,
        tablet: spaceTokens.scaledTallTablet,
      );
  double get scaledTaller => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledTallerMobile,
        tablet: spaceTokens.scaledTallerTablet,
      );
  double get scaledTallest => OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: spaceTokens.scaledTallestMobile,
        tablet: spaceTokens.scaledTallestTablet,
      );

  /// Non-responsive tokens (direct mapping)
  double get columnGapMedium => spaceTokens.columnGapMedium;
  double get columnGapNone => spaceTokens.columnGapNone;
  double get columnGapShort => spaceTokens.columnGapShort;
  double get columnGapShorter => spaceTokens.columnGapShorter;
  double get columnGapShortest => spaceTokens.columnGapShortest;
  double get columnGapSmash => spaceTokens.columnGapSmash;
  double get columnGapTall => spaceTokens.columnGapTall;
  double get columnGapTaller => spaceTokens.columnGapTaller;
  double get columnGapTallest => spaceTokens.columnGapTallest;
  double get fixedHuge => spaceTokens.fixedHuge;
  double get fixedJumbo => spaceTokens.fixedJumbo;
  double get fixedMedium => spaceTokens.fixedMedium;
  double get fixedNone => spaceTokens.fixedNone;
  double get fixedShort => spaceTokens.fixedShort;
  double get fixedShorter => spaceTokens.fixedShorter;
  double get fixedShortest => spaceTokens.fixedShortest;
  double get fixedSmash => spaceTokens.fixedSmash;
  double get fixedSpacious => spaceTokens.fixedSpacious;
  double get fixedTall => spaceTokens.fixedTall;
  double get fixedTaller => spaceTokens.fixedTaller;
  double get fixedTallest => spaceTokens.fixedTallest;
  double get insetMedium => spaceTokens.insetMedium;
  double get insetNone => spaceTokens.insetNone;
  double get insetShort => spaceTokens.insetShort;
  double get insetShorter => spaceTokens.insetShorter;
  double get insetShortest => spaceTokens.insetShortest;
  double get insetSmash => spaceTokens.insetSmash;
  double get insetSpacious => spaceTokens.insetSpacious;
  double get insetTall => spaceTokens.insetTall;
  double get insetTaller => spaceTokens.insetTaller;
  double get insetTallest => spaceTokens.insetTallest;
  double get paddingBlockHuge => spaceTokens.paddingBlockHuge;
  double get paddingBlockMedium => spaceTokens.paddingBlockMedium;
  double get paddingBlockNone => spaceTokens.paddingBlockNone;
  double get paddingBlockShort => spaceTokens.paddingBlockShort;
  double get paddingBlockShorter => spaceTokens.paddingBlockShorter;
  double get paddingBlockShortest => spaceTokens.paddingBlockShortest;
  double get paddingBlockSmash => spaceTokens.paddingBlockSmash;
  double get paddingBlockSpacious => spaceTokens.paddingBlockSpacious;
  double get paddingBlockTall => spaceTokens.paddingBlockTall;
  double get paddingBlockTaller => spaceTokens.paddingBlockTaller;
  double get paddingBlockTallest => spaceTokens.paddingBlockTallest;
  double get paddingInlineHuge => spaceTokens.paddingInlineHuge;
  double get paddingInlineMedium => spaceTokens.paddingInlineMedium;
  double get paddingInlineNone => spaceTokens.paddingInlineNone;
  double get paddingInlineShort => spaceTokens.paddingInlineShort;
  double get paddingInlineShorter => spaceTokens.paddingInlineShorter;
  double get paddingInlineShortest => spaceTokens.paddingInlineShortest;
  double get paddingInlineSmash => spaceTokens.paddingInlineSmash;
  double get paddingInlineSpacious => spaceTokens.paddingInlineSpacious;
  double get paddingInlineTall => spaceTokens.paddingInlineTall;
  double get paddingInlineTaller => spaceTokens.paddingInlineTaller;
  double get paddingInlineTallest => spaceTokens.paddingInlineTallest;
  double get rowGapMedium => spaceTokens.rowGapMedium;
  double get rowGapNone => spaceTokens.rowGapNone;
  double get rowGapShort => spaceTokens.rowGapShort;
  double get rowGapShorter => spaceTokens.rowGapShorter;
  double get rowGapShortest => spaceTokens.rowGapShortest;
  double get rowGapSmash => spaceTokens.rowGapSmash;
  double get rowGapTall => spaceTokens.rowGapTall;
}
