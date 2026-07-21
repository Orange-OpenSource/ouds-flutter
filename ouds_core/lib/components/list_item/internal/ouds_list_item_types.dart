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
import 'package:ouds_theme_contract/ouds_theme.dart';

// ---------------------------------------------------------------------------
// Asset & icon sizes
// ---------------------------------------------------------------------------

/// Represents the size of an asset (icon or image) inside an [OudsListItem].
enum OudsListItemAssetSize {
  /// Small asset — maps to [OudsListItemTokens.sizeAssetSmall].
  small,

  /// Medium asset — maps to [OudsListItemTokens.sizeAssetMedium].
  medium,

  /// Large asset — maps to [OudsListItemTokens.sizeAssetLarge].
  large,

  /// Extra-large asset — maps to [OudsListItemTokens.sizeAssetXlarge].
  extraLarge;

  /// Resolves the pixel size from the active theme tokens.
  double value(BuildContext context) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    return switch (this) {
      OudsListItemAssetSize.small => tokens.sizeAssetSmall,
      OudsListItemAssetSize.medium => tokens.sizeAssetMedium,
      OudsListItemAssetSize.large => tokens.sizeAssetLarge,
      OudsListItemAssetSize.extraLarge => tokens.sizeAssetXlarge,
    };
  }
}

/// Represents the size of an icon slot inside a default-size [OudsListItem]
/// or [OudsCardItem].
///
/// Use an icon to reinforce the meaning of the item or help users identify
/// a familiar category, object or status.
///
/// ⚠️ Only [medium] and [large] are available at default size — reusing the
/// existing [OudsListItemAssetSize.medium] / [OudsListItemAssetSize.large]
/// tokens (no dedicated icon-size token). The compact variants
/// (`OudsSmallListItem` / `OudsSmallCardItem`) do not expose this enum: their
/// icons are always rendered at the single [OudsListItemAssetSize.small] size.
enum OudsListItemIconSize {
  /// Medium icon — maps to [OudsListItemAssetSize.medium].
  ///
  /// Use for standard and compact list items. This is the preferred size when
  /// the icon provides secondary visual support.
  medium,

  /// Large icon — maps to [OudsListItemAssetSize.large].
  ///
  /// Use when the icon needs stronger prominence or when the item has a larger
  /// height, multiline content or additional supporting information.
  large;

  /// Converts to the corresponding [OudsListItemAssetSize].
  OudsListItemAssetSize get assetSize => switch (this) {
    OudsListItemIconSize.medium => OudsListItemAssetSize.medium,
    OudsListItemIconSize.large => OudsListItemAssetSize.large,
  };
}

/// Represents the size of an image slot inside an [OudsListItem].
///
/// Controls the dimensions and visual prominence of the image.
///
/// ⚠️ **Important**: Use the same image size for equivalent items within the
/// same list. Do not mix sizes arbitrarily. Different sizes may suggest a
/// hierarchy or importance that does not exist.
enum OudsListItemImageSize {
  /// Medium image — maps to [OudsListItemAssetSize.medium].
  ///
  /// Use in compact or information-dense lists where the image remains
  /// secondary to the text.
  medium,

  /// Large image — maps to [OudsListItemAssetSize.large].
  ///
  /// Use in standard content lists where visual identification is important.
  large,

  /// Extra-large image — maps to [OudsListItemAssetSize.extraLarge].
  ///
  /// Use when the image is a significant part of the content, such as a
  /// product or media preview.
  extraLarge;

  /// Converts to the corresponding [OudsListItemAssetSize].
  OudsListItemAssetSize get assetSize => switch (this) {
    OudsListItemImageSize.medium => OudsListItemAssetSize.medium,
    OudsListItemImageSize.large => OudsListItemAssetSize.large,
    OudsListItemImageSize.extraLarge => OudsListItemAssetSize.extraLarge,
  };
}

/// Represents the aspect-ratio format of an image inside an [OudsListItem].
///
/// Defines the aspect ratio of the image container.
///
/// ⚠️ **Important**: Do not crop meaningful content in a way that makes the
/// image difficult to understand. Use an appropriate focal point when the
/// source image is cropped automatically.
enum OudsListItemImageFormat {
  /// Square image (1:1 ratio).
  ///
  /// Use for square visual content such as products, logos, album covers or
  /// profile-related imagery.
  square,

