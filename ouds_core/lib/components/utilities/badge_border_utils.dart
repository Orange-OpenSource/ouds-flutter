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
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Wraps [child] in a [_BadgeBorderWrapper] that draws a 1-px circular border
/// ring around the [OudsBadge] indicator.
///
/// The wrapper is a [StatelessWidget] so `badgeRadius` is read from its own
/// [BuildContext] — the same context (and the same clamped [MediaQuery]) that
/// [OudsBadge] uses — preventing a stale-radius gap when the system text scale
/// exceeds the navigation-bar cap (e.g. on iOS at accessibility sizes > 160%).
///
/// - [hasCount] `true` for a count badge (medium, 16 dp),
///              `false` for a dot badge (xsmall, 8 dp).
Widget buildBadgeWithBorder({
  required BuildContext context,
  required Widget child,
  required bool hasCount,
}) {
  return _BadgeBorderWrapper(hasCount: hasCount, child: child);
}

class _BadgeBorderWrapper extends StatelessWidget {
  const _BadgeBorderWrapper({required this.hasCount, required this.child});

  final bool hasCount;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bar = OudsTheme.of(context).componentsTokens(context).bar;
    final badgeTokens = OudsTheme.of(context).componentsTokens(context).badge;

    final badgeRadius =
        MediaQuery.textScalerOf(
          context,
        ).scale(hasCount ? badgeTokens.sizeMedium : badgeTokens.sizeXsmall) /
        2;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _BadgeBorderPainter(
                badgeRadius: badgeRadius,
                hasCount: hasCount,
                borderColor: bar.colorBorderBadge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Paints the circular border ring around the badge indicator.
///
/// Centre derived from Flutter Badge's `_RenderBadge.performLayout`:
///
/// - **Dot** (`!hasCount`): `centre = (W − r,  r)` — tracks radius as zoom grows.
/// - **Count** (`hasCount`): `centre = (W − 12 + r,  4)`
///   where `W−12 = (W − largeSize16) + effectiveOffsetX4` is the fixed left edge
///   of the pill, and `r = badgeRadius ≈ pillWidth/2` grows with zoom.
///
/// Draw radius = `badgeRadius + strokeWidth/2`.
class _BadgeBorderPainter extends CustomPainter {
  const _BadgeBorderPainter({
    required this.badgeRadius,
    required this.hasCount,
    required this.borderColor,
  });

  final double badgeRadius;
  final bool hasCount;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Dot  : Flutter Badge offset=Offset.zero, widthOffset=scaledSmallSize
    //        → top-left = (W − scaledSmallSize, 0) → centre = (W − r, r)
    //
    // Count: Flutter Badge effectiveOffset = Offset(4,4) (LTR default + Offset(0,8) fix).
    //        widthOffset = largeSize = 16 (fixed, unscaled).
    //        pill left edge = (W − 16) + 4 = W − 12  (constant).
    //        pill centre X = (W − 12) + pillWidth/2 ≈ (W − 12) + badgeRadius.
    //        pill centre Y = 4.0 (effectiveOffset.dy; ± pillHeight/2 cancels out).
    final double cx = hasCount
        ? size.width - 12.0 + badgeRadius
        : size.width - badgeRadius;
    final double cy = hasCount ? 4.0 : badgeRadius;

    const double strokeWidth = 1.0;
    canvas.drawCircle(
      Offset(cx, cy),
      badgeRadius + strokeWidth / 2,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
  }

  @override
  bool shouldRepaint(covariant _BadgeBorderPainter old) =>
      old.badgeRadius != badgeRadius ||
      old.hasCount != hasCount ||
      old.borderColor != borderColor;
}
