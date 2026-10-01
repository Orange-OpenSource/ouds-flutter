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
    final semanticsLabel = OudsProgressIndicatorUtils.buildSemanticsLabel(
      widget.semanticsLabel,
      statusLabel,
    );

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
              OudsProgressIndicatorUtils.buildPercentageText(
                widget.value,
                textDirection: Directionality.of(context),
              ),
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
        ?progressWidget,
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
  ///   is positioned according to its own alignment —
  ///   [OudsLinearProgressIndicatorHelperText.progressAlignment] or
  ///   [OudsLinearProgressIndicatorHelperText.labelAlignment] — which can be
  ///   `start`, `center` or `end`.
  /// - When both would be displayed and one of them requests
  ///   [OudsProgressIndicatorHelperTextAlignment.center], that one is shown
  ///   alone (centered) and the other is ignored — two items cannot share
  ///   the same line when one of them is centered.
  /// - When both are displayed and neither requests `center`, the label is
  ///   positioned according to [OudsLinearProgressIndicatorHelperText.labelAlignment]
  ///   (`start` or `end`) and the progress percentage automatically takes
  ///   the opposite side.
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
              OudsProgressIndicatorUtils.buildPercentageText(
                widget.value,
                textDirection: Directionality.of(context),
              ),
              style: textStyle,
            ),
          )
        : null;

    final labelWidget = helperText.label != null
        ? Text(
            helperText.label!,
            style: textStyle,
            textWidthBasis: TextWidthBasis.longestLine,
            textAlign: _textAlignOf(helperText.labelAlignment),
          )
        : null;

    if (progressWidget == null && labelWidget == null) {
      return null;
    }

    // Both would be displayed: `center` only makes sense for a single item on
    // the line, so when both are shown, whichever one requests a side
    // (`start` or `end`) dictates its own position and the other
    // automatically takes the opposite side — a `center` request from one of
    // them is only meaningful when the other has no side preference either.
    // The label's side takes priority over the progress percentage's when
    // both explicitly request a side, since the label is the primary driver
    // of the layout.
    if (progressWidget != null && labelWidget != null) {
      final progressPreference =
          helperText.progressAlignment ==
              OudsProgressIndicatorHelperTextAlignment.center
          ? null
          : helperText.progressAlignment;
      final labelPreference =
          helperText.labelAlignment ==
              OudsProgressIndicatorHelperTextAlignment.center
          ? null
          : helperText.labelAlignment;

      final OudsProgressIndicatorHelperTextAlignment labelSide;
      if (labelPreference != null) {
        labelSide = labelPreference;
      } else if (progressPreference != null) {
        labelSide = _opposite(progressPreference);
      } else {
        // Neither requests a side: fall back to the default layout (label at
        // the end, progress percentage at the start).
        labelSide = OudsProgressIndicatorHelperTextAlignment.end;
      }
      final labelAtStart =
          labelSide == OudsProgressIndicatorHelperTextAlignment.start;

      // The label is wrapped in Flexible so a long label can shrink and wrap
      // onto multiple lines instead of overflowing the Row.
      final flexibleLabel = Flexible(child: labelWidget);

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: labelAtStart
            ? [flexibleLabel, progressWidget]
            : [progressWidget, flexibleLabel],
      );
    }

    // Only one of the two is displayed: position it according to its own
    // alignment.
    final singleChild = progressWidget ?? labelWidget!;
    final singleAlignment = progressWidget != null
        ? helperText.progressAlignment
        : helperText.labelAlignment;
    return _alignSingleHelperChild(singleChild, singleAlignment);
  }

  /// Positions a single helper text child (progress percentage or label)
  /// according to [alignment], wrapping it in [Flexible] so a long label can
  /// wrap onto multiple lines instead of overflowing when it exceeds the
  /// available width.
  Widget _alignSingleHelperChild(
    Widget child,
    OudsProgressIndicatorHelperTextAlignment alignment,
  ) {
    final mainAxisAlignment = switch (alignment) {
      OudsProgressIndicatorHelperTextAlignment.start => MainAxisAlignment.start,
      OudsProgressIndicatorHelperTextAlignment.center =>
        MainAxisAlignment.center,
      OudsProgressIndicatorHelperTextAlignment.end => MainAxisAlignment.end,
    };
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [Flexible(child: child)],
    );
  }

  /// Returns the opposite side of [alignment] (`start` <-> `end`). Only
  /// meaningful for `start`/`end` values — `center` is returned unchanged
  /// since it has no opposite.
  OudsProgressIndicatorHelperTextAlignment _opposite(
    OudsProgressIndicatorHelperTextAlignment alignment,
  ) {
    return switch (alignment) {
      OudsProgressIndicatorHelperTextAlignment.start =>
        OudsProgressIndicatorHelperTextAlignment.end,
      OudsProgressIndicatorHelperTextAlignment.end =>
        OudsProgressIndicatorHelperTextAlignment.start,
      OudsProgressIndicatorHelperTextAlignment.center =>
        OudsProgressIndicatorHelperTextAlignment.center,
    };
  }

  /// Maps an [OudsProgressIndicatorHelperTextAlignment] to the corresponding
  /// [TextAlign] used by the label [Text] widget.
  TextAlign _textAlignOf(OudsProgressIndicatorHelperTextAlignment alignment) {
    return switch (alignment) {
      OudsProgressIndicatorHelperTextAlignment.start => TextAlign.start,
      OudsProgressIndicatorHelperTextAlignment.center => TextAlign.center,
      OudsProgressIndicatorHelperTextAlignment.end => TextAlign.end,
    };
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
    final semanticsLabel = OudsProgressIndicatorUtils.buildSemanticsLabel(
      widget.semanticsLabel,
      statusLabel,
    );

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
    final isIndeterminate =
        widget.progressType == OudsProgressIndicatorType.indeterminate;

    // The animation freeze (static value, semantics value excluded) only
    // makes sense for indeterminate indicators, which otherwise spin
    // endlessly and have no meaningful value to announce. Determinate
    // indicators must keep announcing their actual percentage to screen
    // readers even when reduce motion is active — only their animation is
    // suppressed (already handled by `shouldAnimate` returning false above).
    return reduceMotionActivated && isIndeterminate
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

/// Optional helper text displayed below an [OudsLinearProgressIndicator].
///
/// The helper text can show the progress value formatted as a percentage
/// ([progress]), a custom [label], or both at once.
///
/// ## Alignment rules
///
/// - [progressAlignment] and [labelAlignment] each control where their own
///   item is positioned (`start`, `center` or `end`) **when that item is the
///   only one displayed**.
/// - By default, only the progress percentage is shown, centered below the
///   indicator ([progressAlignment] defaults to
///   [OudsProgressIndicatorHelperTextAlignment.center]).
/// - When both [progress] and [label] would be displayed and one of them
///   requests [OudsProgressIndicatorHelperTextAlignment.center], that one is
///   shown alone (centered) and the other is silently ignored — a centered
///   item cannot share the line with another item.
/// - When both are displayed and neither requests `center`, [label] is
///   positioned according to [labelAlignment] — `start` or `end` — and the
///   progress percentage automatically takes the opposite side
///   ([progressAlignment] is ignored in that case).
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

  /// Horizontal alignment for the custom label when it is the only item
  /// displayed, or the side it takes (`start`/`end`) when both the label and
  /// the progress percentage are displayed together.
  final OudsProgressIndicatorHelperTextAlignment labelAlignment;

  /// Horizontal alignment for the progress percentage when it is the only
  /// item displayed. Ignored when [label] is also displayed and
  /// non-centered, in which case the progress percentage automatically takes
  /// the side opposite [labelAlignment].
  final OudsProgressIndicatorHelperTextAlignment progressAlignment;

  const OudsLinearProgressIndicatorHelperText({
    this.progress = true,
    this.label,
    this.labelAlignment = OudsProgressIndicatorHelperTextAlignment.end,
    this.progressAlignment = OudsProgressIndicatorHelperTextAlignment.start,
  });
}
