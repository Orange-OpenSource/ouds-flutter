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

/// Controls how the focus ring stroke is positioned relative to the widget bounds.
enum FocusAlignment {
  /// The stroke is fully inside the widget bounds.
  inside,

  /// The stroke is centered on the widget bounds (half inside, half outside).
  center,

  /// The stroke is fully outside the widget bounds.
  outside,
}

/// A [CustomPainter] that draws a rounded-rectangle focus ring.
///
/// The ring is drawn using a stroke of [strokeWidth] and rounded corners
/// defined by [borderRadius]. The ring position depends on [alignment]:
/// - [FocusAlignment.inside] deflates the rect by half the stroke width.
/// - [FocusAlignment.center] draws on the original rect.
/// - [FocusAlignment.outside] inflates the rect by half the stroke width.
class FocusContainerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double borderRadius;
  final FocusAlignment alignment;

  FocusContainerPainter({
    required this.color,
    required this.strokeWidth,
    required this.borderRadius,
    this.alignment = FocusAlignment.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color
      ..isAntiAlias = true;

    Rect baseRect = Offset.zero & size;
    RRect rrect = RRect.fromRectAndRadius(baseRect, Radius.circular(borderRadius));

    final half = strokeWidth / 2;
    if (alignment == FocusAlignment.outside) {
      rrect = rrect.inflate(half);
    } else if (alignment == FocusAlignment.inside) {
      rrect = rrect.deflate(half);
    }
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant FocusContainerPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth || oldDelegate.borderRadius != borderRadius || oldDelegate.alignment != alignment;
  }
}

/// Wraps [child] with an optional focus ring and an optional inset border.
///
/// When [isFocused] is true, a focus ring is painted using [CustomPaint]
/// inside a [Stack]. The ring uses theme tokens (focus border color/width)
/// and can be visually aligned via [alignment].
///
/// This widget is designed to be used by interactive components to make
/// keyboard focus visible (for example when navigating with Tab).
class FocusContainer extends StatelessWidget {
  /// The content widget.
  final Widget child;

  /// Optional ring color (defaults to transparent).
  ///
  /// Note: the current implementation uses theme colors for the painted ring.
  final Color color;

  /// The stroke width used for the focus ring.
  ///
  /// Note: the current implementation uses theme tokens for the painted ring.
  final double strokeWidth;

  /// Corner radius used for the focus ring and the inset border.
  final double borderRadius;

  /// Focus ring alignment relative to the widget bounds.
  final FocusAlignment alignment;

  /// Whether the focus ring should be visible.
  final bool isFocused;

  const FocusContainer({
    super.key,
    required this.child,
    this.color = Colors.transparent,
    this.strokeWidth = 5,
    this.borderRadius = 8,
    this.alignment = FocusAlignment.center,
    this.isFocused = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderTokens = OudsTheme.of(context).borderTokens;

    if (!isFocused) {
      // Pas de focus - retourner le child directement sans wrapper
      return child;
    }

    // Avec focus - dessiner les borders par-dessus avec CustomPaint
    // Utiliser borderTokens au lieu des paramètres pour s'adapter au thème
    return CustomPaint(
      painter: FocusContainerPainter(
        color: color,
        strokeWidth: borderTokens.widthFocus,
        borderRadius: borderRadius,
        alignment: FocusAlignment.center,
      ),
      foregroundPainter: FocusContainerPainter(
        color: OudsTheme.of(context).colorScheme(context).borderFocusInset,
        strokeWidth: borderTokens.widthFocusInset,
        borderRadius: borderRadius,
        alignment: FocusAlignment.inside,
      ),
      child: child,
    );
  }
}
