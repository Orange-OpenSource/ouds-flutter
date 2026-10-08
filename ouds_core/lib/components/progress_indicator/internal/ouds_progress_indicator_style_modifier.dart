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
/// @nodoc
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/progress_indicator/ouds_progress_indicator.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Class used to apply style modifications to progress indicators.
class OudsProgressIndicatorStyleModifier {
  final BuildContext context;

  /// Constructor that takes the build context.
  OudsProgressIndicatorStyleModifier(this.context);

  /// Gets the border radius for a progress indicator based on the theme configuration.
  BorderRadius getBorderRadius() {
    return BorderRadius.circular(getDoubleBorderRadius());
  }

  /// Retrieves the border radius value depending on whether rounded corners are enabled.
  double getDoubleBorderRadius() {
    final progressIndicatorTokens = OudsTheme.of(
      context,
    ).componentsTokens(context).progressIndicator;
    final progressIndicatorRounded =
        OudsThemeConfigModel.of(context)?.progressIndicator?.rounded ?? false;
    switch (progressIndicatorRounded) {
      case true:
        return progressIndicatorTokens.borderRadiusRounded;
      case false:
        return progressIndicatorTokens.borderRadiusDefault;
    }
  }

  /// Computes the gap size for the progress indicator based on the specified size type.
  ///
  /// For the default size with [StrokeCap.butt], it converts a 10-degree angle into a
  /// distance on the circle. For [StrokeCap.round], it returns a fixed value per size.
  double computeGapSize(OudsProgressIndicatorGapSize gapSizeType) {
    final strokeCap = getStrokeCap(gapSizeType);

    if (strokeCap == StrokeCap.butt) {
      return gapSizeType == OudsProgressIndicatorGapSize.defaultSize
          ? 1 / 360 * math.pi
          : 0;
    }

    return switch (gapSizeType) {
      OudsProgressIndicatorGapSize.defaultSize => 4,
      OudsProgressIndicatorGapSize.small => 1,
    };
  }

  /// Returns the gap size for a linear progress indicator.
  /// - defaultSize: 4.0 dp (M3 default, matching Android).
  /// - small: 1.0 dp (smaller but visible).
  double linearGapSize(OudsProgressIndicatorGapSize gapSizeType) {
    return gapSizeType == OudsProgressIndicatorGapSize.defaultSize ? 4.0 : 1.0;
  }

  /// Determines the stroke cap style based on the border radius and gap size.
  StrokeCap getStrokeCap(OudsProgressIndicatorGapSize gapSizeType) {
    final radius = getDoubleBorderRadius();

    return radius > 0.0 ? StrokeCap.round : StrokeCap.butt;
  }

  /// Gets the track color for the progress indicator.
  ///
  /// Returns the theme's content track color if `track` is true; otherwise, transparent.
  Color getTrackColor(bool track) {
    final trackColor = OudsTheme.of(
      context,
    ).componentsTokens(context).progressIndicatorMono.colorContentTrack;
    return track ? trackColor : Colors.transparent;
  }
}
