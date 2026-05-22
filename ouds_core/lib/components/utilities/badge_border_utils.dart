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

/// Wraps [child] in a [Stack] and draws a 1-px circular border ring around
/// the [OudsBadge] indicator.
///
/// The ring is rendered via [CustomPaint] — the badge itself is never altered.
/// Its position and radius adapt automatically to any icon size or
/// accessibility text-scale factor.
///
/// **Parameters**
///
/// - [context]  — resolves badge-size tokens and the border colour from the
///               active OUDS theme.
/// - [child]    — the badge widget to wrap (typically an [OudsBadge]).
/// - [hasCount] — `true` for a numeric count badge (medium, 16 dp),
///               `false` for a plain dot badge (xsmall, 8 dp).
///
/// **Example — dot badge (xsmall)**
/// ```dart
/// buildBadgeWithBorder(
///   context: context,
///   hasCount: false,
///   child: myBadgeWidget,
/// );
/// ```
///
/// **Example — count badge (medium)**
/// ```dart
/// buildBadgeWithBorder(
///   context: context,
///   hasCount: true,
///   child: myBadgeWidget,
/// );
/// ```
Widget buildBadgeWithBorder({
  required BuildContext context,
  required Widget child,
  required bool hasCount,
}) {
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

/// Paints the circular border ring around the badge indicator.
///
/// The ring centre is derived from Flutter Badge's layout algorithm
/// ([_RenderBadge.performLayout]):
///
/// - **Dot** (`!hasCount`): `centre = (width − r,  r)`
/// - **Count** (`hasCount`): `centre = (width − r + 4,  4)`
///   where `4` is the LTR effective offset applied to labelled badges.
///
/// The draw radius is set to `badgeRadius + strokeWidth / 2` so that the
/// inner edge of the stroke touches the badge boundary with no gap.
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
    final double cx = hasCount
        ? size.width - badgeRadius + 4
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
