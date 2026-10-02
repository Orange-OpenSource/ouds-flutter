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

/// {@category Skeleton}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// [OUDS Skeleton Design Guidelines](https://r.orange.fr/r/S-ouds-doc-skeleton)
///
/// **Reference design version : 1.0.0**
///
/// A skeleton is a UI element that indicates when content is loading. The skeleton enhances user experience by
/// temporarily replacing content with gray areas or animations that simulate the visual structure of the forthcoming
/// content.
///
/// [OudsSkeleton] does not expose `width`/`height` parameters of its own and relies on the size
/// constraints provided by its parent. To display it at a specific size, wrap it in a [SizedBox]
/// (or any other size-constraining widget) instead of passing size values directly:
///
/// ```dart
/// SizedBox(
///   width: 250,
///   height: 80,
///   child: OudsSkeleton(),
/// )
/// ```
///
/// ```dart
/// OudsSkeleton(
///   animated: true,
///   securityMargin: false,
/// )
/// ```
///
class OudsSkeleton extends StatefulWidget {
  /// Whether the shimmer sweep animation is enabled. Defaults to `true`. Automatically disabled
  /// when the system "reduce motion" accessibility setting is active, regardless of this value.
  final bool animated;

  /// Whether to apply vertical padding to the skeleton. Defaults to true.
  final bool securityMargin;

  /// Creates an [OudsSkeleton].
  const OudsSkeleton({
    super.key,
    this.animated = true,
    this.securityMargin = false,
  });

  @override
  State<OudsSkeleton> createState() => _OudsSkeletonState();
}

class _OudsSkeletonState extends State<OudsSkeleton>
    with SingleTickerProviderStateMixin {
  // The shimmer sweeps across the skeleton in 800ms, then holds at the end position for 450ms
  // before the next sweep starts, giving the animation a brief pause between each pass.
  static const _shimmerMoveDuration = Duration(milliseconds: 800);
  static const _shimmerPauseDuration = Duration(milliseconds: 450);
  static final _shimmerTotalDuration =
      _shimmerMoveDuration + _shimmerPauseDuration;
  static final _shimmerMoveFraction =
      _shimmerMoveDuration.inMilliseconds /
      _shimmerTotalDuration.inMilliseconds;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _shimmerTotalDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Returns `true` when the OS accessibility settings request that animations be suppressed.
  ///
  /// Combines [MediaQuery.disableAnimationsOf] — Android's global "Remove animations" toggle and
  /// any host app override — with iOS's "Reduce Motion" flag, read directly from the platform
  /// dispatcher since [MediaQuery.disableAnimationsOf] does not reliably reflect it on iOS.
  bool _shouldDisableAnimations(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return true;
    }
    final accessibilityFeatures = View.of(
      context,
    ).platformDispatcher.accessibilityFeatures;
    return accessibilityFeatures.reduceMotion;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = OudsTheme.of(context).componentsTokens(context).skeleton;
    final padding = OudsTheme.of(
      context,
    ).spaceScheme(context).paddingBlockThreeExtraSmall;
    final shouldAnimate = widget.animated && !_shouldDisableAnimations(context);

    // The shimmer is a dedicated gradient layer drawn on top of the background and translated
    // from fully off-screen left to fully off-screen right, clipped to the skeleton's bounds.
    // Using a separate layer with normal alpha blending (instead of a ShaderMask blend mode)
    // keeps the sweep clearly visible regardless of how subtle the gradient token colors are.
    final shimmer = LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        return AnimatedBuilder(
          animation: _controller,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  tokens.colorGradientStartEnd,
                  tokens.colorGradientMiddle,
                  tokens.colorGradientStartEnd,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          builder: (context, child) {
            // Ease the sweep across the move fraction of the cycle, then hold it in place
            // (Interval clamps to the curve's end value) for the remaining pause fraction.
            final progress = Interval(
              0.0,
              _shimmerMoveFraction,
              curve: Curves.easeInOut,
            ).transform(_controller.value);
            final dx = -maxWidth + progress * 2 * maxWidth;
            return Transform.translate(offset: Offset(dx, 0), child: child);
          },
        );
      },
    );

    final content = SizedBox(
      width: 200,
      height: 62,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: tokens.colorBg),
            if (shouldAnimate) shimmer,
          ],
        ),
      ),
    );

    return Semantics(
      label: OudsLocalizations.of(context)?.core_common_loading_a11y,
      child: ExcludeSemantics(
        child: Padding(
          padding: widget.securityMargin
              ? EdgeInsets.symmetric(vertical: padding)
              : EdgeInsets.zero,
          child: content,
        ),
      ),
    );
  }
}
