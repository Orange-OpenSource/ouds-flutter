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

/// {@category List item}
library;

import 'package:ouds_theme_contract/theme/tokens/components/ouds_listItem_tokens.dart';

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

  /// Resolves the pixel size from token values.
  double value(OudsListItemTokens tokens) => switch (this) {
    OudsListItemAssetSize.small => tokens.sizeAssetSmall,
    OudsListItemAssetSize.medium => tokens.sizeAssetMedium,
    OudsListItemAssetSize.large => tokens.sizeAssetLarge,
    OudsListItemAssetSize.extraLarge => tokens.sizeAssetXlarge,
  };
}

/// Represents the size of an icon slot inside an [OudsListItem].
enum OudsListItemIconSize {
  /// Medium icon — maps to [OudsListItemAssetSize.medium].
  medium,

  /// Large icon — maps to [OudsListItemAssetSize.large].
  large;

  /// Converts to the corresponding [OudsListItemAssetSize].
  OudsListItemAssetSize get assetSize => switch (this) {
    OudsListItemIconSize.medium => OudsListItemAssetSize.medium,
    OudsListItemIconSize.large => OudsListItemAssetSize.large,
  };
}

/// Represents the size of an image slot inside an [OudsListItem].
enum OudsListItemImageSize {
  /// Medium image — maps to [OudsListItemAssetSize.medium].
  medium,

  /// Large image — maps to [OudsListItemAssetSize.large].
  large,

  /// Extra-large image — maps to [OudsListItemAssetSize.extraLarge].
  extraLarge;

  /// Converts to the corresponding [OudsListItemAssetSize].
  OudsListItemAssetSize get assetSize => switch (this) {
    OudsListItemImageSize.medium => OudsListItemAssetSize.medium,
    OudsListItemImageSize.large => OudsListItemAssetSize.large,
    OudsListItemImageSize.extraLarge => OudsListItemAssetSize.extraLarge,
  };
}

/// Represents the aspect-ratio format of an image inside an [OudsListItem].
enum OudsListItemImageFormat {
  /// Square image (1:1 ratio).
  square,

  /// Panoramic image (16:9 ratio).
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
  const OudsListItemIndicator();
}

/// Forward navigation indicator — chevron displayed at the **end** of the row.
///
/// Default indicator for navigation list items.
class OudsListItemIndicatorNext extends OudsListItemIndicator {
  const OudsListItemIndicatorNext();
}

/// Backward navigation indicator — chevron displayed at the **start** of the row.
class OudsListItemIndicatorPrevious extends OudsListItemIndicator {
  const OudsListItemIndicatorPrevious();
}

/// External navigation indicator — icon displayed at the **end** of the row,
/// typically used for links that open outside the current context.
class OudsListItemIndicatorExternal extends OudsListItemIndicator {
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

  const OudsListItemDecoration({required this.divider});
}

/// No decoration — optionally shows a bottom divider.
///
/// This is the default decoration for [OudsListItem].
final class OudsListItemDecorationNone extends OudsListItemDecoration {
  const OudsListItemDecorationNone({bool divider = true})
    : super(divider: divider);
}

/// Persistent background highlight — optionally shows a bottom divider.
///
/// The background color is drawn in all states (enabled, disabled, hovered, …).
final class OudsListItemDecorationBackground extends OudsListItemDecoration {
  const OudsListItemDecorationBackground({bool divider = true})
    : super(divider: divider);
}

/// Background shown only on interaction (hover / press / focus) — optionally
/// shows a bottom divider. No background is drawn when enabled or disabled.
final class OudsListItemDecorationBackgroundOnInteraction
    extends OudsListItemDecoration {
  const OudsListItemDecorationBackgroundOnInteraction({bool divider = true})
    : super(divider: divider);
}

/// Persistent outlined border — no divider.
final class OudsListItemDecorationOutlined extends OudsListItemDecoration {
  const OudsListItemDecorationOutlined() : super(divider: false);
}

/// Outlined border shown only on interaction — no divider.
final class OudsListItemDecorationOutlinedOnInteraction
    extends OudsListItemDecoration {
  const OudsListItemDecorationOutlinedOnInteraction() : super(divider: false);
}
