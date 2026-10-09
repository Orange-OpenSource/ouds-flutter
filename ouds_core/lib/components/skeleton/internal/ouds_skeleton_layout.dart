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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';

/// Lays out [content] as usual so it keeps dictating the natural width/height/shape a component
/// would take, then — when [visible] is `true` — hides that content and overlays an
/// [OudsSkeleton] that exactly fills the same space, clipped to [shape].
///
/// This lets any OUDS component expose a "skeleton" state without hardcoding its own
/// width/height tokens for the skeleton: whatever size the component would normally render at
/// (fixed, intrinsic, or driven by parent constraints) is automatically reused.
///
/// ```dart
/// OudsSkeletonLayout(
///   visible: state == OudsButtonControlState.skeleton,
///   shape: const RoundedRectangleBorder(
///     borderRadius: BorderRadius.all(Radius.circular(8)),
///   ),
///   content: (context) => _ActualButtonContent(),
/// )
/// ```
class OudsSkeletonLayout extends StatelessWidget {
  /// Whether the skeleton should be displayed instead of [content].
  final bool visible;

  /// Whether to apply vertical padding to the skeleton. Defaults to `true`.
  final bool hasSecurityMargin;

  /// The shape used to clip the skeleton so it matches the content's own shape (e.g. a button's
  /// rounded corners). Defaults to a plain rectangle.
  final ShapeBorder shape;

  /// Builds the actual component content whose size/shape the skeleton should match.
  final WidgetBuilder content;

  /// Whether the shimmer sweep animation is enabled. Defaults to `true`.
  final bool animated;

  /// Creates an [OudsSkeletonLayout].
  const OudsSkeletonLayout({
    super.key,
    required this.visible,
    required this.content,
    this.hasSecurityMargin = true,
    this.shape = const RoundedRectangleBorder(),
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return content(context);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Keep the content in the tree -invisible but laid out- so it keeps driving the
        // overall size, without being interactive, announced or painted.
        Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IgnorePointer(
            child: ExcludeSemantics(child: content(context)),
          ),
        ),
        Positioned.fill(
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: shape),
            child: OudsSkeleton(
              hasSecurityMargin: hasSecurityMargin,
              animated: animated,
            ),
          ),
        ),
      ],
    );
  }
}
