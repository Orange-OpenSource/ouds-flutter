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

import 'package:flutter/foundation.dart';
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
enum OudsProgressIndicatorHelperTextAlignment { start, center, end }

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
  /// The [value] value must be between `0.0` and `1.0` when [progressType]
  /// is [OudsProgressIndicatorType.determinate]; it is ignored otherwise.
  ///
  /// ## Accessibility
  ///
  /// Provide a [semanticsLabel] to describe the purpose of this indicator to
  /// assistive technologies (TalkBack / VoiceOver).
  const OudsProgressIndicator({
    super.key,
    this.progressType = OudsProgressIndicatorType.determinate,
    this.status = const Neutral(),
    this.animated = true,
    this.value,
    this.gapSize = OudsProgressIndicatorGapSize.defaultSize,
    this.track = true,
    this.semanticsLabel,
  });

  final OudsProgressIndicatorType? progressType;
  final OudsIconStatus status;
  final bool animated;
  final double? value;
  final OudsProgressIndicatorGapSize gapSize;
  final bool track;
  final String? semanticsLabel;
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
/// - [value]: Value between `0.0` and `1.0`. Pass `null` for indeterminate.
/// - [gapSize]: Gap between the active arc and its track — [OudsProgressIndicatorGapSize].
/// - [track]: Whether the background track ring is visible.
/// - [semanticsLabel]: Accessibility label for assistive technologies.
/// - [helperText]: Optional [OudsCircularProgressIndicatorHelperText] displayed
///   below the indicator, combining the progress percentage and/or a label.
///   Unlike [OudsLinearProgressIndicator], it has no alignment option — it is
///   always centered.
///
/// ## Example
///
/// ```dart
/// OudsCircularProgressIndicator(
///   progressType: OudsProgressIndicatorType.determinate,
///   status: Positive(),
///   value: 0.8,
///   track: false,
///   animated: true,
///   gapSize: OudsProgressIndicatorGapSize.small,
///   helperText: OudsCircularProgressIndicatorHelperText(
///     label: 'Uploading file',
///   ),
/// )
/// ```
class OudsCircularProgressIndicator extends OudsProgressIndicator {
  const OudsCircularProgressIndicator({
    super.key,
    super.progressType = OudsProgressIndicatorType.determinate,
    super.status = const Neutral(),
    super.animated = true,
    super.value,
    super.gapSize = OudsProgressIndicatorGapSize.defaultSize,
    super.track = true,
    super.semanticsLabel,
    this.helperText,
  }) : _color = null;

  /// Creates an [OudsCircularProgressIndicator] with an explicit [color], bypassing the
  /// [status]-based color resolution.
  ///
  /// This constructor is **internal** and reserved for other OUDS components (e.g. [OudsButton])
  /// that need to render the indicator using a color coming from their own token resolution
  /// (which may not map to any of the semantic [OudsIconStatus] values).
  ///
  /// Do not use this constructor directly from application code — use the default constructor
  /// with [status] instead.
  @internal
  const OudsCircularProgressIndicator.internal({
    super.key,
    super.progressType = OudsProgressIndicatorType.determinate,
    super.animated = true,
    super.value,
    super.gapSize = OudsProgressIndicatorGapSize.defaultSize,
    super.track = true,
    super.semanticsLabel,
    Color? color,
  }) : _color = color,
       helperText = null;

  /// Explicit color override used instead of resolving [OudsProgressIndicator.status].
  ///
  /// `null` when created via the public constructor, in which case [status] is used.
  final Color? _color;

