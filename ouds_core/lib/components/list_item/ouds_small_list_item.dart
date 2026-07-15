// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components

/// {@category List item}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_asset_builder.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_foreground_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

// All icons and images inside OudsSmallListItem use the small asset size.
const _kSmallAssetSize = OudsListItemAssetSize.small;

// ---------------------------------------------------------------------------
// Leading types (restricted subset of OudsListItemLeading)
// ---------------------------------------------------------------------------

/// Base type for [OudsSmallListItem] leading content.
///
/// Only [OudsSmallListItemLeadingIcon] and [OudsSmallListItemLeadingImage] are
/// supported — avatar, flag, video and text slots are not available at this size.
sealed class OudsSmallListItemLeading {
  const OudsSmallListItemLeading();
}

/// Leading icon slot for [OudsSmallListItem].
///
/// Always rendered at [OudsListItemAssetSize.small].
///
/// Example:
/// ```dart
/// OudsSmallListItemLeadingIcon(Positive())
/// OudsSmallListItemLeadingIcon(Neutral(icon: 'assets/icons/star.svg'), tinted: false)
/// ```
class OudsSmallListItemLeadingIcon extends OudsSmallListItemLeading {
  /// The icon status that drives both the icon asset and its color.
  ///
  /// Functional statuses ([Positive], [Info], [Warning], [Negative]) use fixed icons.
  /// Contextual statuses ([Neutral], [Accent]) accept a custom icon asset path.
  final OudsIconStatus iconStatus;

  /// Whether the icon is tinted with the theme color.
  /// Set to `false` for multicolor icons.
  final bool tinted;

  const OudsSmallListItemLeadingIcon(this.iconStatus, {this.tinted = true});
}

/// Leading image slot for [OudsSmallListItem].
///
/// Always rendered at [OudsListItemAssetSize.small].
///
/// Example:
/// ```dart
/// OudsSmallListItemLeadingImage(asset: AssetImage('assets/photo.jpg'))
/// OudsSmallListItemLeadingImage(
///   asset: AssetImage('assets/wide.jpg'),
///   format: OudsListItemImageFormat.panoramic,
/// )
/// ```
class OudsSmallListItemLeadingImage extends OudsSmallListItemLeading {
  /// The image to display, provided as an [ImageProvider] (e.g. [AssetImage], [NetworkImage]).
  final ImageProvider asset;

  /// Aspect-ratio format. Defaults to [OudsListItemImageFormat.square].
  final OudsListItemImageFormat format;

  const OudsSmallListItemLeadingImage({
    required this.asset,
    this.format = OudsListItemImageFormat.square,
  });
}

// ---------------------------------------------------------------------------
// Trailing types (restricted subset of OudsListItemTrailing)
// ---------------------------------------------------------------------------

/// Base type for [OudsSmallListItem] trailing content.
///
/// Only [OudsSmallListItemTrailingIcon], [OudsSmallListItemTrailingImage] and
/// [OudsSmallListItemTrailingText] are supported.
sealed class OudsSmallListItemTrailing {
  const OudsSmallListItemTrailing();
}

/// Trailing icon slot for [OudsSmallListItem].
///
/// Always rendered at [OudsListItemAssetSize.small].
///
/// Example:
/// ```dart
/// OudsSmallListItemTrailingIcon(Negative())
/// OudsSmallListItemTrailingIcon(Neutral(icon: 'assets/icons/star.svg'), tinted: false)
/// ```
class OudsSmallListItemTrailingIcon extends OudsSmallListItemTrailing {
  /// The icon status that drives both the icon asset and its color.
  ///
  /// Functional statuses ([Positive], [Info], [Warning], [Negative]) use fixed icons.
  /// Contextual statuses ([Neutral], [Accent]) accept a custom icon asset path.
  final OudsIconStatus icon;

  /// Whether the icon is tinted with the theme color.
  /// Set to `false` for multicolor icons.
  final bool tinted;

  const OudsSmallListItemTrailingIcon(this.icon, {this.tinted = true});
}

