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

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/theme/scheme/typography/ouds_typography.dart';
import 'package:ouds_theme_orange/orange_font_helper.dart';

/// Orange-specific typography that applies Helvetica font weight adjustments.
///
/// This class extends [OudsTypography] and applies the `.withOrangeFont()`
/// extension to all text styles to ensure proper Helvetica Neue font variants
/// are used based on the font weight.
class OrangeCompactTypography extends OudsTypography {
  @override
  TextStyle typeDisplayLarge(BuildContext context) {
    return super.typeDisplayLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeDisplayMedium(BuildContext context) {
    return super.typeDisplayMedium(context).withOrangeFont();
  }

  @override
  TextStyle typeDisplaySmall(BuildContext context) {
    return super.typeDisplaySmall(context).withOrangeFont();
  }

  @override
  TextStyle typeHeadingXLarge(BuildContext context) {
    return super.typeHeadingXLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeHeadingLarge(BuildContext context) {
    return super.typeHeadingLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeHeadingMedium(BuildContext context) {
    return super.typeHeadingMedium(context).withOrangeFont();
  }

  @override
  TextStyle typeHeadingSmall(BuildContext context) {
    return super.typeHeadingSmall(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyDefaultLarge(BuildContext context) {
    return super.typeBodyDefaultLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyDefaultMedium(BuildContext context) {
    return super.typeBodyDefaultMedium(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyDefaultSmall(BuildContext context) {
    return super.typeBodyDefaultSmall(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyModerateLarge(BuildContext context) {
    return super.typeBodyModerateLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyModerateMedium(BuildContext context) {
    return super.typeBodyModerateMedium(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyModerateSmall(BuildContext context) {
    return super.typeBodyModerateSmall(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyStrongLarge(BuildContext context) {
    return super.typeBodyStrongLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyStrongMedium(BuildContext context) {
    return super.typeBodyStrongMedium(context).withOrangeFont();
  }

  @override
  TextStyle typeBodyStrongSmall(BuildContext context) {
    return super.typeBodyStrongSmall(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelDefaultXLarge(BuildContext context) {
    return super.typeLabelDefaultXLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelDefaultLarge(BuildContext context) {
    return super.typeLabelDefaultLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelDefaultMedium(BuildContext context) {
    return super.typeLabelDefaultMedium(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelDefaultSmall(BuildContext context) {
    return super.typeLabelDefaultSmall(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelModerateXLarge(BuildContext context) {
    return super.typeLabelModerateXLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelModerateLarge(BuildContext context) {
    return super.typeLabelModerateLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelModerateMedium(BuildContext context) {
    return super.typeLabelModerateMedium(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelModerateSmall(BuildContext context) {
    return super.typeLabelModerateSmall(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelStrongXLarge(BuildContext context) {
    return super.typeLabelStrongXLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelStrongLarge(BuildContext context) {
    return super.typeLabelStrongLarge(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelStrongMedium(BuildContext context) {
    return super.typeLabelStrongMedium(context).withOrangeFont();
  }

  @override
  TextStyle typeLabelStrongSmall(BuildContext context) {
    return super.typeLabelStrongSmall(context).withOrangeFont();
  }
}
