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

/// {@category Progress indicator}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/progress_indicator/internal/ouds_progress_indicator_status_modifier.dart';
import 'package:ouds_core/components/progress_indicator/internal/ouds_progress_indicator_style_modifier.dart';

enum OudsCircularIndicatorGapSize { defaultSize, small }

// TODO Update description and add design guideline link when available
///
/// **Reference design version : 1.0.0**
///
/// A Circular Progress Indicator shows the progress of a task using a circle. Useful when you need more visual focus or when space is limited.
///
/// This version of the circular progress indicator is **determinate**. Use the other signature for an indeterminate progress.
///
/// The component automatically scales all dimensions (stroke width, gap size) proportionally based on its effective size
/// (after applying the modifier). A scale factor is calculated by dividing the actual size by the default size from tokens,
/// then this scale is applied to all dimensions to maintain consistent proportions.
///
/// Parameters:
///
/// - [status]: Represents the visual status of the indicator (e.g., success, error, neutral).
/// - [animated]: If true, enables animation when updating the progress.
/// - [progress]: The current progress value, between 0.0 and 1.0. If null, the indicator is indeterminate.
/// - [gapSize]: The size of the gap in the circular indicator [OudsCircularIndicatorGapSize].
/// - [track]: If true, displays the track (background) of the indicator.
/// - [semanticLabel]: Semantic label for accessibility.
///
class OudsCircularProgressIndicator extends StatelessWidget {
  final OudsIconStatus status;
  final bool animated;
  final double? progress;
  final OudsCircularIndicatorGapSize gapSize;
  final bool track;
  final String semanticLabel;

  const OudsCircularProgressIndicator({
    super.key,
    this.status = const Neutral(),
    this.animated = true,
    this.progress,
    this.gapSize = OudsCircularIndicatorGapSize.defaultSize,
    this.track = true,
    this.semanticLabel = "progress",
  });

  /// Default size of the indicator (in pixels).
  static const double _oudsCircularProgressIndicatorSize = 48.0;

  @override
  Widget build(BuildContext context) {
    // Retrieve style and status modifiers
    final progressIndicatorStyleModifier = OudsProgressIndicatorStyleModifier(
      context,
    );
    final progressIndicatorStatusModifier = OudsProgressIndicatorStatusModifier(
      context,
    );
    final textScaler = MediaQuery.textScalerOf(context);
    final defaultSize = textScaler.scale(_oudsCircularProgressIndicatorSize);
    final gapSizeValue = progressIndicatorStyleModifier.computeGapSize(gapSize);
    final indicatorColor = progressIndicatorStatusModifier.getStatusColor(
      status,
    );
    final backgroundColor = progressIndicatorStyleModifier.getTrackColor(track);
    //Animated (for Determinate state only)
    final isDeterminateAnimated = progress != null;

    // Animated progress indicator for determinate state
    return isDeterminateAnimated && animated
        ? TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0,
              end: (progress ?? 0.0).clamp(0.0, 1.0),
            ),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) {
              return CircularProgressIndicator(
                semanticsLabel: semanticLabel,
                year2023: false,
                constraints: BoxConstraints(
                  minWidth: defaultSize,
                  minHeight: defaultSize,
                ),
                value: animatedValue,
                valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
                backgroundColor: backgroundColor,
                strokeWidth: progressIndicatorStyleModifier.computeStrokeWidth(
                  defaultSize,
                ),
                trackGap: gapSizeValue,
                strokeCap: progressIndicatorStyleModifier.getStrokeCap(gapSize),
              );
            },
          )
        // Non-animated indeterminate indicator
        : CircularProgressIndicator(
            semanticsLabel: semanticLabel,
            year2023: false,
            constraints: BoxConstraints(
              minWidth: defaultSize,
              minHeight: defaultSize,
            ),
            value: progress?.clamp(0.0, 1.0),
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
            backgroundColor: backgroundColor,
            strokeWidth: progressIndicatorStyleModifier.computeStrokeWidth(
              defaultSize,
            ),
            trackGap: gapSizeValue,
            strokeCap: progressIndicatorStyleModifier.getStrokeCap(gapSize),
          );
  }
}
