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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_foreground_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_icon_modifier.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
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

  Widget _toWidget(BuildContext context, {bool enable = true});
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
  final OudsIconStatus iconStatus;

  /// Whether the icon should be tinted with the theme color.
  /// Set to `false` for multicolor icons.
  final bool tinted;

  const OudsSmallListItemLeadingIcon(this.iconStatus, {this.tinted = true});

  @override
  Widget _toWidget(BuildContext context, {bool enable = true}) {
    return OudsListItemIconModifier(context).buildIcon(
      iconStatus,
      enable: enable,
      size: _kSmallAssetSize,
      tinted: tinted,
    );
  }
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
  final ImageProvider asset;

  /// Aspect-ratio format. Defaults to [OudsListItemImageFormat.square].
  final OudsListItemImageFormat format;

  const OudsSmallListItemLeadingImage({
    required this.asset,
    this.format = OudsListItemImageFormat.square,
  });

  @override
  Widget _toWidget(BuildContext context, {bool enable = true}) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    final height = _kSmallAssetSize.value(tokens);
    final width = height * format.ratio;
    return Image(image: asset, width: width, height: height, fit: BoxFit.cover);
  }
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

  Widget _toWidget(BuildContext context, {bool enable = true});
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
  final OudsIconStatus icon;

  /// Whether the icon should be tinted with the theme color.
  /// Set to `false` for multicolor icons.
  final bool tinted;

  const OudsSmallListItemTrailingIcon(this.icon, {this.tinted = true});

  @override
  Widget _toWidget(BuildContext context, {bool enable = true}) {
    return OudsListItemIconModifier(context).buildIcon(
      icon,
      enable: enable,
      size: _kSmallAssetSize,
      tinted: tinted,
    );
  }
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
  final ImageProvider asset;

  /// Aspect-ratio format. Defaults to [OudsListItemImageFormat.square].
  final OudsListItemImageFormat format;

  const OudsSmallListItemTrailingImage({
    required this.asset,
    this.format = OudsListItemImageFormat.square,
  });

  @override
  Widget _toWidget(BuildContext context, {bool enable = true}) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    final height = _kSmallAssetSize.value(tokens);
    final width = height * format.ratio;
    return Image(image: asset, width: width, height: height, fit: BoxFit.cover);
  }
}

/// Trailing text slot for [OudsSmallListItem].
///
/// Example:
/// ```dart
/// OudsSmallListItemTrailingText('99€')
/// OudsSmallListItemTrailingText('Inactive', style: OudsListItemTextStyle.labelMuted)
/// ```
class OudsSmallListItemTrailingText extends OudsSmallListItemTrailing {
  final String label;

  /// Text style. Defaults to [OudsListItemTextStyle.label].
  final OudsListItemTextStyle style;

  const OudsSmallListItemTrailingText(
    this.label, {
    this.style = OudsListItemTextStyle.label,
  });

  @override
  Widget _toWidget(BuildContext context, {bool enable = true}) {
    final typography = OudsTheme.of(context).typographyTokens;
    final foreground = OudsListItemForegroundModifier(context);
    final isMuted = style == OudsListItemTextStyle.labelMuted;
    final color =
        isMuted ? foreground.mutedColor(enable) : foreground.contentColor(enable);
    final textStyle = switch (style) {
      OudsListItemTextStyle.labelStrong =>
        typography.typeLabelStrongLarge(context),
      _ => typography.typeLabelDefaultLarge(context),
    };
    return Text(label, style: textStyle.copyWith(color: color));
  }
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

/// A compact variant of [OudsListItem] locked to [OudsListItemSize.smallSize].
///
/// Compared to [OudsListItem]:
/// - **No** [overline] or [extraLabel] — only [label] and [description].
/// - Leading restricted to [OudsSmallListItemLeadingIcon] and
///   [OudsSmallListItemLeadingImage].
/// - Trailing restricted to [OudsSmallListItemTrailingIcon],
///   [OudsSmallListItemTrailingImage] and [OudsSmallListItemTrailingText].
/// - All icons/images are rendered at [OudsListItemAssetSize.small].
///
/// **Static variant** (no [onTap]):
/// ```dart
/// OudsSmallListItem(
///   label: 'Compact item',
///   description: 'Secondary text',
///   leading: OudsSmallListItemLeadingIcon(Positive()),
/// )
/// ```
///
/// **Navigation variant** (with [onTap]):
/// ```dart
/// OudsSmallListItem(
///   label: 'Navigate',
///   onTap: () => Navigator.of(context).push(…),
/// )
/// ```
class OudsSmallListItem extends StatelessWidget {
  final String label;
  final OudsListItemContentAlignment contentAlignment;
  final String? description;
  final OudsSmallListItemLeading? leading;
  final OudsSmallListItemTrailing? trailing;

  /// Decoration controlling background and divider. Defaults to
  /// [OudsListItemDecorationNone] (divider shown).
  final OudsListItemDecoration decoration;

  final String? helperText;
  final bool boldLabel;
  final bool enable;

  /// Callback invoked when the item is tapped.
  ///
  /// When non-null the item becomes a **navigation item** and displays an
  /// [indicator] chevron.
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
    this.decoration = OudsListItemDefaults.decoration,
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
      leading: _adaptLeading(leading),
      trailing: _adaptTrailing(trailing),
      decoration: decoration,
      helperText: helperText,
      boldLabel: boldLabel,
      enable: enable,
      onTap: onTap,
      indicator: indicator,
    );
  }

  OudsListItemLeading? _adaptLeading(OudsSmallListItemLeading? small) {
    if (small == null) return null;
    return OudsListItemLeadingCustom(
      (ctx, {enable = true}) => small._toWidget(ctx, enable: enable),
    );
  }

  OudsListItemTrailing? _adaptTrailing(OudsSmallListItemTrailing? small) {
    if (small == null) return null;
    return OudsListItemTrailingCustom(
      (ctx, {enable = true}) => small._toWidget(ctx, enable: enable),
    );
  }
}
