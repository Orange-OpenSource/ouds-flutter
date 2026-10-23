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
import 'package:ouds_core/components/list_item/internal/ouds_list_item_icon_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_indicator_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/utilities/asset_image_utils.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Shared widget builders for [OudsListItem] visual assets.
///
/// This utility avoids duplicating the same image/flag/icon rendering
/// logic across standard and small list item implementations.
class OudsListItemAssetBuilder {
  OudsListItemAssetBuilder._();

  /// Builds an image using list-item token sizes and [format] ratio.
  ///
  /// Accepts a path string to a local asset (raster or SVG).
  ///
  /// - [rounded] — when `true`, applies rounded corners using token-defined radius.
  /// - [semanticsLabel] — when provided, exposed to the accessibility tree;
  ///   when `null`, the image is excluded from semantics (decorative).
  /// - [backgroundColor] — optional background color shown behind the image (useful
  ///   for transparent or SVG placeholder assets).
  /// - [package] — when [asset] is bundled inside a package other than the
  ///   consuming app, pass the package name so it resolves correctly. Leave
  ///   `null` for assets declared by the app itself (the common case for
  ///   user-supplied list item leading/trailing images).
  static Widget _buildImage(
    BuildContext context,
    String asset,
    OudsListItemAssetSize size,
    OudsListItemImageFormat format, {
    bool rounded = false,
    String? semanticsLabel,
    Color? backgroundColor,
    String? package,
  }) {
    final (:width, :height, :borderRadius) = _imageLayout(
      context,
      size,
      format,
      rounded: rounded,
    );

    // Shared image/background rendering logic (see OudsAssetImageUtils).
    return Semantics(
      label: semanticsLabel,
      child: OudsAssetImageUtils.buildImageWithBackground(
        asset: asset,
        width: width,
        height: height,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        package: package,
      ),
    );
  }

  /// Token-based image layout shared by asset and asynchronous images:
  /// height from the [size] token, width from height × [format] ratio, and
  /// the token-defined rounded media radius when [rounded] is set.
  static ({double width, double height, BorderRadius? borderRadius})
  _imageLayout(
    BuildContext context,
    OudsListItemAssetSize size,
    OudsListItemImageFormat format, {
    bool rounded = false,
  }) {
    final height = size.value(context);
    return (
      width: height * format.ratio,
      height: height,
      borderRadius: rounded
          ? BorderRadius.circular(
              OudsTheme.of(context)
                  .componentsTokens(context)
                  .controlListItem
                  .borderRadiusMediaRounded,
            )
          : null,
    );
  }

  /// Builds an asynchronous image using list-item token sizes and [format]
  /// ratio.
  ///
  /// Accepts any [ImageProvider] ([NetworkImage], [MemoryImage] or a provider
  /// supplied by the application) — the Flutter counterpart of the Android
  /// `Painter` resolved by the app (e.g. with Coil).
  ///
  /// While the image is loading, and if loading fails, [placeholder] is
  /// displayed instead. When [placeholder] is `null`, [backgroundColor]
  /// (if provided) simply shows through as a plain placeholder.
  ///
  /// - [rounded] — when `true`, applies rounded corners using token-defined radius.
  /// - [semanticsLabel] — when provided, exposed to the accessibility tree;
  ///   when `null`, the image is excluded from semantics (decorative).
  /// - [backgroundColor] — optional background color shown behind the image;
  ///   also acts as the default placeholder when [placeholder] is `null`.
  static Widget _buildAsyncImage(
    BuildContext context,
    ImageProvider provider,
    OudsListItemAssetSize size,
    OudsListItemImageFormat format, {
    bool rounded = false,
    String? semanticsLabel,
    Color? backgroundColor,
    Widget? placeholder,
  }) {
    final (:width, :height, :borderRadius) = _imageLayout(
      context,
      size,
      format,
      rounded: rounded,
    );

    // Without a custom placeholder, keep the image footprint so the
    // background color (if any) shows through while loading.
    Widget placeholderWidget() =>
        placeholder ?? SizedBox(width: width, height: height);

    return Semantics(
      label: semanticsLabel,
      child: OudsAssetImageUtils.buildWidgetWithBackground(
        width: width,
        height: height,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        image: Image(
          image: provider,
          width: width,
          height: height,
          fit: BoxFit.cover,
          excludeFromSemantics: true,
          // Show the placeholder until the first frame is ready…
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
              (wasSynchronouslyLoaded || frame != null)
              ? child
              : placeholderWidget(),
          // …and keep it visible when loading failed.
          errorBuilder: (context, error, stackTrace) => placeholderWidget(),
        ),
      ),
    );
  }

  /// Builds a leading or trailing image slot: asynchronous rendering when a
  /// [provider] is given, local [asset] rendering otherwise. Both share the
  /// same token sizes, brand-primary background and rounded style.
  static Widget buildImageSlot(
    BuildContext context, {
    String? asset,
    ImageProvider? provider,
    Widget? placeholder,
    String? semanticsLabel,
    required OudsListItemAssetSize size,
    required OudsListItemImageFormat format,
    required bool rounded,
  }) {
    final backgroundColor = OudsTheme.of(
      context,
    ).colorScheme(context).surfaceBrandPrimary;

    if (provider != null) {
      return _buildAsyncImage(
        context,
        provider,
        size,
        format,
        rounded: rounded,
        semanticsLabel: semanticsLabel,
        backgroundColor: backgroundColor,
        placeholder: placeholder,
      );
    }
    return _buildImage(
      context,
      asset!,
      size,
      format,
      rounded: rounded,
      semanticsLabel: semanticsLabel,
      backgroundColor: backgroundColor,
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
    final tokens = OudsTheme.of(
      context,
    ).componentsTokens(context).controlListItem;
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

  //   final resolvedSize = size.value(context);
  //   return SizedBox(
  //     width: resolvedSize,
  //     height: resolvedSize,
  //     child: Icon(
  //       Icons.play_circle_outline,
  //       color: OudsListItemForegroundModifier(context).contentColor(enable),
  //     ),
  //   );
  // }

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
    final resolvedSize = size.value(context);

    return SvgPicture.asset(
      assetName,
      matchTextDirection: true,
      width: resolvedSize,
      height: resolvedSize,
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
  ///
  /// Example:
  /// ```dart
  /// OudsListItemAssetBuilder.buildIcon(
  ///   context,
  ///   Neutral(icon: 'assets/icons/star.svg'),
  ///   enable: true,
  ///   size: OudsListItemAssetSize.medium,
  /// )
  /// ```
  static Widget buildIcon(
    BuildContext context,
    OudsIconStatus iconStatus, {
    bool enable = true,
    OudsListItemAssetSize size = OudsListItemAssetSize.medium,
  }) {
    return OudsListItemIconModifier(
      context,
    ).buildIcon(iconStatus, enable: enable, size: size);
  }
}
