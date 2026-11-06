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

/// {@category List item}
library;

import 'package:flutter/material.dart';
// TODO[v1.0]: Uncomment when avatar support is implemented.
// import 'package:ouds_core/components/avatar/ouds_avatar.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
// TODO[v1.0]: Uncomment when flag support is implemented.
// import 'package:ouds_core/components/flag/ouds_flag.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';

/// Base sealed class for the leading slot of an [OudsListItem].
///
/// Each subclass is a **data class** — it holds configuration only.
/// Rendering is handled by `_buildLeading` inside [OudsListItem].
sealed class OudsListItemLeading {
  /// Creates a leading-slot configuration.
  const OudsListItemLeading();
}

/// Leading icon slot.
///
/// Use an icon to reinforce the meaning of the item or help users identify
/// a familiar category, object or status.
///
/// Example:
/// ```dart
/// OudsListItemLeadingIcon(Neutral(icon: 'assets/icons/star.svg'))
/// OudsListItemLeadingIcon(Positive(), size: OudsListItemIconSize.large, tinted: false)
/// ```
class OudsListItemLeadingIcon extends OudsListItemLeading {
  /// The icon status that drives both the asset and its color.
  ///
  /// Functional statuses ([Positive], [Info], [Warning], [Negative]) use fixed
  /// icons. The contextual status ([Neutral]) accepts a custom icon asset
  /// path. [Accent] is not supported in list item icon slots.
  final OudsIconStatus iconStatus;

  /// Size of the icon. Defaults to [OudsListItemIconSize.medium].
  ///
  /// - [OudsListItemIconSize.medium]: Preferred for standard and compact items
  ///   when the icon provides secondary visual support.
  /// - [OudsListItemIconSize.large]: Use when the icon needs stronger prominence
  ///   or when the item has multiline content or additional information.
  final OudsListItemIconSize size;

  /// Creates a leading icon configuration.
  ///
  /// Throws an [AssertionError] if [iconStatus] is [Accent].
  const OudsListItemLeadingIcon(
    this.iconStatus, {
    this.size = OudsListItemIconSize.medium,
  }) : assert(
         iconStatus is! Accent,
         'Accent is not supported in list item icon slots. '
         'Use Neutral with a custom icon instead.',
       );
}

/// Leading image slot.
///
/// The image comes either from a local [asset] or from an asynchronous
/// source ([NetworkImage], [MemoryImage] or any custom [ImageProvider])
/// via the `provider` named constructor — the Flutter counterpart of passing
/// an async `Painter` on Android.
///
/// Example:
/// ```dart
/// OudsListItemLeadingImage(
///   asset: 'assets/images/photo.jpg',
///   semanticsLabel: 'Product photo',
///   size: OudsListItemImageSize.large,
///   format: OudsListItemImageFormat.widescreen,
///   rounded: true,
/// )
/// // Asynchronous image from the network, with a placeholder shown while
/// // loading (and if loading fails)
/// OudsListItemLeadingImage.provider(
///   provider: NetworkImage('https://example.com/photo.jpg'),
///   semanticsLabel: 'Product photo',
///   placeholder: Image.asset('assets/placeholder.jpg'),
/// )
/// // Or from any other ImageProvider (memory, file, app-provided caching
/// // library), with a custom placeholder
/// OudsListItemLeadingImage.provider(
///   provider: MemoryImage(bytes),
///   placeholder: const ColoredBox(color: Color(0xFFEFEFEF)),
/// )
/// ```
class OudsListItemLeadingImage extends OudsListItemLeading {
  /// Path to the image asset (raster or SVG).
  ///
  /// Mutually exclusive with [provider] — set by the default constructor.
  final String? asset;

  /// Image provider for an image loaded asynchronously or from a non-asset
  /// source ([NetworkImage], [MemoryImage] or any custom provider).
  ///
  /// Mutually exclusive with [asset] — set by the `provider` named constructor.
  final ImageProvider? provider;

  /// Widget displayed in place of the image while [provider] is loading and
  /// if loading fails. Ignored for asset images.
  ///
  /// When `null`, the image background color is shown as a plain placeholder.
  final Widget? placeholder;

  /// Accessibility description of the image for screen readers.
  ///
  /// When `null`, the image is excluded from the accessibility tree.
  final String? semanticsLabel;

  /// Size of the image. Defaults to [OudsListItemImageSize.medium].
  ///
  /// - [OudsListItemImageSize.medium]: Use in compact or information-dense
  ///   lists where the image remains secondary to the text.
  /// - [OudsListItemImageSize.large]: Use in standard content lists where
  ///   visual identification is important.
  /// - [OudsListItemImageSize.extraLarge]: Use when the image is a significant
  ///   part of the content, such as a product or media preview.
  final OudsListItemImageSize size;

