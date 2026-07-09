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
  ///
  /// Returns a [BorderRadius] object with the appropriate radius value.
  BorderRadius getBorderRadius() {
    return BorderRadius.circular(getDoubleBorderRadius());
  }

  /// Retrieves the border radius value depending on whether rounded corners are enabled.
  ///
  /// Checks the theme configuration for the `rounded` property and returns the corresponding radius.
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
  /// For the default size, it converts a 10-degree angle into a distance on the circle.
  /// For small gaps, it returns a fixed value.
  double computeGapSize(OudsProgressIndicatorGapSize gapSizeType) {
    final gapStroke = getStrokeCap(gapSizeType);
    return gapSizeType == OudsProgressIndicatorGapSize.defaultSize &&
            gapStroke == StrokeCap.butt
        ? 1 / 360 * math.pi
        : gapSizeType == OudsProgressIndicatorGapSize.defaultSize &&
              gapStroke == StrokeCap.round
        ? 4
        : 1;
  }

  /// Returns the gap size used by a linear progress indicator.
  double linearGapSize(OudsProgressIndicatorGapSize gapSizeType) {
    return gapSizeType == OudsProgressIndicatorGapSize.defaultSize ? 4 : 1;
  }

  /// Calculates the stroke width based on the component size.
  /// The stroke width is equal to 25% of the radius, 12.5% of the diameter.
  double computeStrokeWidth(double componentSize) {
    return componentSize * 0.125;
  }

  /// Determines the stroke cap style based on the border radius and gap size.
  ///
  /// Uses a round stroke cap if the radius is greater than zero.
  /// Otherwise, chooses between square or butt caps depending on the gap size.
  StrokeCap getStrokeCap(OudsProgressIndicatorGapSize gapSizeType) {
    final radius = getDoubleBorderRadius();

    return radius > 0.0
        ? StrokeCap.round
        : gapSizeType == OudsProgressIndicatorGapSize.small
        ? StrokeCap.square
        : StrokeCap.butt;
  }

  /// Returns the stroke cap used by the linear progress indicator.
  StrokeCap getLinearStrokeCap(OudsProgressIndicatorGapSize gapSizeType) {
    final radius = getDoubleBorderRadius();
    return radius > 0.0 ? StrokeCap.round : StrokeCap.square;
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