  /// Optional helper text displayed below the indicator, combining the
  /// progress percentage and/or a label. Always centered — see
  /// [OudsCircularProgressIndicatorHelperText]. Pass `null` (the default) to
  /// hide the helper text entirely.
  final OudsCircularProgressIndicatorHelperText? helperText;

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
      widget.value,
    );
    final indicatorColor =
        widget._color ?? statusModifier.getStatusColor(widget.status);
    final backgroundColor = styleModifier.getTrackColor(widget.track);
    final gapSize = styleModifier.computeGapSize(widget.gapSize);
    final strokeCap = styleModifier.getStrokeCap(widget.gapSize);

    final localizations = OudsLocalizations.of(context);
    final statusLabel = OudsProgressIndicatorUtils.buildStatusSemanticsLabel(
      localizations,
      widget.status,
    );
    final semanticsLabel = statusLabel != null
        ? '${widget.semanticsLabel ?? ""}, $statusLabel'
        : '${widget.semanticsLabel ?? ""},';

    final semanticsValue = OudsProgressIndicatorUtils.buildSemanticValueLabel(
      widget.progressType,
      widget.value,
      OudsLocalizations.of(context),
    );

    final Widget indicator;
    if (OudsProgressIndicatorUtils.shouldAnimate(
      widget.progressType,
      context,
      widget.animated,
    )) {
      indicator = TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progressValue ?? 0.0),
        duration: _animationDuration,
        curve: Curves.easeOutCubic,
        builder: (context, animatedValue, child) {
          return _buildIndicator(
            value: animatedValue,
            defaultSize: defaultSize,
            indicatorColor: indicatorColor,
            backgroundColor: backgroundColor,
            gapSize: gapSize,
            strokeCap: strokeCap,
            reduceMotion: false,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
          );
        },
      );
    } else {
      final reduceMotionActivated =
          OudsProgressIndicatorUtils.shouldDisableAnimations(context);

      indicator = _buildIndicator(
        value: progressValue,
        defaultSize: defaultSize,
        indicatorColor: indicatorColor,
        backgroundColor: backgroundColor,
        gapSize: gapSize,
        strokeCap: strokeCap,
        reduceMotion: reduceMotionActivated,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
      );
    }

    final helperTextWidget = _buildHelperTextWidget();
    if (helperTextWidget == null) {
      return indicator;
    }

    return MergeSemantics(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: OudsTheme.of(
          context,
        ).componentsTokens(context).progressIndicator.spacePaddingBlock,
        children: [indicator, helperTextWidget],
      ),
    );
  }

  /// Builds the optional helper text widget displayed below the indicator.
  ///
  /// Unlike [OudsLinearProgressIndicator], it has no alignment option: the
  /// progress percentage and/or the label are always centered, combined on a
  /// single line when both are shown. The progress percentage is never shown
  /// for indeterminate indicators, since there is no meaningful value to
  /// format — only the label is displayed in that case.
  ///
  /// Returns `null` when no helper text should be shown.
  Widget? _buildHelperTextWidget() {
    final helperText = widget.helperText;
    if (helperText == null) {
      return null;
    }

    final textStyle = OudsTheme.of(context).typographyTokens
        .typeLabelDefaultMedium(context)
        .copyWith(
          color: OudsTheme.of(context).colorScheme(context).contentDefault,
        );

    // The progress percentage cannot be displayed for indeterminate
    // indicators since there is no meaningful value to format.
    final showProgress =
        helperText.progress &&
        widget.progressType == OudsProgressIndicatorType.determinate;

    // The progress percentage is excluded from semantics since it duplicates
    // the value already exposed by the progress indicator's own semantics.
    final progressWidget = showProgress
        ? ExcludeSemantics(
            child: Text(
              OudsProgressIndicatorUtils.buildPercentageText(widget.value),
              style: textStyle,
            ),
          )
        : null;
    final labelWidget = helperText.label != null
        ? Text(helperText.label!, style: textStyle)
        : null;

    if (progressWidget == null && labelWidget == null) {
      return null;
    }

    // No `mainAxisSize: min` here: the Row must take the width offered by
    // its parent so that a long [label] can wrap onto multiple lines
    // (via the Flexible children below) instead of overflowing.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: OudsTheme.of(
        context,
      ).componentsTokens(context).progressIndicator.spaceColumnGap,
      children: [
        if (progressWidget != null) progressWidget,
        if (labelWidget != null) Flexible(child: labelWidget),
      ],
    );
  }

  /// Builds the underlying [CircularProgressIndicator] widget with the
  /// already computed visual properties.
  ///
  /// Wraps the indicator in a [SizedBox] to enforce [defaultSize],
  /// preventing the parent constraints (e.g. a button) from shrinking
  /// or expanding the indicator unexpectedly.
  ///
  /// This helper avoids duplicating the widget tree between animated and
  /// non-animated rendering paths.
  Widget _buildIndicator({
    required double? value,
    required double defaultSize,
    required Color indicatorColor,
    required Color backgroundColor,
    required double gapSize,
    required StrokeCap strokeCap,
    required bool reduceMotion,
    String? semanticsLabel,
    String? semanticsValue,
  }) {
    final bool indeterminateWithReduceMotion =
        value == null && reduceMotion == true;

    // SizedBox enforces the computed or custom size,
    // preventing parent constraints from altering the indicator dimensions.
    return SizedBox(
      width: defaultSize,
      height: defaultSize,
      child: Transform.rotate(
        angle: indeterminateWithReduceMotion ? 20 : 0,
        child: indeterminateWithReduceMotion
            ? Semantics(
                label: semanticsLabel,
                child: ExcludeSemantics(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final strokeWidth = constraints.maxWidth * 0.125;

                      return CircularProgressIndicator(
                        padding: EdgeInsets.zero,
                        year2023: false,
                        constraints: BoxConstraints(
                          minWidth: defaultSize,
                          minHeight: defaultSize,
                        ),
                        value: 0.8,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          indicatorColor,
                        ),
                        backgroundColor: backgroundColor,
                        strokeWidth: strokeWidth,
                        trackGap: gapSize,
                        strokeCap: strokeCap,
                      );
                    },
                  ),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final strokeWidth = constraints.maxWidth * 0.125;
                  return CircularProgressIndicator(
                    padding: EdgeInsets.zero,
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
                    trackGap: gapSize,
                    strokeWidth: strokeWidth,
                    strokeCap: strokeCap,
                  );
                },
              ),
      ),
    );
  }
}

