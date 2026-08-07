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
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
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

/// Abstract base class for all OUDS progress indicator widgets.
///
/// This widget cannot be instantiated directly. Use one of the concrete
/// sub-classes instead:
/// - [OudsCircularProgressIndicator] — ring-shaped indicator.
/// - [OudsLinearProgressIndicator] — horizontal bar indicator.
abstract class OudsProgressIndicator extends StatefulWidget {
  /// Creates a progress indicator.
  ///
  /// The [progress] value must be between `0.0` and `1.0` when [progressType]
  /// is [OudsProgressIndicatorType.determinate]; it is ignored otherwise.
  ///
  /// ## Accessibility
  ///
  /// Provide a [semanticLabel] to describe the purpose of this indicator to
  /// assistive technologies (TalkBack / VoiceOver).
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
/// A circular progress indicator that shows the progress of a task as a ring.
/// Useful when more visual focus is needed or when space is limited.
///
/// All dimensions (stroke width, gap size) scale proportionally based on the
/// effective component size, which itself follows the system text-scale factor.
///
/// ## Parameters
///
/// - [progressType]: Determinate or indeterminate display mode.
/// - [status]: Visual color status. Non-semantic ([Neutral], [Accent]) for
///   standard progress; semantic ([Positive], [Warning], [Negative], [Info])
///   when the operation carries a meaning.
/// - [animated]: Enables smooth value-change animation (determinate only).
///   Automatically disabled when the OS reduced-motion setting is on.
/// - [progress]: Value between `0.0` and `1.0`. Pass `null` for indeterminate.
/// - [gapSize]: Gap between the active arc and its track — [OudsProgressIndicatorGapSize].
/// - [track]: Whether the background track ring is visible.
/// - [semanticLabel]: Accessibility label for assistive technologies.
///
/// ## Example
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
    final strokeWidth = styleModifier.computeStrokeWidth(defaultSize);
    final gapSize = styleModifier.computeGapSize(widget.gapSize);
    final strokeCap = styleModifier.getStrokeCap(widget.gapSize);

    final localizations = OudsLocalizations.of(context);
    final statusLabel = OudsProgressIndicatorUtils.buildStatusSemanticsLabel(
      localizations,
      widget.status,
    );
    final semanticsLabel = statusLabel != null
        ? '${widget.semanticLabel}, $statusLabel'
        : widget.semanticLabel ?? '';

    final semanticsValue = OudsProgressIndicatorUtils.buildSemanticValueLabel(
      widget.progressType,
      widget.progress,
      OudsLocalizations.of(context),
    );

    if (OudsProgressIndicatorUtils.shouldAnimate(
      widget.progressType,
      context,
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
            reduceMotion: false,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
          );
        },
      );
    }

    bool reduceMotionActivated =
        OudsProgressIndicatorUtils.shouldDisableAnimations(context);

    return _buildIndicator(
      value: progressValue,
      defaultSize: defaultSize,
      indicatorColor: indicatorColor,
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth,
      gapSize: gapSize,
      strokeCap: strokeCap,
      reduceMotion: reduceMotionActivated,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
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
    required bool reduceMotion,
    String? semanticsLabel,
    String? semanticsValue,
  }) {
    final bool indeterminateWithReduceMotion =
        value == null && reduceMotion == true;
    return Transform.rotate(
      angle: indeterminateWithReduceMotion ? 20 : 0,
      child: indeterminateWithReduceMotion
          ? Semantics(
              label: semanticsLabel,
              child: ExcludeSemantics(
                child: CircularProgressIndicator(
                  year2023: false,
                  constraints: BoxConstraints(
                    minWidth: defaultSize,
                    minHeight: defaultSize,
                  ),
                  value: 0.8,
                  valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
                  backgroundColor: backgroundColor,
                  strokeWidth: strokeWidth,
                  trackGap: gapSize,
                  strokeCap: strokeCap,
                ),
              ),
            )
          : CircularProgressIndicator(
              semanticsLabel: semanticsLabel,
              semanticsValue: semanticsValue,
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
            ),
    );
  }
}

/// **Reference design version : 1.0.0**
///
/// A linear progress indicator that shows the progress of a task as a
/// horizontal bar. Supports both determinate and indeterminate modes and is
/// best placed inside layouts where vertical space is available.
///
/// The component can optionally display:
/// - a stop indicator at the end of the active bar,
/// - helper text below the indicator,
/// - a percentage value,
/// - and custom horizontal alignment for the helper text.
///
/// ## Parameters
///
/// - [progressType]: Determinate or indeterminate display mode.
/// - [status]: Visual color status. Non-semantic ([Neutral], [Accent]) for
///   standard progress; semantic ([Positive], [Warning], [Negative], [Info])
///   when the operation carries a meaning.
/// - [animated]: Enables smooth value-change animation (determinate only).
///   Automatically disabled when the OS reduced-motion setting is on.
/// - [progress]: Value between `0.0` and `1.0`. Pass `null` for indeterminate.
/// - [gapSize]: Gap between the active bar and its track — [OudsProgressIndicatorGapSize].
/// - [track]: Whether the background track bar is visible.
/// - [semanticLabel]: Accessibility label for assistive technologies.
/// - [stopIndicator]: Displays a square (or circle when rounded) block at the
///   end of the active bar.
/// - [helperText]: Optional text displayed below the indicator.
/// - [helperTextAlignment]: Horizontal alignment of the helper text —
///   [OudsProgressIndicatorHelperTextAlignment].
/// - [percentage]: When `true`, the helper text is generated from [progress]
///   and formatted as a percentage; when `false`, [helperText] is used.
/// - [spaceBeforePercentage]: Inserts a non-breaking space before the `%`
///   symbol when [percentage] is `true` (e.g. `75 %` instead of `75%`).
///
/// ## Example
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
class OudsLinearProgressIndicator extends OudsProgressIndicator {
  /// Whether to display a stop block at the right end of the active bar.
  ///
  /// The block is square when the theme uses default corners and circular when
  /// rounded corners are enabled.
  final bool stopIndicator;

