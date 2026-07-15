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
import 'package:ouds_core/components/avatar/ouds_avatar.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/flag/ouds_flag.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';

/// Base sealed class for the trailing slot of an [OudsListItem].
///
/// Each subclass is a **data class** — it holds configuration only.
/// Rendering is handled by `_buildTrailing` inside [OudsListItem].
sealed class OudsListItemTrailing {
  const OudsListItemTrailing();
}

// ---------------------------------------------------------------------------
// Text
// ---------------------------------------------------------------------------

/// Discriminates between the text style variants for [OudsListItemTrailingText].
sealed class OudsListItemTrailingTextType {
  const OudsListItemTrailingTextType();
}

/// Default label style on the trailing side.
class OudsListItemTrailingLabel extends OudsListItemTrailingTextType {
  final String text;
  const OudsListItemTrailingLabel(this.text);
}

/// Muted (secondary) label style on the trailing side.
class OudsListItemTrailingLabelMuted extends OudsListItemTrailingTextType {
  final String text;
  const OudsListItemTrailingLabelMuted(this.text);
}

/// Bold (strong) label style on the trailing side.
class OudsListItemTrailingLabelStrong extends OudsListItemTrailingTextType {
  final String text;
  const OudsListItemTrailingLabelStrong(this.text);
}

/// Stacked label + extra-label on the trailing side.
class OudsListItemTrailingLabelAndExtraLabel
    extends OudsListItemTrailingTextType {
  final String text;
  final String extraLabel;
  const OudsListItemTrailingLabelAndExtraLabel(this.text, this.extraLabel);
}

/// Trailing text slot — renders a single or stacked text using [textType].
///
/// Example:
/// ```dart
/// OudsListItemTrailingText(OudsListItemTrailingLabel('99€'))
/// OudsListItemTrailingText(OudsListItemTrailingLabelAndExtraLabel('99€', 'TTC'))
/// ```
class OudsListItemTrailingText extends OudsListItemTrailing {
  final OudsListItemTrailingTextType textType;
  const OudsListItemTrailingText(this.textType);
}

// ---------------------------------------------------------------------------
// Badge & tag
// ---------------------------------------------------------------------------

/// Trailing badge slot.
///
/// Accepts a `Widget Function(bool enable)` builder so the list item can
/// forward its own `enable` state into the badge's `enabled` parameter.
///
/// Example:
/// ```dart
/// OudsListItemTrailingBadge(
///   (enable) => OudsBadge.standard(status: Info(), semanticsLabel: 'badge', enabled: enable),
/// )
/// ```
class OudsListItemTrailingBadge extends OudsListItemTrailing {
  final Widget Function(bool enable) badge;
  const OudsListItemTrailingBadge(this.badge);
}

/// Trailing tag slot.
///
/// Accepts a `Widget Function(bool enable)` builder so the list item can
/// forward its own `enable` state into the tag's `enabled` parameter.
///
/// Example:
/// ```dart
/// OudsListItemTrailingTag(
///   (enable) => OudsTag.text(label: 'Label', status: Positive(), enabled: enable),
/// )
/// ```
class OudsListItemTrailingTag extends OudsListItemTrailing {
  final Widget Function(bool enable) tag;
  const OudsListItemTrailingTag(this.tag);
}

// ---------------------------------------------------------------------------
// Icon
// ---------------------------------------------------------------------------

/// Trailing icon slot.
///
/// Use an icon to reinforce the meaning of the item or help users identify
/// a familiar category, object or status.
///
/// Example:
/// ```dart
/// OudsListItemTrailingIcon(Positive())
/// OudsListItemTrailingIcon(Neutral(icon: 'assets/star.svg'), size: OudsListItemIconSize.large)
/// ```
class OudsListItemTrailingIcon extends OudsListItemTrailing {
  final OudsIconStatus icon;

  /// Size of the icon. Defaults to [OudsListItemIconSize.medium].
  ///
  /// - [OudsListItemIconSize.medium]: Preferred for standard and compact items
  ///   when the icon provides secondary visual support.
  /// - [OudsListItemIconSize.large]: Use when the icon needs stronger prominence
  ///   or when the item has multiline content or additional information.
  final OudsListItemIconSize size;

  /// Whether the icon is tinted with the theme color.
  /// Set to `false` for multicolor icons.
  final bool tinted;

  const OudsListItemTrailingIcon(
    this.icon, {
    this.size = OudsListItemIconSize.medium,
    this.tinted = true,
  });
}

// ---------------------------------------------------------------------------
// Image, flag & video
// ---------------------------------------------------------------------------

/// Trailing image slot.
///
/// Example:
/// ```dart
/// OudsListItemTrailingImage(
///   asset: AssetImage('assets/images/photo.jpg'),
///   size: OudsListItemImageSize.large,
///   format: OudsListItemImageFormat.panoramic,
///   rounded: true,
/// )
/// ```
class OudsListItemTrailingImage extends OudsListItemTrailing {
  final ImageProvider asset;

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
  /// - [OudsListItemImageFormat.panoramic] (16:9): Use for landscape content
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

  const OudsListItemTrailingImage({
    required this.asset,
    this.size = OudsListItemImageSize.medium,
    this.format = OudsListItemImageFormat.square,
    this.rounded = false,
  });
}

/// Trailing flag slot — renders an [OudsFlag] on the trailing side of the row.
///
/// Pass a pre-configured [OudsFlag] instance with the desired country code and size.
///
/// Example:
/// ```dart
/// OudsListItemTrailingFlag(OudsFlag('fr'))
/// OudsListItemTrailingFlag(OudsFlag('gb', semanticsLabel: 'United Kingdom flag'))
/// ```
class OudsListItemTrailingFlag extends OudsListItemTrailing {
  /// The flag widget to display.
  final OudsFlag flag;

  const OudsListItemTrailingFlag(this.flag);
}

/// Trailing video slot — renders a play-icon placeholder using token-defined size.
class OudsListItemTrailingVideo extends OudsListItemTrailing {
  final Uri url;
  const OudsListItemTrailingVideo(this.url);
}

// ---------------------------------------------------------------------------
// Avatar
// ---------------------------------------------------------------------------

/// Trailing avatar slot.
///
/// Example:
/// ```dart
/// OudsListItemTrailingAvatar(OudsAvatar(monogram: 'JD'))
/// ```
class OudsListItemTrailingAvatar extends OudsListItemTrailing {
  final OudsAvatar avatar;
  const OudsListItemTrailingAvatar(this.avatar);
}

// ---------------------------------------------------------------------------
// Custom
// ---------------------------------------------------------------------------

/// A custom trailing slot with a widget builder function.
///
/// Used internally by [OudsSmallListItem] to adapt its own trailing types.
class OudsListItemTrailingCustom extends OudsListItemTrailing {
  final Widget Function(BuildContext context, {bool enable}) builder;
  const OudsListItemTrailingCustom(this.builder);
}