/// Optional helper text displayed below an [OudsCircularProgressIndicator].
///
/// The helper text can show the progress value formatted as a percentage
/// ([progress]), a custom [label], or both at once. By default, only the
/// progress percentage is shown; add [label] to also display custom text.
/// Unlike [OudsLinearProgressIndicatorHelperText], there is no alignment
/// option: the helper text is always centered below the indicator, combining
/// the progress percentage and the label on a single line when both are
/// shown.
///
/// The progress percentage is never shown when the indicator is
/// indeterminate (`progressType: OudsProgressIndicatorType.indeterminate`),
/// since there is no meaningful value to format — only [label] is displayed
/// in that case.
///
/// ## Example
///
/// ```dart
/// OudsCircularProgressIndicator(
///   value: 0.75,
///   helperText: OudsCircularProgressIndicatorHelperText(
///     label: 'Uploading file',
///   ),
/// )
/// ```
class OudsCircularProgressIndicatorHelperText {
  /// Whether the progress value, formatted as a percentage, is displayed.
  /// Ignored (never shown) when the indicator is indeterminate.
  final bool progress;

  /// Optional label displayed alongside (or instead of) the progress
  /// percentage.
  final String? label;

  const OudsCircularProgressIndicatorHelperText({
    this.progress = true,
    this.label,
  });
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
/// - [value]: Value between `0.0` and `1.0`. Pass `null` for indeterminate.
/// - [gapSize]: Gap between the active bar and its track — [OudsProgressIndicatorGapSize].
/// - [track]: Whether the background track bar is visible.
/// - [semanticsLabel]: Accessibility label for assistive technologies.
/// - [stopIndicator]: Displays a square (or circle when rounded) block at the
///   end of the active bar.
/// - [helperText]: Optional [OudsLinearProgressIndicatorHelperText] displayed
///   below the indicator, combining the progress percentage and/or a label.
///   See [OudsLinearProgressIndicatorHelperText] for the alignment rules.
///
/// ## Example
///
/// ```dart
/// OudsLinearProgressIndicator(
///   progressType: OudsProgressIndicatorType.determinate,
///   status: Positive(),
///   value: 0.8,
///   track: true,
///   animated: true,
///   stopIndicator: false,
///   helperText: OudsLinearProgressIndicatorHelperText(
///     label: 'Uploading file',
///   ),
/// )
/// ```
class OudsLinearProgressIndicator extends OudsProgressIndicator {
  /// Whether to display a stop block at the right end of the active bar.
  ///
  /// The block is square when the theme uses default corners and circular when
  /// rounded corners are enabled.
  final bool stopIndicator;

  /// Optional helper text displayed below the indicator, combining the
  /// progress percentage and/or a label. See
  /// [OudsLinearProgressIndicatorHelperText] for the alignment rules. Pass
  /// `null` to hide the helper text entirely.
  final OudsLinearProgressIndicatorHelperText? helperText;