/// Trailing image slot for [OudsSmallListItem].
///
/// Always rendered at [OudsListItemAssetSize.small].
///
/// Example:
/// ```dart
/// OudsSmallListItemTrailingImage(asset: AssetImage('assets/photo.jpg'))
/// ```
class OudsSmallListItemTrailingImage extends OudsSmallListItemTrailing {
  /// The image to display, provided as an [ImageProvider] (e.g. [AssetImage], [NetworkImage]).
  final ImageProvider asset;

  /// Aspect-ratio format. Defaults to [OudsListItemImageFormat.square].
  final OudsListItemImageFormat format;

  const OudsSmallListItemTrailingImage({
    required this.asset,
    this.format = OudsListItemImageFormat.square,
  });
}

/// Trailing text slot for [OudsSmallListItem].
///
/// Example:
/// ```dart
/// OudsSmallListItemTrailingText('99€')
/// OudsSmallListItemTrailingText('Inactive', style: OudsListItemTextStyle.labelMuted)
/// ```
class OudsSmallListItemTrailingText extends OudsSmallListItemTrailing {
  /// The text content displayed as the trailing element.
  final String label;

  /// Text style. Defaults to [OudsListItemTextStyle.label].
  final OudsListItemTextStyle style;

  const OudsSmallListItemTrailingText(
    this.label, {
    this.style = OudsListItemTextStyle.label,
  });
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

/// [OUDS List Item Design Guidelines](https://r.orange.fr/r/S-ouds-doc-list-item)
///
/// **Reference design version : 1.0.0**
///
/// A compact variant of [OudsListItem] locked to [OudsListItemSize.smallSize].
///
/// Compared to [OudsListItem], this variant:
/// - Does **not** support [overline] or [extraLabel] — only [label] and [description].
/// - Restricts leading content to [OudsSmallListItemLeadingIcon] and [OudsSmallListItemLeadingImage].
/// - Restricts trailing content to [OudsSmallListItemTrailingIcon], [OudsSmallListItemTrailingImage]
///   and [OudsSmallListItemTrailingText].
/// - Renders all icons and images at [OudsListItemAssetSize.small].
///
/// ---
/// ## Variants
///
/// - **Static** — `background = true` by default, matches the Android default for read-only items.
///   No interaction states.
/// - **Navigation** — provide [onTap] to make the item interactive. The entire item
///   acts as a single link target and supports the following interaction states:
///   - **Enabled** — default state; transparent background, item available for navigation.
///   - **Hover** — visual feedback when a pointer is over the item. Does not
///     move content, change dimensions, or reveal hidden information.
///   - **Focus** — keyboard focus indicator drawn around the complete navigation
///     target (background + border ring).
///   - **Pressed** — temporary state while the item is being activated, applied
///     to the entire navigation target.
///
/// ---
/// ## Parameters
///
/// - [label]: The mandatory main text displayed in the center column.
/// - [contentAlignment]: Vertical alignment of all slots within the row ([OudsListItemContentAlignment]).
/// - [description]: Optional secondary text displayed below [label].
/// - [leading]: Optional leading content. Accepts [OudsSmallListItemLeadingIcon] or [OudsSmallListItemLeadingImage].
/// - [trailing]: Optional trailing content. Accepts [OudsSmallListItemTrailingIcon],
///   [OudsSmallListItemTrailingImage] or [OudsSmallListItemTrailingText].
/// - [divider]: Whether a horizontal divider is drawn below the item. Defaults to `true`.
/// - [background]: Whether the item has a persistent background color. Defaults to `true` (matches Android).
///   Set to `false` for navigation items where interaction feedback is preferred.
/// - [helperText]: Optional helper text displayed below the row (and below the divider).
/// - [boldLabel]: Whether [label] is rendered in bold. Defaults to `false`.
/// - [enable]: Whether the item is interactive. Defaults to `true`.
/// - [onTap]: Callback invoked when the item is tapped. When non-null the item becomes
///   a **navigation item** and displays an indicator chevron.
/// - [indicator]: Navigation indicator. Defaults to [OudsListItemDefaults.indicator].
///
/// ### Usage Example
///
/// ```dart
/// // Static compact item with a leading icon
/// OudsSmallListItem(
///   label: 'Compact item',
///   description: 'Secondary text',
///   leading: OudsSmallListItemLeadingIcon(Positive()),
/// );
///
/// // Navigation compact item
/// OudsSmallListItem(
///   label: 'Navigate',
///   background: false,
///   onTap: () => Navigator.of(context).push(…),
/// );
///
/// // Compact item with trailing text
/// OudsSmallListItem(
///   label: 'Item with price',
///   trailing: OudsSmallListItemTrailingText('99€'),
/// );
/// ```
class OudsSmallListItem extends StatelessWidget {
  /// The mandatory main text displayed in the center column.
  final String label;