  /// Optional text displayed below the indicator.
  ///
  /// Ignored when [percentage] is `true`.
  final String? helperText;

  /// Horizontal alignment of the helper text below the indicator.
  final OudsProgressIndicatorHelperTextAlignment helperTextAlignment;

  /// When `true`, the helper text is replaced by the formatted progress
  /// percentage (e.g. `75%`). [helperText] is ignored.
  final bool percentage;

  /// Inserts a space between the numeric value and the `%` symbol when
  /// [percentage] is `true` (e.g. `75 %` instead of `75%`).
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
  @override
  Widget build(BuildContext context) {
    // Compute the helper text widget once to avoid redundant calls and to guard
    // against null before passing to ExcludeSemantics (non-nullable child).
    final helperTextWidget = _buildHelperTextWidget();

    return MergeSemantics(
      child: Column(
        spacing: OudsTheme.of(
          context,
        ).componentsTokens(context).progressIndicator.spacePaddingBlock,
        children: [
          _buildLinearProgressIndicator(),
          // Only add the Align child when there is actual content to display.
          // An empty Align in the Column still consumes the Column spacing
          // (spacePaddingBlock dp), causing a layout shift on the indicator.
          if (helperTextWidget != null)
            Align(
              alignment: OudsProgressIndicatorUtils.getTextAlign(
                widget.helperTextAlignment,
              ),
              child: widget.percentage
                  ? ExcludeSemantics(child: helperTextWidget)
                  : helperTextWidget,
            ),
        ],
      ),
    );
  }

  /// Builds the optional helper text widget displayed below the indicator.
  ///
  /// Returns a styled [Text] widget when a non-empty helper text is available
  /// (either a formatted percentage or the raw [OudsLinearProgressIndicator.helperText]).
  /// Returns `null` when no helper text should be shown, so that the [Column]
  /// does not add unnecessary spacing via its `spacing` parameter.
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

    final localizations = OudsLocalizations.of(context);
    final statusLabel = OudsProgressIndicatorUtils.buildStatusSemanticsLabel(
      localizations,
      widget.status,
    );
    final semanticsLabel = statusLabel != null
        ? '${widget.semanticLabel}, $statusLabel'
        : widget.semanticLabel ?? '';

    final semanticsValue = OudsProgressIndicatorUtils.buildSemanticValueLabel(
      widget.progressType,
      widget.progress,
      OudsLocalizations.of(context),
    );

    // Respect the OS-level "Reduce Motion" (iOS) and "Remove Animations"
    // (Android) accessibility settings. The check is delegated to
    // OudsProgressIndicatorUtils._shouldDisableAnimations, which queries both
    // MediaQuery and the platform dispatcher for reliable cross-platform support.
    if (OudsProgressIndicatorUtils.shouldAnimate(
      widget.progressType,
      context,
      widget.animated,
    )) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progressValue ?? 0.0),
        duration: _animationDuration,
        curve: Curves.easeOutCubic,
        builder: (context, animatedValue, child) {
          return _buildIndicator(
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
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

    bool reduceMotionActivated =
        OudsProgressIndicatorUtils.shouldDisableAnimations(context);
    return reduceMotionActivated
        ? Semantics(
            label: semanticsLabel,
            child: ExcludeSemantics(
              child: _buildIndicator(
                minHeight: minHeight,
                value: 0,
                indicatorColor: indicatorColor,
                backgroundColor: backgroundColor,
                gapSize: gapSize,
                borderRadius: borderRadius,
              ),
            ),
          )
        : _buildIndicator(
            minHeight: minHeight,
            value: progressValue,
            indicatorColor: indicatorColor,
            backgroundColor: backgroundColor,
            gapSize: gapSize,
            borderRadius: borderRadius,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
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
    String? semanticsLabel,
    String? semanticsValue,
  }) {
    final isRounded =
        OudsThemeConfigModel.of(context)?.progressIndicator?.rounded ?? false;

    return // Stop indicator as a Stack overlay
    Stack(
      alignment: Alignment.centerRight,
      children: [
        LinearProgressIndicator(
          minHeight: minHeight,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
          year2023: false,
          value: value,
          valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          backgroundColor: backgroundColor,
          trackGap: gapSize,
          stopIndicatorColor: indicatorColor,
          borderRadius: borderRadius,
          stopIndicatorRadius: 0,
        ),
        if (widget.stopIndicator && !isRounded)
          Container(
            width: minHeight, // square with same size as track height
            height: minHeight,
            color: indicatorColor,
          ),
        if (widget.stopIndicator && isRounded)
          Container(
            width: minHeight,
            height: minHeight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: indicatorColor,
            ),
          ),
      ],
    );
  }
}
