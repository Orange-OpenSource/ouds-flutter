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

/// Lightweight wrapper for OudsTypography that applies Orange font family mapping.
///
/// This class delegates to [OudsTypography] and applies [withOrangeFont()] extension
/// to map font weights to correct Helvetica Neue family names.
class OrangeTypography extends OudsTypography {
  @override
  TextStyle typeDisplayLarge(BuildContext context) => super.typeDisplayLarge(context).withOrangeFont();

  @override
  TextStyle typeDisplayMedium(BuildContext context) => super.typeDisplayMedium(context).withOrangeFont();

  @override
  TextStyle typeDisplaySmall(BuildContext context) => super.typeDisplaySmall(context).withOrangeFont();

  @override
  TextStyle typeHeadingXLarge(BuildContext context) => super.typeHeadingXLarge(context).withOrangeFont();

  @override
  TextStyle typeHeadingLarge(BuildContext context) => super.typeHeadingLarge(context).withOrangeFont();

  @override
  TextStyle typeHeadingMedium(BuildContext context) => super.typeHeadingMedium(context).withOrangeFont();

  @override
  TextStyle typeHeadingSmall(BuildContext context) => super.typeHeadingSmall(context).withOrangeFont();

  @override
  TextStyle typeBodyDefaultLarge(BuildContext context) => super.typeBodyDefaultLarge(context).withOrangeFont();

  @override
  TextStyle typeBodyDefaultMedium(BuildContext context) => super.typeBodyDefaultMedium(context).withOrangeFont();

  @override
  TextStyle typeBodyDefaultSmall(BuildContext context) => super.typeBodyDefaultSmall(context).withOrangeFont();

  @override
  TextStyle typeBodyModerateLarge(BuildContext context) => super.typeBodyModerateLarge(context).withOrangeFont();

  @override
  TextStyle typeBodyModerateMedium(BuildContext context) => super.typeBodyModerateMedium(context).withOrangeFont();

  @override
  TextStyle typeBodyModerateSmall(BuildContext context) => super.typeBodyModerateSmall(context).withOrangeFont();

  @override
  TextStyle typeBodyStrongLarge(BuildContext context) => super.typeBodyStrongLarge(context).withOrangeFont();

  @override
  TextStyle typeBodyStrongMedium(BuildContext context) => super.typeBodyStrongMedium(context).withOrangeFont();

  @override
  TextStyle typeBodyStrongSmall(BuildContext context) => super.typeBodyStrongSmall(context).withOrangeFont();

  @override
  TextStyle typeLabelDefaultXLarge(BuildContext context) => super.typeLabelDefaultXLarge(context).withOrangeFont();

  @override
  TextStyle typeLabelDefaultLarge(BuildContext context) => super.typeLabelDefaultLarge(context).withOrangeFont();

  @override
  TextStyle typeLabelDefaultMedium(BuildContext context) => super.typeLabelDefaultMedium(context).withOrangeFont();

  @override
  TextStyle typeLabelDefaultSmall(BuildContext context) => super.typeLabelDefaultSmall(context).withOrangeFont();

  @override
  TextStyle typeLabelModerateXLarge(BuildContext context) => super.typeLabelModerateXLarge(context).withOrangeFont();

  @override
  TextStyle typeLabelModerateLarge(BuildContext context) => super.typeLabelModerateLarge(context).withOrangeFont();

  @override
  TextStyle typeLabelModerateMedium(BuildContext context) => super.typeLabelModerateMedium(context).withOrangeFont();

  @override
  TextStyle typeLabelModerateSmall(BuildContext context) => super.typeLabelModerateSmall(context).withOrangeFont();

  @override
  TextStyle typeLabelStrongXLarge(BuildContext context) => super.typeLabelStrongXLarge(context).withOrangeFont();

  @override
  TextStyle typeLabelStrongLarge(BuildContext context) => super.typeLabelStrongLarge(context).withOrangeFont();

  @override
  TextStyle typeLabelStrongMedium(BuildContext context) => super.typeLabelStrongMedium(context).withOrangeFont();

  @override
  TextStyle typeLabelStrongSmall(BuildContext context) => super.typeLabelStrongSmall(context).withOrangeFont();
}
