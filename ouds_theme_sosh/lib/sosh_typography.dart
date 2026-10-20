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

/// Lightweight wrapper for OudsTypography that qualifies the "Sosh" font family with its
/// declaring package.
///
/// The "Sosh" font is declared in the `ouds_theme_sosh` package's `pubspec.yaml`. Flutter
/// requires the `package` argument on [TextStyle] to resolve a font family declared in a
/// package other than the app itself; without it, the style silently falls back to the
/// platform default font. This is only needed for explicit [TextStyle]s built from
/// [OudsTypography] (e.g. used by `Text.rich`); ambient `Text` styling already works because
/// [ThemeData] is built with both `fontFamily` and `package`.
class SoshTypography extends OudsTypography {
  static const String _package = 'ouds_theme_sosh';

  @override
  TextStyle typeDisplayLarge(BuildContext context) =>
      super.typeDisplayLarge(context).copyWith(package: _package);

  @override
  TextStyle typeDisplayMedium(BuildContext context) =>
      super.typeDisplayMedium(context).copyWith(package: _package);

  @override
  TextStyle typeDisplaySmall(BuildContext context) =>
      super.typeDisplaySmall(context).copyWith(package: _package);

  @override
  TextStyle typeHeadingXLarge(BuildContext context) =>
      super.typeHeadingXLarge(context).copyWith(package: _package);

  @override
  TextStyle typeHeadingLarge(BuildContext context) =>
      super.typeHeadingLarge(context).copyWith(package: _package);

  @override
  TextStyle typeHeadingMedium(BuildContext context) =>
      super.typeHeadingMedium(context).copyWith(package: _package);

  @override
  TextStyle typeHeadingSmall(BuildContext context) =>
      super.typeHeadingSmall(context).copyWith(package: _package);

  @override
  TextStyle typeBodyDefaultLarge(BuildContext context) =>
      super.typeBodyDefaultLarge(context).copyWith(package: _package);

  @override
  TextStyle typeBodyDefaultMedium(BuildContext context) =>
      super.typeBodyDefaultMedium(context).copyWith(package: _package);

  @override
  TextStyle typeBodyDefaultSmall(BuildContext context) =>
      super.typeBodyDefaultSmall(context).copyWith(package: _package);

  @override
  TextStyle typeBodyModerateLarge(BuildContext context) =>
      super.typeBodyModerateLarge(context).copyWith(package: _package);

  @override
  TextStyle typeBodyModerateMedium(BuildContext context) =>
      super.typeBodyModerateMedium(context).copyWith(package: _package);

  @override
  TextStyle typeBodyModerateSmall(BuildContext context) =>
      super.typeBodyModerateSmall(context).copyWith(package: _package);

  @override
  TextStyle typeBodyStrongLarge(BuildContext context) =>
      super.typeBodyStrongLarge(context).copyWith(package: _package);

  @override
  TextStyle typeBodyStrongMedium(BuildContext context) =>
      super.typeBodyStrongMedium(context).copyWith(package: _package);

  @override
  TextStyle typeBodyStrongSmall(BuildContext context) =>
      super.typeBodyStrongSmall(context).copyWith(package: _package);

  @override
  TextStyle typeLabelDefaultXLarge(BuildContext context) =>
      super.typeLabelDefaultXLarge(context).copyWith(package: _package);

  @override
  TextStyle typeLabelDefaultLarge(BuildContext context) =>
      super.typeLabelDefaultLarge(context).copyWith(package: _package);

  @override
  TextStyle typeLabelDefaultMedium(BuildContext context) =>
      super.typeLabelDefaultMedium(context).copyWith(package: _package);

  @override
  TextStyle typeLabelDefaultSmall(BuildContext context) =>
      super.typeLabelDefaultSmall(context).copyWith(package: _package);

  @override
  TextStyle typeLabelModerateXLarge(BuildContext context) =>
      super.typeLabelModerateXLarge(context).copyWith(package: _package);

  @override
  TextStyle typeLabelModerateLarge(BuildContext context) =>
      super.typeLabelModerateLarge(context).copyWith(package: _package);

  @override
  TextStyle typeLabelModerateMedium(BuildContext context) =>
      super.typeLabelModerateMedium(context).copyWith(package: _package);

  @override
  TextStyle typeLabelModerateSmall(BuildContext context) =>
      super.typeLabelModerateSmall(context).copyWith(package: _package);

  @override
  TextStyle typeLabelStrongXLarge(BuildContext context) =>
      super.typeLabelStrongXLarge(context).copyWith(package: _package);

  @override
  TextStyle typeLabelStrongLarge(BuildContext context) =>
      super.typeLabelStrongLarge(context).copyWith(package: _package);

  @override
  TextStyle typeLabelStrongMedium(BuildContext context) =>
      super.typeLabelStrongMedium(context).copyWith(package: _package);

  @override
  TextStyle typeLabelStrongSmall(BuildContext context) =>
      super.typeLabelStrongSmall(context).copyWith(package: _package);
}
