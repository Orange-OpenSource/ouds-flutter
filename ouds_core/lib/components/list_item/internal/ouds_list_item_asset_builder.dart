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
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_foreground_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_icon_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_indicator_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/utilities/asset_image_utils.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Shared widget builders for [OudsListItem] visual assets.
///
/// This utility avoids duplicating the same image/flag/video/icon rendering
/// logic across standard and small list item implementations.
class OudsListItemAssetBuilder {
  OudsListItemAssetBuilder._();

  /// Builds an image using list-item token sizes and [format] ratio.
  ///
  /// Accepts a path string to a local asset (raster or SVG).
  ///
  /// - [rounded] — when `true`, applies rounded corners using token-defined radius.
  /// - [contentDescription] — when provided, exposed to the accessibility tree;
  ///   when `null`, the image is excluded from semantics (decorative).
  /// - [backgroundColor] — optional background color shown behind the image (useful
  ///   for transparent or SVG placeholder assets).
  /// - [package] — when [asset] is bundled inside a package other than the
  ///   consuming app, pass the package name so it resolves correctly. Leave
  ///   `null` for assets declared by the app itself (the common case for
  ///   user-supplied list item leading/trailing images).
  static Widget buildImage(
    BuildContext context,
    String asset,
    OudsListItemAssetSize size,
    OudsListItemImageFormat format, {
    bool rounded = false,
    String? contentDescription,
    Color? backgroundColor,
    String? package,
  }) {
    final height = size.value(context);
    final width = height * format.ratio;

    final borderRadius = rounded
        ? BorderRadius.circular(
            OudsTheme.of(
              context,
            ).componentsTokens(context).listItem.borderRadiusMediaRounded,
          )
        : null;

    // Shared image/background rendering logic — reused by other components.
    return OudsAssetImageUtils.buildImageWithBackground(
      asset: asset,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      contentDescription: contentDescription,
      package: package,
    );
  }

  /// Builds a medium flag image with fixed radius and token-defined dimensions.
  ///
  /// @Deprecated Use [OudsFlag] directly instead.
  /// This method will be removed when [countries.dart] is deleted.
  @Deprecated(
    'Use OudsFlag(countryCode) instead. '
    'This method will be removed together with countries.dart.',
  )
  static Widget buildFlag(BuildContext context, ImageProvider asset) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Image(
        image: asset,
        width: tokens.sizeAssetMedium,
        height: tokens.sizeFlagHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Builds a video placeholder icon using token-defined size.
  ///
  /// - [size] — defaults to [OudsListItemAssetSize.medium].
  /// - [enable] — when `false`, the icon is rendered in its disabled appearance.
  static Widget buildVideoPlaceholder(
    BuildContext context, {
    OudsListItemAssetSize size = OudsListItemAssetSize.medium,
    bool enable = true,
  }) {
    final resolvedSize = size.value(context);
    return SizedBox(
      width: resolvedSize,
      height: resolvedSize,
      child: Icon(
        Icons.play_circle_outline,
        color: OudsListItemForegroundModifier(context).contentColor(enable),
      ),
    );
  }

  /// Builds a tinted SVG icon asset used as a navigation indicator (chevron/external link).
  ///
  /// - [listItemState] — full interaction state, used for hover/pressed/focused colors.
  /// - [enable] — when `false`, the icon is tinted with `contentDisabled` so it
  ///   remains visible against the background (consistent with [buildIcon]).
  static Widget buildIndicatorIcon(
    BuildContext context,
    String assetName,
    OudsListItemAssetSize size,
    OudsListItemControlState listItemState,
    String? packageName, {
    bool enable = true,
  }) {
    final color = enable
        ? OudsListItemIndicatorModifier(context).indicatorColor(listItemState)
        : OudsTheme.of(context).colorScheme(context).contentDisabled;

    return SvgPicture.asset(
      assetName,
      width: size.value(context),
      height: size.value(context),
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      package: packageName,
      excludeFromSemantics: true,
    );
  }

  /// Builds a status icon widget for a list-item leading or trailing slot.
  ///
  /// This is the list-item equivalent of [OudsTextInput.buildIcon].
  ///
  /// - [iconStatus] — the [OudsIconStatus] that determines the icon asset and color.
  /// - [enable] — when `false`, the icon is rendered in its disabled appearance.
  /// - [size] — controls rendered dimensions using token values.
  ///   Defaults to [OudsListItemAssetSize.medium].
  /// - [tinted] — when `false`, no color filter is applied (useful for
  ///   multicolor icons). Defaults to `true`.
  ///
  /// Example:
  /// ```dart
  /// OudsListItemAssetBuilder.buildIcon(
  ///   context,
  ///   Neutral(icon: 'assets/icons/star.svg'),
  ///   enable: true,
  ///   size: OudsListItemAssetSize.medium,
  ///   tinted: true,
  /// )
  /// ```
  static Widget buildIcon(
    BuildContext context,
    OudsIconStatus iconStatus, {
    bool enable = true,
    OudsListItemAssetSize size = OudsListItemAssetSize.medium,
    bool tinted = true,
  }) {
    return OudsListItemIconModifier(
      context,
    ).buildIcon(iconStatus, enable: enable, size: size, tinted: tinted);
  }
}
