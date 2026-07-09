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
/// Example:
/// ```dart
/// OudsListItemTrailingIcon(Positive())
/// OudsListItemTrailingIcon(Neutral(icon: 'assets/star.svg'), size: OudsListItemIconSize.large)
/// ```
class OudsListItemTrailingIcon extends OudsListItemTrailing {
  final OudsIconStatus icon;

  /// Size of the icon. Defaults to [OudsListItemIconSize.medium].
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
/// )
/// ```
class OudsListItemTrailingImage extends OudsListItemTrailing {
  final ImageProvider asset;

  /// Size of the image. Defaults to [OudsListItemImageSize.medium].
  final OudsListItemImageSize size;

  /// Aspect-ratio format. Defaults to [OudsListItemImageFormat.square].
  final OudsListItemImageFormat format;

  const OudsListItemTrailingImage({
    required this.asset,
    this.size = OudsListItemImageSize.medium,
    this.format = OudsListItemImageFormat.square,
  });
}

/// Trailing flag slot — renders a flag image with token-defined dimensions.
///
/// Example:
/// ```dart
/// OudsListItemTrailingFlag(asset: AssetImage('assets/flags/fr.png'))
/// ```
class OudsListItemTrailingFlag extends OudsListItemTrailing {
  final ImageProvider asset;
  const OudsListItemTrailingFlag({required this.asset});
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
