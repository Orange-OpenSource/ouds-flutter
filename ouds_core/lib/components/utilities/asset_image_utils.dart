/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 *
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 *
 * // Software description: Flutter library of reusable graphical components
 *
 */

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shared image-rendering helpers reusable across OUDS components
/// (list item, card item, and any future component needing an image with
/// an optional background color and/or rounded corners).
class OudsAssetImageUtils {
  OudsAssetImageUtils._();

  /// Builds an image (raster or SVG, resolved from [asset]) with an optional
  /// [backgroundColor] shown behind it (useful for transparent or SVG
  /// placeholder assets) and optional [borderRadius] rounding.
  ///
  /// - [package] — when the asset is bundled inside a package other than the
  ///   consuming app (e.g. an asset shipped with `ouds_core` itself), pass the
  ///   package name so Flutter resolves it from `packages/<package>/<asset>`.
  ///   Leave `null` when [asset] lives in the app's own `assets/` declaration.
  /// - [contentDescription] — when provided, exposed to the accessibility tree;
  ///   when `null`, the image is excluded from semantics (decorative).
  /// - [fit] — defaults to [BoxFit.cover].
  static Widget buildImageWithBackground({
    required String asset,
    required double width,
    required double height,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    String? contentDescription,
    String? package,
    BoxFit fit = BoxFit.cover,
  }) {
    final Widget imageWidget = asset.endsWith('.svg')
        ? SvgPicture.asset(
            asset,
            width: width,
            height: height,
            fit: fit,
            package: package,
            semanticsLabel: contentDescription,
            excludeFromSemantics: contentDescription == null,
          )
        : Image.asset(
            asset,
            width: width,
            height: height,
            fit: fit,
            package: package,
            semanticLabel: contentDescription,
            excludeFromSemantics: contentDescription == null,
          );

    final Widget result = backgroundColor != null
        ? Container(
            color: backgroundColor,
            width: width,
            height: height,
            child: imageWidget,
          )
        : imageWidget;

    if (borderRadius == null) return result;

    return ClipRRect(borderRadius: borderRadius, child: result);
  }
}