  /// Vertical alignment of all slots within the row.
  ///
  /// Defaults to [OudsListItemDefaults.contentAlignment] ([OudsListItemContentAlignment.center]).
  final OudsListItemContentAlignment contentAlignment;

  /// Optional secondary text displayed below [label].
  final String? description;

  /// Optional content at the start of the row.
  ///
  /// Accepts [OudsSmallListItemLeadingIcon] or [OudsSmallListItemLeadingImage].
  /// Avatar, flag, video and text slots are not available at this compact size.
  final OudsSmallListItemLeading? leading;

  /// Optional content at the end of the row.
  ///
  /// Accepts [OudsSmallListItemTrailingIcon], [OudsSmallListItemTrailingImage]
  /// or [OudsSmallListItemTrailingText].
  final OudsSmallListItemTrailing? trailing;

  /// Whether a horizontal divider is drawn below the item. Defaults to `true`.
  final bool divider;

  /// Whether the item has a persistent background color.
  ///
  /// Defaults to `true` for static (read-only) items — matches the Android default.
  /// Note: this differs from [OudsListItem] which defaults to `false`, because
  /// [OudsSmallListItem] is primarily designed for static/read-only use cases.
  /// Set to `false` for navigation items where pressed/hover interaction feedback is preferred.
  final bool background;

  /// Optional helper text displayed below the row (and below the divider).
  final String? helperText;

  /// Whether [label] is rendered in bold. Defaults to `false`.
  final bool boldLabel;

  /// Whether the item is interactive. Defaults to `true`.
  ///
  /// When `false`, all content is rendered in its disabled appearance and
  /// [onTap] is ignored.
  final bool enable;

  /// Callback invoked when the item is tapped.
  ///
  /// When non-null the item becomes a **navigation item** and displays an indicator chevron.
  final VoidCallback? onTap;

  /// Navigation indicator. Defaults to [OudsListItemDefaults.indicator].
  final OudsListItemIndicator indicator;

  const OudsSmallListItem({
    super.key,
    required this.label,
    this.contentAlignment = OudsListItemDefaults.contentAlignment,
    this.description,
    this.leading,
    this.trailing,
    this.divider = true,
    this.background = true,
    this.helperText,
    this.boldLabel = false,
    this.enable = true,
    this.onTap,
    this.indicator = OudsListItemDefaults.indicator,
  });

  @override
  Widget build(BuildContext context) {
    return OudsListItem(
      label: label,
      size: OudsListItemSize.smallSize,
      contentAlignment: contentAlignment,
      description: description,
      leading: _adaptLeading(context, leading),
      trailing: _adaptTrailing(context, trailing),
      divider: divider,
      background: background,
      helperText: helperText,
      boldLabel: boldLabel,
      enable: enable,
      onTap: onTap,
      indicator: indicator,
    );
  }

  // -------------------------------------------------------------------------
  // Leading builder
  // -------------------------------------------------------------------------

