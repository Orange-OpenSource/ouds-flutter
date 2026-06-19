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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_bar_tokens.dart';

/// A custom painter for drawing an animated navigation bar indicator.
///
/// The indicator expands from the center of the tab outwards to its edges,
/// creating a smooth animation effect when a tab becomes selected.
class _OudsIndicatorPainter extends CustomPainter {
  /// The animation value (0.0 to 1.0) controlling the expansion from center.
  final double animationValue;

  /// The color of the indicator line.
  final Color color;

  /// The height (thickness) of the indicator line.
  final double thickness;

  /// The width of the tab (used to determine expansion limits).
  final double tabWidth;

  /// The border radius of the indicator.
  final double borderRadius;

  _OudsIndicatorPainter({
    required this.animationValue,
    required this.color,
    required this.thickness,
    required this.tabWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /// Calculate the expansion: starts from center and expands to edges
    final centerX = tabWidth / 2;
    final maxExpansion = tabWidth / 2;
    final currentExpansion = maxExpansion * animationValue;

    /// Starting point (left edge) and ending point (right edge) of the indicator
    final startX = centerX - currentExpansion;
    final endX = centerX + currentExpansion;
    final rectWidth = endX - startX;

    /// Only draw if width is positive
    if (rectWidth > 0) {
      final rect = Rect.fromLTWH(startX, 0, rectWidth, thickness);
      final rrect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(borderRadius),
      );

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OudsIndicatorPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.tabWidth != tabWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}

/// A widget that renders an animated indicator with expansion from center animation.
///
/// Supports an optional [externalController] to allow the parent widget to
/// control the animation lifecycle. This is required on iOS where
/// [CupertinoTabBar] rebuilds items from scratch on each tap, preventing
/// [didUpdateWidget] from being called.
class OudsAnimatedIndicator extends StatefulWidget {
  /// Whether the indicator should be visible and animated.
  final bool isSelected;

  /// The color of the indicator.
  final Color color;

  /// The height (thickness) of the indicator line.
  final double thickness;

  /// The width of the tab containing this indicator.
  final double tabWidth;

  /// The border radius of the indicator.
  final double borderRadius;

  /// The duration of the animation.
  final Duration animationDuration;

  /// Optional external [AnimationController] managed by the parent widget.
  ///
  /// When provided, the widget uses this controller instead of creating its own.
  /// This is necessary on iOS to survive tab rebuilds.
  final AnimationController? externalController;

  const OudsAnimatedIndicator({
    super.key,
    required this.isSelected,
    required this.color,
    required this.thickness,
    required this.tabWidth,
    required this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 240),
    this.externalController, //240 Optional external controller for iOS
  });

  @override
  State<OudsAnimatedIndicator> createState() => _OudsAnimatedIndicatorState();
}

class _OudsAnimatedIndicatorState extends State<OudsAnimatedIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _internalController;

  /// Use external controller if provided, otherwise fallback to internal
  AnimationController get _controller =>
      widget.externalController ?? _internalController!;

  @override
  void initState() {
    super.initState();

    /// Only create internal controller if no external one is provided (Android)
    if (widget.externalController == null) {
      _internalController = AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      );

      /// Animate from 0 to 1 on first render if selected (Android)
      if (widget.isSelected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _internalController?.animateTo(
              1.0,
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
            );
          }
        });
      } else {
        _internalController?.value = 0.0;
      }
    }
  }

  @override
  void didUpdateWidget(covariant OudsAnimatedIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Only handle animation here for Android (internal controller)
    /// iOS animations are driven by the external controller in OudsTabBar
    if (widget.externalController == null &&
        widget.isSelected != oldWidget.isSelected) {
      _controller.animateTo(
        widget.isSelected ? 1.0 : 0.0,
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    /// Only dispose internal controller, never the external one
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.thickness,
      width: widget.tabWidth,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _OudsIndicatorPainter(
              animationValue: _controller.value,
              color: widget.color,
              thickness: widget.thickness,
              tabWidth: widget.tabWidth,
              borderRadius: widget.borderRadius,
            ),
          );
        },
      ),
    );
  }
}

/// Extension to easily access indicator animation properties from bar tokens.
extension OudsBarTokensIndicatorExtension on OudsBarTokens {
  /// Gets the animation duration for the indicator.
  Duration getIndicatorAnimationDuration() {
    return const Duration(milliseconds: 240);
  }
}