  const OudsLinearProgressIndicator({
    super.key,
    super.progressType = OudsProgressIndicatorType.determinate,
    super.status = const Neutral(),
    super.animated = true,
    super.value,
    super.gapSize = OudsProgressIndicatorGapSize.defaultSize,
    super.track = true,
    super.semanticsLabel,
    this.stopIndicator = false,
    this.helperText = const OudsLinearProgressIndicatorHelperText(),
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
          // Only add the helper text child when there is actual content to
          // display. An empty child in the Column still consumes the Column
          // spacing (spacePaddingBlock dp), causing a layout shift on the
          // indicator.
          ?helperTextWidget,
        ],
      ),
    );
  }

  /// Builds the optional helper text widget displayed below the indicator.
  ///
  /// - When only the progress percentage or only the label is displayed, it
  ///   is centered.
  /// - When both are displayed, the label is positioned according to
  ///   [OudsLinearProgressIndicatorHelperText.labelAlignment] and the
  ///   progress percentage automatically takes the opposite side.
  /// - The progress percentage is never shown for indeterminate indicators,
  ///   since there is no meaningful value to format — only the label is
  ///   displayed in that case.
  ///
  /// Returns `null` when no helper text should be shown, so that the [Column]
  /// does not add unnecessary spacing via its `spacing` parameter.
  Widget? _buildHelperTextWidget() {
    final helperText = widget.helperText;
    if (helperText == null) {
      return null;
    }

    final textStyle = OudsTheme.of(context).typographyTokens
        .typeLabelDefaultMedium(context)
        .copyWith(
          color: OudsTheme.of(context).colorScheme(context).contentDefault,
        );

    // The progress percentage cannot be displayed for indeterminate
    // indicators since there is no meaningful value to format.
    final showProgress =
        helperText.progress &&
        widget.progressType == OudsProgressIndicatorType.determinate;

    // The progress percentage is excluded from semantics since it duplicates
    // the value already exposed by the progress indicator's own semantics.
    final progressWidget = showProgress
        ? ExcludeSemantics(
            child: Text(
              OudsProgressIndicatorUtils.buildPercentageText(widget.value),
              style: textStyle,
            ),
          )
        : null;
    // Both are displayed: the label takes its configured side (start or
    // end) and the progress percentage automatically takes the other one.
    // Each child is wrapped in Flexible so a long label can shrink and wrap
    // onto multiple lines instead of overflowing the Row.
    final labelAtStart =
        helperText.labelAlignment ==
        OudsProgressIndicatorHelperTextAlignment.start;

    final labelWidget = helperText.label != null
        ? Text(
            helperText.label!,
            style: textStyle,
            textWidthBasis: TextWidthBasis.longestLine,
            textAlign: labelAtStart ? TextAlign.start : TextAlign.end,
          )
        : null;

    if (progressWidget == null && labelWidget == null) {
      return null;
    }

    // Only one of the two is displayed: helper text is always centered.
    // Wrapped in Flexible + Center so a long label can wrap onto multiple
    // lines instead of overflowing when it exceeds the available width.
    if (progressWidget == null || labelWidget == null) {
      return Center(child: progressWidget ?? labelWidget);
    }

    final flexibleLabel = Flexible(child: labelWidget);
    Widget spacing = SizedBox(
      width: OudsTheme.of(
        context,
      ).componentsTokens(context).progressIndicator.spaceColumnGap,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labelAtStart
          ? [flexibleLabel, progressWidget]
          : [progressWidget, flexibleLabel],
    );
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
      widget.value,
    );

    final borderRadius = progressIndicatorStyleModifier.getBorderRadius();

    final localizations = OudsLocalizations.of(context);
    final statusLabel = OudsProgressIndicatorUtils.buildStatusSemanticsLabel(
      localizations,
      widget.status,
    );
    final semanticsLabel = statusLabel != null
        ? '${widget.semanticsLabel ?? ""}, $statusLabel,'
        : '${widget.semanticsLabel ?? ""},';

    final semanticsValue = OudsProgressIndicatorUtils.buildSemanticValueLabel(
      widget.progressType,
      widget.value,
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
            value: widget.progressType == OudsProgressIndicatorType.determinate
                ? semanticsValue
                : null,
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

/// Optional helper text displayed below an [OudsLinearProgressIndicator].
///
/// The helper text can show the progress value formatted as a percentage
/// ([progress]), a custom [label], or both at once.
///
/// ## Alignment rules
///
/// - By default, only the progress percentage is shown, centered below the
///   indicator.
/// - When only the progress percentage or only [label] is displayed, it is
///   always centered.
/// - When both are displayed, [label] is positioned according to
///   [labelAlignment] — [OudsProgressIndicatorHelperTextAlignment.start] or
///   [OudsProgressIndicatorHelperTextAlignment.end] — and the progress
///   percentage automatically takes the opposite side. Helper text cannot be
///   centered when both [progress] and [label] are shown.
///
/// The progress percentage is never shown when the indicator is
/// indeterminate (`progressType: OudsProgressIndicatorType.indeterminate`),
/// since there is no meaningful value to format — only [label] is displayed
/// in that case.
///
/// ## Example
///
/// ```dart
/// OudsLinearProgressIndicator(
///   value: 0.75,
///   helperText: OudsLinearProgressIndicatorHelperText(
///     label: 'Uploading file',
///     labelAlignment: OudsProgressIndicatorHelperTextAlignment.end,
///   ),
/// )
/// ```
class OudsLinearProgressIndicatorHelperText {
  /// Whether the progress value, formatted as a percentage, is displayed.
  /// Ignored (never shown) when the indicator is indeterminate.
  final bool progress;

  /// Optional label displayed alongside (or instead of) the progress
  /// percentage.
  final String? label;

  /// Horizontal position of [label] when both [label] and [progress] are
  /// displayed; the progress percentage automatically takes the opposite
  /// side. Ignored when only one of them is displayed, in which case it is
  /// always centered. Must be [OudsProgressIndicatorHelperTextAlignment.start]
  /// or [OudsProgressIndicatorHelperTextAlignment.end].
  final OudsProgressIndicatorHelperTextAlignment labelAlignment;

  const OudsLinearProgressIndicatorHelperText({
    this.progress = true,
    this.label,
    this.labelAlignment = OudsProgressIndicatorHelperTextAlignment.end,
  });
}
