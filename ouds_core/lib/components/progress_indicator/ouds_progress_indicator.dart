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
import 'package:ouds_core/components/progress_indicator/internal/ouds_progress_indicator_utils.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Defines whether a progress indicator shows a known progress value
/// or an ongoing operation with unknown duration.
enum OudsProgressIndicatorType { determinate, indeterminate }

/// Defines the spacing used between the active indicator and its track.
enum OudsProgressIndicatorGapSize { defaultSize, small }

/// Defines the horizontal alignment of helper text displayed below
/// a linear progress indicator.
enum OudsProgressIndicatorHelperTextAlignment { left, center, right }

/// Default size of the indicator (in pixels).
const double _oudsCircularProgressIndicatorSize = 48.0;

/// Default animation duration used when the determinate value changes.
const _animationDuration = Duration(milliseconds: 800);

/// A base class for [OudsProgressIndicator] Flutter Design progress indicators.
///
/// This widget cannot be instantiated directly. For a linear progress
/// indicator, see [OudsLinearProgressIndicator]. For a circular progress indicator,
/// see [OudsCircularProgressIndicator].
///
abstract class OudsProgressIndicator extends StatefulWidget {
  /// Creates a progress indicator.
  ///
  /// The [progress] argument should be a non-null value between 0.0 and 1.0 for a
  /// determinate progress indicator.
  ///
  /// ## Accessibility
  ///
  /// The [semanticLabel] can be used to identify the purpose of this progress
  /// bar for screen reading software.
  ///
  ///
  const OudsProgressIndicator({
    super.key,
    this.progressType = OudsProgressIndicatorType.determinate,
    this.status = const Neutral(),
    this.animated = true,
    this.progress,
    this.gapSize = OudsProgressIndicatorGapSize.defaultSize,
    this.track = true,
    this.semanticLabel,
  });

  final OudsProgressIndicatorType? progressType;
  final OudsIconStatus status;
  final bool animated;
  final double? progress;
  final OudsProgressIndicatorGapSize gapSize;
  final bool track;
  final String? semanticLabel;
}

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
/// - [progressType]: Defines whether the indicator is determinate or indeterminate.
/// - [status]: Represents the visual status of the indicator. Its color is based on this status.
/// Progress indicators can use different statuses depending on the meaning of the process they represent. Status colors should communicate the nature of the operation, not its completion percentage.
/// There are two types of statuses:
///   - Non-functional statuses [Neutral] or [Accent] used for standard progress indication without conveying any semantic feedback.
/// They simply communicate that a process is running or progressing.
///   - Functional statuses communicate additional semantic meaning about the operation being performed.
///   They should only be used when the process itself represents a meaningful system state.: [Positive], [Warning],
///  [Negative], [Info].
/// - [animated]: If true, enables animation when updating the progress.
/// - [progress]: The current progress value, between 0.0 and 1.0. If null, the indicator is indeterminate.
/// - [gapSize]: The size of the gap in the circular indicator [OudsProgressIndicatorGapSize].
/// - [track]: If true, displays the track (background) of the indicator.
/// - [semanticLabel]: Semantic label for accessibility.
///
/// ## Example of usage
///
/// ```dart
/// OudsCircularProgressIndicator(
///   progressType: OudsProgressIndicatorType.determinate,
///   status: Positive(),
///   progress: 0.8,
///   track: false,
///   animated: true,
///   gapSize: OudsProgressIndicatorGapSize.small,
/// )
/// ```
///
class OudsCircularProgressIndicator extends OudsProgressIndicator {
  const OudsCircularProgressIndicator({
    super.key,
    super.progressType = OudsProgressIndicatorType.determinate,
    super.status = const Neutral(),
    super.animated = true,
    super.progress,
    super.gapSize = OudsProgressIndicatorGapSize.defaultSize,
    super.track = true,
    super.semanticLabel,
  });

  @override
  State<OudsCircularProgressIndicator> createState() =>
      _OudsCircularProgressIndicatorState();
}