  /// Panoramic image (16:9 ratio).
  ///
  /// Use for landscape content such as editorial images or wide media thumbnails.
  panoramic;

  /// Returns the width-to-height ratio for this format.
  double get ratio => switch (this) {
    OudsListItemImageFormat.square => 1.0,
    OudsListItemImageFormat.panoramic => 16.0 / 9.0,
  };
}

// ---------------------------------------------------------------------------
// Text style
// ---------------------------------------------------------------------------

/// Represents the text style of a text slot inside an [OudsListItem].
enum OudsListItemTextStyle {
  /// Default label style.
  label,

  /// Muted label style (secondary text color).
  labelMuted,

  /// Strong label style (bold).
  labelStrong,
}

// ---------------------------------------------------------------------------
// Indicator (navigation chevron / icon)
// ---------------------------------------------------------------------------

/// Represents the navigation indicator of an [OudsListItem].
///
/// An indicator is only rendered when the list item has an [OudsListItem.onTap]
/// callback (navigation variant). Use [OudsListItemDefaults.indicator] as the
/// default value.
sealed class OudsListItemIndicator {
  /// Creates a navigation-indicator configuration.
  const OudsListItemIndicator();
}

/// Forward navigation indicator — chevron displayed at the **end** of the row.
///
/// Default indicator for navigation list items.
class OudsListItemIndicatorNext extends OudsListItemIndicator {
  /// Creates a forward navigation indicator.
  const OudsListItemIndicatorNext();
}

/// Backward navigation indicator — chevron displayed at the **start** of the row.
class OudsListItemIndicatorPrevious extends OudsListItemIndicator {
  /// Creates a backward navigation indicator.
  const OudsListItemIndicatorPrevious();
}

/// External navigation indicator — icon displayed at the **end** of the row,
/// typically used for links that open outside the current context.
class OudsListItemIndicatorExternal extends OudsListItemIndicator {
  /// Creates an external navigation indicator.
  const OudsListItemIndicatorExternal();
}

// ---------------------------------------------------------------------------
// Decoration
// ---------------------------------------------------------------------------

/// Represents the visual decoration applied to an [OudsListItem].
///
/// Each subclass controls whether a divider is shown and whether a background
/// or outline is applied.
sealed class OudsListItemDecoration {
  /// Whether a bottom divider is displayed.
  final bool divider;

  /// Creates a list-item decoration configuration.
  const OudsListItemDecoration({required this.divider});
}

/// No decoration — optionally shows a bottom divider.
///
/// This is the default decoration for [OudsListItem].
final class OudsListItemDecorationNone extends OudsListItemDecoration {
  /// Creates a decoration without background or outline.
  const OudsListItemDecorationNone({super.divider = true});
}

/// Persistent background highlight — optionally shows a bottom divider.
///
/// The background color is drawn in all states (enabled, disabled, hovered, …).
final class OudsListItemDecorationBackground extends OudsListItemDecoration {
  /// Creates a decoration with a persistent background.
  const OudsListItemDecorationBackground({super.divider = true});
}

/// Background shown only on interaction (hover / press / focus) — optionally
/// shows a bottom divider. No background is drawn when enabled or disabled.
final class OudsListItemDecorationBackgroundOnInteraction
    extends OudsListItemDecoration {
  /// Creates a decoration that only shows a background on interaction.
  const OudsListItemDecorationBackgroundOnInteraction({super.divider = true});
}

/// Persistent outlined border — no divider.
final class OudsListItemDecorationOutlined extends OudsListItemDecoration {
  /// Creates a decoration with a persistent outline.
  const OudsListItemDecorationOutlined() : super(divider: false);
}

/// Outlined border shown only on interaction — no divider.
final class OudsListItemDecorationOutlinedOnInteraction
    extends OudsListItemDecoration {
  /// Creates a decoration that only shows an outline on interaction.
  const OudsListItemDecorationOutlinedOnInteraction() : super(divider: false);
}
