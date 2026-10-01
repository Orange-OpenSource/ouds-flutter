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
    this.securityMargin = true,
  });

  @override
  State<OudsSkeleton> createState() => _OudsSkeletonState();
}

class _OudsSkeletonState extends State<OudsSkeleton>
    with SingleTickerProviderStateMixin {
  static const _shimmerDuration = Duration(milliseconds: 1500);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _shimmerDuration)
      ..repeat();
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

    final placeholder = Container(
      padding: widget.securityMargin
          ? EdgeInsets.symmetric(vertical: padding)
          : EdgeInsets.zero,
      width: 200,
      height: 62,
      color: tokens.colorBg,
    );

    final content = shouldAnimate
        ? AnimatedBuilder(
            animation: _controller,
            child: placeholder,
            builder: (context, child) {
              return ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    tokens.colorGradientStartEnd,
                    tokens.colorGradientMiddle,
                    tokens.colorGradientStartEnd,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  transform: _OudsSkeletonShimmerTransform(
                    slidePercent: _controller.value,
                  ),
                ).createShader(bounds),
                child: child,
              );
            },
          )
        : placeholder;

    return Semantics(
      label: OudsLocalizations.of(context)?.core_common_loading_a11y,
      child: ExcludeSemantics(child: content),
    );
  }
}

/// Slides the shimmer gradient horizontally across the skeleton's bounds as [slidePercent] goes
/// from `0.0` to `1.0`. The gradient enters fully off-screen on one side and exits fully
/// off-screen on the other, so the sweep loops smoothly when the driving animation repeats.
class _OudsSkeletonShimmerTransform extends GradientTransform {
  const _OudsSkeletonShimmerTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * (slidePercent * 3 - 1.5),
      0.0,
      0.0,
    );
  }
}