class _OudsCircularProgressIndicatorState
    extends State<OudsCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    final styleModifier = OudsProgressIndicatorStyleModifier(context);
    final statusModifier = OudsProgressIndicatorStatusModifier(context);
    final textScaler = MediaQuery.textScalerOf(context);

    final defaultSize = textScaler.scale(_oudsCircularProgressIndicatorSize);
    final progressValue = OudsProgressIndicatorUtils.clampedProgressValue(
      widget.progressType,
      widget.progress,
    );
    final indicatorColor = statusModifier.getStatusColor(widget.status);
    final backgroundColor = styleModifier.getTrackColor(widget.track);
    final gapSize = styleModifier.computeGapSize(widget.gapSize);
    final strokeWidth = styleModifier.computeStrokeWidth(defaultSize);
    final strokeCap = styleModifier.getStrokeCap(widget.gapSize);

    if (OudsProgressIndicatorUtils.shouldAnimate(
      widget.progressType,
      widget.animated,
    )) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progressValue ?? 0.0),
        duration: _animationDuration,
        curve: Curves.easeOutCubic,
        builder: (context, animatedValue, child) {
          return _buildIndicator(
            value: animatedValue,
            defaultSize: defaultSize,
            indicatorColor: indicatorColor,
            backgroundColor: backgroundColor,
            strokeWidth: strokeWidth,
            gapSize: gapSize,
            strokeCap: strokeCap,
          );
        },
      );
    }

    return _buildIndicator(
      value: progressValue,
      defaultSize: defaultSize,
      indicatorColor: indicatorColor,
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth,
      gapSize: gapSize,
      strokeCap: strokeCap,
    );
  }

  /// Builds the underlying [CircularProgressIndicator] widget with the
  /// already computed visual properties.
  ///
  /// This helper avoids duplicating the widget tree between animated and
  /// non-animated rendering paths.
  Widget _buildIndicator({
    required double? value,
    required double defaultSize,
    required Color indicatorColor,
    required Color backgroundColor,
    required double strokeWidth,
    required double gapSize,
    required StrokeCap strokeCap,
  }) {
    final localizations = OudsLocalizations.of(context);
    final statusLabel = OudsProgressIndicatorUtils.buildStatusSemanticsLabel(
      localizations,
      widget.status,
    );
    final semanticsLabel = statusLabel != null
        ? '${widget.semanticLabel}, $statusLabel'
        : widget.semanticLabel ?? '';

    return CircularProgressIndicator(
      semanticsLabel: semanticsLabel,
      year2023: false,
      constraints: BoxConstraints(
        minWidth: defaultSize,
        minHeight: defaultSize,
      ),
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth,
      trackGap: gapSize,
      strokeCap: strokeCap,
    );
  }
}

/// **Reference design version : 1.0.0**
///
/// A Linear Progress Indicator shows the progress of a task using a horizontal line.
/// It can show a specific value (determinate) or just that something is in progress (indeterminate).
/// Best used inside layouts to show progress.
///
/// The component can optionally display:
/// - a stop indicator at the end of the active bar,
/// - helper text below the indicator,
/// - a percentage value,
/// - and custom alignment for the helper text.
///
/// # Parameters:
///
/// - [progressType]: Defines whether the indicator is determinate or indeterminate.
/// - [status]: Represents the visual status of the indicator. Its color is based on this status.
/// Progress indicators can use different statuses depending on the meaning of the process they represent. Status colors should communicate the nature of the operation, not its completion percentage.
/// There are two types of statuses:
///   - Non-functional statuses [Neutral] or [Accent] used for standard progress indication without conveying any semantic feedback.
/// They simply communicate that a process is running or progressing.
///   - Functional statuses communicate additional semantic meaning about the operation being performed.
///   They should only be used when the process itself represents a meaningful system state.: [Positive], [Warning],
///  [Negative], [Info].
/// - [animated]: If true, enables animation when updating the progress.
/// - [progress]: The current progress value, between 0.0 and 1.0. If null, the indicator is indeterminate.
/// - [gapSize]: The size of the gap in the linear indicator [OudsProgressIndicatorGapSize].
/// - [track]: If true, displays the track (background) of the indicator.
/// - [semanticLabel]: Semantic label for accessibility.
/// - [stopIndicator]: If true, displays a stop indicator at the end of the progress.
/// - [helperText]: Optional text displayed below the indicator.
/// - [helperTextAlignment]: Alignment of the helper text [OudsProgressIndicatorHelperTextAlignment].
/// - [percentage]: Displays the progress percentage in the helper text area .
///    - If `false`, the provided [helperText] is returned.
///    - If `true`, the helper text is generated from [progress] and formatted as a percentage.
/// - [spaceBeforePercentage]: Inserts a space before the percentage symbol when percentage is displayed.
///
/// ## Example of usage
///
/// ```dart
/// OudsLinearProgressIndicator(
///   progressType: OudsProgressIndicatorType.determinate,
///   status: Positive(),
///   progress: 0.8,
///   track: true,
///   animated: true,
///   stopIndicator: false,
///   helperText: 'Uploading file',
///   helperTextAlignment: OudsProgressIndicatorHelperTextAlignment.center,
///   percentage: false,
///   spaceBeforePercentage: false,
/// )
/// ```
///
class OudsLinearProgressIndicator extends OudsProgressIndicator {
  final bool stopIndicator;
  final String? helperText;
  final OudsProgressIndicatorHelperTextAlignment helperTextAlignment;
  final bool percentage;
  final bool spaceBeforePercentage;

  const OudsLinearProgressIndicator({
    super.key,
    super.progressType = OudsProgressIndicatorType.determinate,
    super.status = const Neutral(),
    super.animated = true,
    super.progress,
    super.gapSize = OudsProgressIndicatorGapSize.defaultSize,
    super.track = true,
    super.semanticLabel,
    this.stopIndicator = false,
    this.helperText,
    this.helperTextAlignment = OudsProgressIndicatorHelperTextAlignment.center,
    this.percentage = false,
    this.spaceBeforePercentage = false,
  });