  /// Aspect-ratio format. Defaults to [OudsListItemImageFormat.square].
  ///
  /// - [OudsListItemImageFormat.square] (1:1): Use for square visual content
  ///   such as products, logos, album covers or profile-related imagery.
  /// - [OudsListItemImageFormat.widescreen] (16:9): Use for landscape content
  ///   such as editorial images or wide media thumbnails.
  final OudsListItemImageFormat format;

  /// Whether the image is displayed with rounded corners. Defaults to `false`.
  ///
  /// The corner style should reflect the type of content and remain consistent
  /// with the visual language used elsewhere in the product.
  ///
  /// - `false`: Displays the image with square corners.
  /// - `true`: Displays the image with rounded corners.
  final bool rounded;

  /// Creates a leading image configuration from a local asset.
  const OudsListItemLeadingImage({
    required String this.asset,
    this.semanticsLabel,
    this.size = OudsListItemImageSize.medium,
    this.format = OudsListItemImageFormat.square,
    this.rounded = false,
  }) : provider = null,
       placeholder = null;

  /// Creates a leading image configuration from any [ImageProvider]
  /// ([NetworkImage], [MemoryImage] or a provider supplied by the app).
  ///
  /// [placeholder] is shown while the image is loading and if loading fails;
  /// when `null`, the image background color shows through instead.
  ///
  /// ```dart
  /// OudsListItemLeadingImage.provider(
  ///   provider: NetworkImage('https://example.com/photo.jpg'),
  ///   semanticsLabel: 'Product photo',
  ///   placeholder: Image.asset('assets/placeholder.jpg'),
  /// )
  /// ```
  const OudsListItemLeadingImage.provider({
    required this.provider,
    this.semanticsLabel,
    this.size = OudsListItemImageSize.medium,
    this.format = OudsListItemImageFormat.square,
    this.rounded = false,
    this.placeholder,
  }) : asset = null;
}

// TODO[v1.0]: Uncomment when flag support is implemented.
// /// Leading flag slot — renders an [OudsFlag] on the leading side of the row.
// ///
// /// Pass an [OudsFlag] with the desired country code. The flag is resized to
// /// match the list item token dimensions, whatever its intrinsic size.
// ///
// /// Example:
// /// ```dart
// /// OudsListItemLeadingFlag(OudsFlag('fr'))
// /// OudsListItemLeadingFlag(OudsFlag('us'))
// /// ```
// class OudsListItemLeadingFlag extends OudsListItemLeading {
//   /// The flag widget to display.
//   final OudsFlag flag;
//
//   /// Creates a leading flag configuration.
//   const OudsListItemLeadingFlag(this.flag);
// }

// TODO[v1.0]: Uncomment when avatar support is implemented.
// /// Leading avatar slot.
// ///
// /// Example:
// /// ```dart
// ///
// /// OudsListItemLeadingAvatar(OudsAvatar(monogram: 'JD'))
// /// ```
// class OudsListItemLeadingAvatar extends OudsListItemLeading {
//   /// The avatar widget to display.
//   final OudsAvatar avatar;
//
//   /// Creates a leading avatar configuration.
//   const OudsListItemLeadingAvatar(this.avatar);
// }

/// A custom leading slot with a widget builder function.
///
/// Used internally by [OudsSmallListItem] to adapt its own leading types.
class OudsListItemLeadingCustom extends OudsListItemLeading {
  /// Builder used to render the custom leading content.
  final Widget Function(BuildContext context, {bool enable}) builder;

  /// Creates a custom leading configuration.
  const OudsListItemLeadingCustom(this.builder);
}

/// A fully custom leading slot.
///
/// Use it for custom leading content that cannot be represented by the other
/// available leading types. It provides flexibility for specific product
/// requirements, but it should be used as an exception rather than the default
/// solution.
///
/// The [builder] receives the current [OudsListItemControlState] so the custom
/// content can adapt its appearance (e.g. opacity, color) to the item's
/// interaction state.
///
/// The rendered content is capped to the `sizeMaxSizeLeadingTrailingSlot`
/// component token on both dimensions (96 dp on Orange, 72 dp on Orange
/// Compact).
///
/// Example:
/// ```dart
/// OudsListItemLeadingContent(
///   (context, state) => MyCustomLeadingWidget(enabled: state != OudsListItemControlState.disabled),
/// )
/// ```
class OudsListItemLeadingContent extends OudsListItemLeading {
  /// Builder used to render the custom leading content with the current [OudsListItemControlState].
  final Widget Function(BuildContext context, OudsListItemControlState state)
  builder;

  /// Creates a leading content configuration.
  const OudsListItemLeadingContent(this.builder);
}