  /// Adapts a [OudsSmallListItemLeading] to [OudsListItemLeading] by wrapping
  /// it in a [OudsListItemLeadingCustom] builder.
  ///
  /// Ensures consistent small asset sizing for all leading elements at this size variant.
  static OudsListItemLeading? _adaptLeading(
    BuildContext context,
    OudsSmallListItemLeading? small,
  ) {
    if (small == null) return null;
    return OudsListItemLeadingCustom(
      (ctx, {enable = true}) => _buildSmallLeading(ctx, small, enable: enable),
    );
  }

  /// Converts a [OudsSmallListItemLeading] data object into its rendered widget.
  ///
  /// Only supports icon and image variants (restricted API) at small asset size.
  /// Respects the [enable] state for color opacity adjustments.
  static Widget _buildSmallLeading(
    BuildContext context,
    OudsSmallListItemLeading leading, {
    required bool enable,
  }) {
    return switch (leading) {
      OudsSmallListItemLeadingIcon(:final iconStatus, :final tinted) =>
        OudsListItemAssetBuilder.buildIcon(
          context,
          iconStatus,
          enable: enable,
          size: _kSmallAssetSize,
          tinted: tinted,
        ),
      OudsSmallListItemLeadingImage(:final asset, :final format) =>
        OudsListItemAssetBuilder.buildImage(
          context,
          asset,
          _kSmallAssetSize,
          format,
        ),
    };
  }

  // -------------------------------------------------------------------------
  // Trailing builder
  // -------------------------------------------------------------------------

  /// Adapts a [OudsSmallListItemTrailing] to [OudsListItemTrailing] by wrapping
  /// it in a [OudsListItemTrailingCustom] builder.
  ///
  /// Ensures consistent small asset sizing for all trailing elements at this size variant.
  static OudsListItemTrailing? _adaptTrailing(
    BuildContext context,
    OudsSmallListItemTrailing? small,
  ) {
    if (small == null) return null;
    return OudsListItemTrailingCustom(
      (ctx, {enable = true}) => _buildSmallTrailing(ctx, small, enable: enable),
    );
  }

  /// Converts a [OudsSmallListItemTrailing] data object into its rendered widget.
  ///
  /// Only supports icon, image and text variants (restricted API) at small asset size.
  /// Respects the [enable] state for color opacity adjustments.
  static Widget _buildSmallTrailing(
    BuildContext context,
    OudsSmallListItemTrailing trailing, {
    required bool enable,
  }) {
    return switch (trailing) {
      OudsSmallListItemTrailingIcon(:final icon, :final tinted) =>
        OudsListItemAssetBuilder.buildIcon(
          context,
          icon,
          enable: enable,
          size: _kSmallAssetSize,
          tinted: tinted,
        ),
      OudsSmallListItemTrailingImage(:final asset, :final format) =>
        OudsListItemAssetBuilder.buildImage(
          context,
          asset,
          _kSmallAssetSize,
          format,
        ),
      OudsSmallListItemTrailingText(:final label, :final style) =>
        _buildSmallTrailingText(context, label, style, enable),
    };
  }

  /// Renders the text-trailing variant for [OudsSmallListItem].
  ///
  /// Maps text style (label, muted, strong) to appropriate colors and typography.
  /// Respects the [enable] state for opacity adjustments.
  static Widget _buildSmallTrailingText(
    BuildContext context,
    String label,
    OudsListItemTextStyle style,
    bool enable,
  ) {
    final typography = OudsTheme.of(context).typographyTokens;
    final foreground = OudsListItemForegroundModifier(context);
    final color = switch (style) {
      OudsListItemTextStyle.labelMuted => foreground.mutedColor(enable),
      OudsListItemTextStyle.label ||
      OudsListItemTextStyle.labelStrong => foreground.contentColor(enable),
    };
    final textStyle = switch (style) {
      OudsListItemTextStyle.label || OudsListItemTextStyle.labelMuted =>
        typography.typeLabelDefaultLarge(context),
      OudsListItemTextStyle.labelStrong => typography.typeLabelStrongLarge(
        context,
      ),
    };
    return Text(label, style: textStyle.copyWith(color: color));
  }
}