  @override
  State<OudsLinearProgressIndicator> createState() =>
      _OudsLinearProgressIndicatorState();
}

class _OudsLinearProgressIndicatorState
    extends State<OudsLinearProgressIndicator> {
  static const _stopIndicatorRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        spacing: OudsTheme.of(
          context,
        ).componentsTokens(context).progressIndicator.spacePaddingBlock,
        children: [
          _buildLinearProgressIndicator(),
          Align(
            alignment: OudsProgressIndicatorUtils.getTextAlign(
              widget.helperTextAlignment,
            ),
            child: widget.percentage
                ? ExcludeSemantics(child: _buildHelperTextWidget())
                : _buildHelperTextWidget(),
          ),
        ],
      ),
    );
  }

  Widget? _buildHelperTextWidget() {
    final helperTextLabel = OudsProgressIndicatorUtils.buildHelperText(
      widget.percentage,
      widget.spaceBeforePercentage,
      widget.progress,
      widget.helperText,
    );
    return helperTextLabel != null && helperTextLabel.isNotEmpty
        ? Text(
            helperTextLabel,
            style: OudsTheme.of(context).typographyTokens
                .typeLabelDefaultMedium(context)
                .copyWith(
                  color: OudsTheme.of(
                    context,
                  ).colorScheme(context).contentDefault,
                ),
          )
        : null;
  }

  /// Builds the visual [LinearProgressIndicator].
  ///
  /// This method computes the size, colors, gap, border radius, and clamped
  /// progress value before rendering the widget.
  ///
  /// If the indicator is determinate and animated, it uses a
  /// [TweenAnimationBuilder] to animate progress changes.
  Widget _buildLinearProgressIndicator() {
    final progressIndicatorTokens = OudsTheme.of(
      context,
    ).componentsTokens(context).progressIndicator;
    // Retrieve style and status modifiers
    final progressIndicatorStyleModifier = OudsProgressIndicatorStyleModifier(
      context,
    );
    final progressIndicatorStatusModifier = OudsProgressIndicatorStatusModifier(
      context,
    );
    final textScaler = MediaQuery.textScalerOf(context);
    final minHeight = textScaler.scale(
      progressIndicatorTokens.sizeLinearIndicatorHeight,
    );

    final gapSize = progressIndicatorStyleModifier.linearGapSize(
      widget.gapSize,
    );
    final indicatorColor = progressIndicatorStatusModifier.getStatusColor(
      widget.status,
    );
    final backgroundColor = progressIndicatorStyleModifier.getTrackColor(
      widget.track,
    );

    final progressValue = OudsProgressIndicatorUtils.clampedProgressValue(
      widget.progressType,
      widget.progress,
    );

    final borderRadius = progressIndicatorStyleModifier.getBorderRadius();

    if (OudsProgressIndicatorUtils.shouldAnimate(
      widget.progressType,
      widget.animated,
    )) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progressValue ?? 0.0),
        duration: _animationDuration,
        curve: Curves.easeOutCubic,
        builder: (context, animatedValue, child) {
          return _buildIndicator(
            minHeight: minHeight,
            value: animatedValue,
            indicatorColor: indicatorColor,
            backgroundColor: backgroundColor,
            gapSize: gapSize,
            borderRadius: borderRadius,
          );
        },
      );
    }

    return _buildIndicator(
      minHeight: minHeight,
      value: progressValue,
      indicatorColor: indicatorColor,
      backgroundColor: backgroundColor,
      gapSize: gapSize,
      borderRadius: borderRadius,
    );
  }

  /// Builds the underlying [OudsLinearProgressIndicator] widget with the
  /// already computed visual properties.
  ///
  /// This helper avoids duplicating the widget tree between animated and
  /// non-animated rendering paths.
  Widget _buildIndicator({
    required double minHeight,
    required double? value,
    required Color indicatorColor,
    required Color backgroundColor,
    required double gapSize,
    required BorderRadiusGeometry borderRadius,
  }) {
    final localizations = OudsLocalizations.of(context);
    final statusLabel = OudsProgressIndicatorUtils.buildStatusSemanticsLabel(
      localizations,
      widget.status,
    );
    final semanticsLabel = statusLabel != null
        ? '${widget.semanticLabel}, $statusLabel'
        : widget.semanticLabel ?? '';

    return LinearProgressIndicator(
      minHeight: minHeight,
      semanticsLabel: semanticsLabel,
      year2023: false,
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
      backgroundColor: backgroundColor,
      trackGap: gapSize,
      stopIndicatorColor: indicatorColor,
      borderRadius: borderRadius,
      stopIndicatorRadius: widget.stopIndicator ? _stopIndicatorRadius : 0,
    );
  }
}
