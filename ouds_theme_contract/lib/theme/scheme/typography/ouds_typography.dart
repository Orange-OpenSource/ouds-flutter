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
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_window_size_class.dart';

/// Provides responsive text styles based on the OUDS design system.
///
/// The [OudsTypography] class offers a centralized and scalable way to define and access
/// typography styles that adapt to the screen size (mobile vs tablet).
///
/// These styles rely on the current [OudsWindowWidthSizeClass] and design tokens
/// defined in [OudsFontSemanticTokens] from the [OudsTheme].
///
/// ### Usage example:
///
/// ```dart
/// Text(
///   'Page title',
///   style: OudsTheme.of(context).typographyTokens.typeDisplayLarge(context),
/// );
/// ```
///
/// ### Responsive behavior:
///
/// Internally, styles are adapted using [OudsWindowSizeClassUtil] to determine the current
/// device size class (extraCompact, compact, or medium), and values are selected
/// accordingly via `selectMobileTablet`.
///
/// You can override any parameter (e.g., `color`) using `.copyWith()`:
///
/// ```dart
/// OudsTheme.of(context).typographyTokens.typeDisplayLarge(context).copyWith(color: OudsTheme.of(context).colorScheme(context).contentMuted)
/// ```
///
class OudsTypography {
  TextStyle typeDisplayLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeDisplayLargeMobile,
        tablet: theme.fontTokens.sizeDisplayLargeTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingDisplayLargeMobile,
        tablet: theme.fontTokens.letterSpacingDisplayLargeTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightDisplayLargeMobile /
            theme.fontTokens.sizeDisplayLargeMobile,
        tablet: theme.fontTokens.lineHeightDisplayLargeTablet /
            theme.fontTokens.sizeDisplayLargeTablet,
      ),
      fontWeight: theme.fontTokens.weightHeading,
    );
  }

  /// Display
  TextStyle typeDisplayMedium(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeDisplayMediumMobile,
        tablet: theme.fontTokens.sizeDisplayMediumTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingDisplayMediumMobile,
        tablet: theme.fontTokens.letterSpacingDisplayMediumTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightDisplayMediumMobile /
            theme.fontTokens.sizeDisplayMediumMobile,
        tablet: theme.fontTokens.lineHeightDisplayMediumTablet /
            theme.fontTokens.sizeDisplayMediumTablet,
      ),
      fontWeight: theme.fontTokens.weightHeading,
    );
  }

  TextStyle typeDisplaySmall(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeDisplaySmallMobile,
        tablet: theme.fontTokens.sizeDisplaySmallTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingDisplaySmallMobile,
        tablet: theme.fontTokens.letterSpacingDisplaySmallTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightDisplaySmallMobile /
            theme.fontTokens.sizeDisplaySmallMobile,
        tablet: theme.fontTokens.lineHeightDisplaySmallTablet /
            theme.fontTokens.sizeDisplaySmallTablet,
      ),
      fontWeight: theme.fontTokens.weightHeading,
    );
  }

  /// Heading
  TextStyle typeHeadingXLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeHeadingXlargeMobile,
        tablet: theme.fontTokens.sizeHeadingXlargeTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingHeadingXlargeMobile,
        tablet: theme.fontTokens.letterSpacingHeadingXlargeTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightHeadingXlargeMobile /
            theme.fontTokens.sizeHeadingXlargeMobile,
        tablet: theme.fontTokens.lineHeightHeadingXlargeTablet /
            theme.fontTokens.sizeHeadingXlargeTablet,
      ),
      fontWeight: theme.fontTokens.weightHeading,
    );
  }

  TextStyle typeHeadingLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeHeadingLargeMobile,
        tablet: theme.fontTokens.sizeHeadingLargeTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingHeadingLargeMobile,
        tablet: theme.fontTokens.letterSpacingHeadingLargeTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightHeadingLargeMobile /
            theme.fontTokens.sizeHeadingLargeMobile,
        tablet: theme.fontTokens.lineHeightHeadingLargeTablet /
            theme.fontTokens.sizeHeadingLargeTablet,
      ),
      fontWeight: theme.fontTokens.weightHeading,
    );
  }

  TextStyle typeHeadingMedium(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeHeadingMediumMobile,
        tablet: theme.fontTokens.sizeHeadingMediumTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingHeadingMediumMobile,
        tablet: theme.fontTokens.letterSpacingHeadingMediumTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightHeadingMediumMobile /
            theme.fontTokens.sizeHeadingMediumMobile,
        tablet: theme.fontTokens.lineHeightHeadingMediumTablet /
            theme.fontTokens.sizeHeadingMediumTablet,
      ),
      fontWeight: theme.fontTokens.weightHeading,
    );
  }

  TextStyle typeHeadingSmall(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeHeadingSmallMobile,
        tablet: theme.fontTokens.sizeHeadingSmallTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingHeadingSmallMobile,
        tablet: theme.fontTokens.letterSpacingHeadingSmallTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightHeadingSmallMobile /
            theme.fontTokens.sizeHeadingSmallMobile,
        tablet: theme.fontTokens.lineHeightHeadingSmallTablet /
            theme.fontTokens.sizeHeadingSmallTablet,
      ),
      fontWeight: theme.fontTokens.weightHeading,
    );
  }

  /// Body Default
  TextStyle typeBodyDefaultLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeBodyLargeMobile,
        tablet: theme.fontTokens.sizeBodyLargeTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingBodyLargeMobile,
        tablet: theme.fontTokens.letterSpacingBodyLargeTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightBodyLargeMobile /
            theme.fontTokens.sizeBodyLargeMobile,
        tablet: theme.fontTokens.lineHeightBodyLargeTablet /
            theme.fontTokens.sizeBodyLargeTablet,
      ),
      fontWeight: theme.fontTokens.weightBodyDefault,
    );
  }

  TextStyle typeBodyDefaultMedium(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeBodyMediumMobile,
        tablet: theme.fontTokens.sizeBodyMediumTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingBodyMediumMobile,
        tablet: theme.fontTokens.letterSpacingBodyMediumTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightBodyMediumMobile /
            theme.fontTokens.sizeBodyMediumMobile,
        tablet: theme.fontTokens.lineHeightBodyMediumTablet /
            theme.fontTokens.sizeBodyMediumTablet,
      ),
      fontWeight: theme.fontTokens.weightBodyDefault,
    );
  }

  TextStyle typeBodyDefaultSmall(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeBodySmallMobile,
        tablet: theme.fontTokens.sizeBodySmallTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingBodySmallMobile,
        tablet: theme.fontTokens.letterSpacingBodySmallTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightBodySmallMobile /
            theme.fontTokens.sizeBodySmallMobile,
        tablet: theme.fontTokens.lineHeightBodySmallTablet /
            theme.fontTokens.sizeBodySmallTablet,
      ),
      fontWeight: theme.fontTokens.weightBodyDefault,
    );
  }

  /// Body Strong
  TextStyle typeBodyStrongLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeBodyLargeTablet,
        tablet: theme.fontTokens.sizeBodyLargeTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingBodyLargeMobile,
        tablet: theme.fontTokens.letterSpacingBodyLargeTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightBodyLargeMobile /
            theme.fontTokens.sizeBodyLargeMobile,
        tablet: theme.fontTokens.lineHeightBodyLargeTablet /
            theme.fontTokens.sizeBodyLargeTablet,
      ),
      fontWeight: theme.fontTokens.weightBodyStrong,
    );
  }

  TextStyle typeBodyStrongMedium(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeBodyMediumTablet,
        tablet: theme.fontTokens.sizeBodyMediumTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingBodyMediumMobile,
        tablet: theme.fontTokens.letterSpacingBodyMediumTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightBodyMediumMobile /
            theme.fontTokens.sizeBodyMediumMobile,
        tablet: theme.fontTokens.lineHeightBodyMediumTablet /
            theme.fontTokens.sizeBodyMediumTablet,
      ),
      fontWeight: theme.fontTokens.weightBodyStrong,
    );
  }

  TextStyle typeBodyStrongSmall(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeBodySmallTablet,
        tablet: theme.fontTokens.sizeBodySmallTablet,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingBodySmallMobile,
        tablet: theme.fontTokens.letterSpacingBodySmallTablet,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightBodySmallMobile /
            theme.fontTokens.sizeBodySmallMobile,
        tablet: theme.fontTokens.lineHeightBodySmallTablet /
            theme.fontTokens.sizeBodySmallTablet,
      ),
      fontWeight: theme.fontTokens.weightBodyStrong,
    );
  }

  /// Label Default
  TextStyle typeLabelDefaultXLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeLabelXlarge,
        tablet: theme.fontTokens.sizeLabelXlarge,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingLabelXlarge,
        tablet: theme.fontTokens.letterSpacingLabelXlarge,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightLabelXlarge /
            theme.fontTokens.sizeLabelXlarge,
        tablet: theme.fontTokens.lineHeightLabelXlarge /
            theme.fontTokens.sizeLabelXlarge,
      ),
      fontWeight: theme.fontTokens.weightLabelDefault,
    );
  }

  TextStyle typeLabelDefaultLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeLabelLarge,
        tablet: theme.fontTokens.sizeLabelLarge,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingLabelLarge,
        tablet: theme.fontTokens.letterSpacingLabelLarge,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightLabelLarge /
            theme.fontTokens.sizeLabelLarge,
        tablet: theme.fontTokens.lineHeightLabelLarge /
            theme.fontTokens.sizeLabelLarge,
      ),
      fontWeight: theme.fontTokens.weightLabelDefault,
    );
  }

  TextStyle typeLabelDefaultMedium(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeLabelMedium,
        tablet: theme.fontTokens.sizeLabelMedium,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingLabelMedium,
        tablet: theme.fontTokens.letterSpacingLabelMedium,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightLabelMedium /
            theme.fontTokens.sizeLabelMedium,
        tablet: theme.fontTokens.lineHeightLabelMedium /
            theme.fontTokens.sizeLabelMedium,
      ),
      fontWeight: theme.fontTokens.weightLabelDefault,
    );
  }

  TextStyle typeLabelDefaultSmall(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeLabelSmall,
        tablet: theme.fontTokens.sizeLabelSmall,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingLabelSmall,
        tablet: theme.fontTokens.letterSpacingLabelSmall,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightLabelSmall /
            theme.fontTokens.sizeLabelSmall,
        tablet: theme.fontTokens.lineHeightLabelSmall /
            theme.fontTokens.sizeLabelSmall,
      ),
      fontWeight: theme.fontTokens.weightLabelDefault,
    );
  }

  /// Label Strong
  TextStyle typeLabelStrongXLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeLabelXlarge,
        tablet: theme.fontTokens.sizeLabelXlarge,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingLabelXlarge,
        tablet: theme.fontTokens.letterSpacingLabelXlarge,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightLabelXlarge /
            theme.fontTokens.sizeLabelXlarge,
        tablet: theme.fontTokens.lineHeightLabelXlarge /
            theme.fontTokens.sizeLabelXlarge,
      ),
      fontWeight: theme.fontTokens.weightLabelStrong,
    );
  }

  TextStyle typeLabelStrongLarge(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeLabelLarge,
        tablet: theme.fontTokens.sizeLabelLarge,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingLabelLarge,
        tablet: theme.fontTokens.letterSpacingLabelLarge,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightLabelLarge /
            theme.fontTokens.sizeLabelLarge,
        tablet: theme.fontTokens.lineHeightLabelLarge /
            theme.fontTokens.sizeLabelLarge,
      ),
      fontWeight: theme.fontTokens.weightLabelStrong,
    );
  }

  TextStyle typeLabelStrongMedium(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeLabelMedium,
        tablet: theme.fontTokens.sizeLabelMedium,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingLabelMedium,
        tablet: theme.fontTokens.letterSpacingLabelMedium,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightLabelMedium /
            theme.fontTokens.sizeLabelMedium,
        tablet: theme.fontTokens.lineHeightLabelMedium /
            theme.fontTokens.sizeLabelMedium,
      ),
      fontWeight: theme.fontTokens.weightLabelStrong,
    );
  }

  TextStyle typeLabelStrongSmall(BuildContext context) {
    final sizeClass = OudsWindowSizeClassUtil.of(context);
    final theme = OudsTheme.of(context);

    return TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.sizeLabelSmall,
        tablet: theme.fontTokens.sizeLabelSmall,
      ),
      letterSpacing: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.letterSpacingLabelSmall,
        tablet: theme.fontTokens.letterSpacingLabelSmall,
      ),
      height: OudsWindowSizeClassUtil.selectMobileTablet(
        sizeClass: sizeClass,
        mobile: theme.fontTokens.lineHeightLabelSmall /
            theme.fontTokens.sizeLabelSmall,
        tablet: theme.fontTokens.lineHeightLabelSmall /
            theme.fontTokens.sizeLabelSmall,
      ),
      fontWeight: theme.fontTokens.weightLabelStrong,
    );
  }
}
