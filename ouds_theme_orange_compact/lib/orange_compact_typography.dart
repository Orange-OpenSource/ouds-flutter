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
/// This class extends [OudsTypography] and applies the `.withHelveticaWeight()`
/// extension to all text styles to ensure proper Helvetica Neue font variants
/// are used based on the font weight.
class OrangeCompactTypography extends OudsTypography {
  @override
  TextStyle typeDisplayLarge(BuildContext context) {
    return super.typeDisplayLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeDisplayMedium(BuildContext context) {
    return super.typeDisplayMedium(context).withHelveticaWeight();
  }

  @override
  TextStyle typeDisplaySmall(BuildContext context) {
    return super.typeDisplaySmall(context).withHelveticaWeight();
  }

  @override
  TextStyle typeHeadingXLarge(BuildContext context) {
    return super.typeHeadingXLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeHeadingLarge(BuildContext context) {
    return super.typeHeadingLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeHeadingMedium(BuildContext context) {
    return super.typeHeadingMedium(context).withHelveticaWeight();
  }

  @override
  TextStyle typeHeadingSmall(BuildContext context) {
    return super.typeHeadingSmall(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyDefaultLarge(BuildContext context) {
    return super.typeBodyDefaultLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyDefaultMedium(BuildContext context) {
    return super.typeBodyDefaultMedium(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyDefaultSmall(BuildContext context) {
    return super.typeBodyDefaultSmall(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyModerateLarge(BuildContext context) {
    return super.typeBodyModerateLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyModerateMedium(BuildContext context) {
    return super.typeBodyModerateMedium(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyModerateSmall(BuildContext context) {
    return super.typeBodyModerateSmall(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyStrongLarge(BuildContext context) {
    return super.typeBodyStrongLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyStrongMedium(BuildContext context) {
    return super.typeBodyStrongMedium(context).withHelveticaWeight();
  }

  @override
  TextStyle typeBodyStrongSmall(BuildContext context) {
    return super.typeBodyStrongSmall(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelDefaultXLarge(BuildContext context) {
    return super.typeLabelDefaultXLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelDefaultLarge(BuildContext context) {
    return super.typeLabelDefaultLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelDefaultMedium(BuildContext context) {
    return super.typeLabelDefaultMedium(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelDefaultSmall(BuildContext context) {
    return super.typeLabelDefaultSmall(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelModerateXLarge(BuildContext context) {
    return super.typeLabelModerateXLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelModerateLarge(BuildContext context) {
    return super.typeLabelModerateLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelModerateMedium(BuildContext context) {
    return super.typeLabelModerateMedium(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelModerateSmall(BuildContext context) {
    return super.typeLabelModerateSmall(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelStrongXLarge(BuildContext context) {
    return super.typeLabelStrongXLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelStrongLarge(BuildContext context) {
    return super.typeLabelStrongLarge(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelStrongMedium(BuildContext context) {
    return super.typeLabelStrongMedium(context).withHelveticaWeight();
  }

  @override
  TextStyle typeLabelStrongSmall(BuildContext context) {
    return super.typeLabelStrongSmall(context).withHelveticaWeight();
  }
}
