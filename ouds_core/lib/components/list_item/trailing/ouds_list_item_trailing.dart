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

import 'package:flutter/widgets.dart';
import 'package:ouds_core/components/avatar/ouds_avatar.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';

sealed class OudsListItemTrailing {
  const OudsListItemTrailing();
}

// ---------------------------------------------------------------------------
// Text trailing
// ---------------------------------------------------------------------------

sealed class OudsListItemTrailingTextType {
  const OudsListItemTrailingTextType();
}

class OudsListItemTrailingLabel extends OudsListItemTrailingTextType {
  final String text;

  const OudsListItemTrailingLabel(this.text);
}

class OudsListItemTrailingLabelMuted extends OudsListItemTrailingTextType {
  final String text;

  const OudsListItemTrailingLabelMuted(this.text);
}

class OudsListItemTrailingLabelStrong extends OudsListItemTrailingTextType {
  final String text;

  const OudsListItemTrailingLabelStrong(this.text);
}

class OudsListItemTrailingLabelAndExtraLabel
    extends OudsListItemTrailingTextType {
  final String text;
  final String extraLabel;

  const OudsListItemTrailingLabelAndExtraLabel(this.text, this.extraLabel);
}

class OudsListItemTrailingText extends OudsListItemTrailing {
  final OudsListItemTrailingTextType textType;

  const OudsListItemTrailingText(this.textType);
}

// ---------------------------------------------------------------------------
// Badge & tag trailing (builder pattern forwards enable state)
// ---------------------------------------------------------------------------

/// Trailing badge slot.
///
/// Accepts a builder `Widget Function(bool enable)` so the list item can
/// forward its own `enable` state directly into the badge's `enabled` parameter.
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
/// Accepts a builder `Widget Function(bool enable)` so the list item can
/// forward its own `enable` state directly into the tag's `enabled` parameter.
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
// Icon trailing
// ---------------------------------------------------------------------------

/// Trailing icon slot.
///
/// Renders an [OudsIconStatus] icon with optional size and tinting control.
///
/// Example:
/// ```dart
/// OudsListItemTrailingIcon(Positive())
/// OudsListItemTrailingIcon(Neutral(icon: 'assets/icons/star.svg'), size: OudsListItemIconSize.large, tinted: false)
/// ```
class OudsListItemTrailingIcon extends OudsListItemTrailing {
  final OudsIconStatus icon;

  /// Size of the icon. Defaults to [OudsListItemIconSize.medium].
  final OudsListItemIconSize size;

  /// Whether the icon should be tinted with the theme color.
  ///
  /// Set to `false` for multicolor icons. Untinted icons must ensure
  /// sufficient contrast with the background for accessibility reasons.
  final bool tinted;

  const OudsListItemTrailingIcon(
    this.icon, {
    this.size = OudsListItemIconSize.medium,
    this.tinted = true,
  });
}

// ---------------------------------------------------------------------------
// Image & flag & video trailing
// ---------------------------------------------------------------------------

/// Trailing image slot.
///
/// Renders an image with a configurable [size] and [format] (square or panoramic).
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

  /// Aspect-ratio format of the image. Defaults to [OudsListItemImageFormat.square].
  final OudsListItemImageFormat format;

  const OudsListItemTrailingImage({
    required this.asset,
    this.size = OudsListItemImageSize.medium,
    this.format = OudsListItemImageFormat.square,
  });
}

class OudsListItemTrailingFlag extends OudsListItemTrailing {
  final ImageProvider asset;

  const OudsListItemTrailingFlag({required this.asset});
}

class OudsListItemTrailingVideo extends OudsListItemTrailing {
  final Uri url;
  final bool autoplay;
  final bool muted;
  final bool tapToTogglePlay;
  final bool tapToToggleMute;

  const OudsListItemTrailingVideo(
    this.url, {
    this.autoplay = false,
    this.muted = true,
    this.tapToTogglePlay = false,
    this.tapToToggleMute = false,
  });
}

// ---------------------------------------------------------------------------
// Avatar trailing
// ---------------------------------------------------------------------------

/// Trailing avatar slot.
///
/// Renders an [OudsAvatar] component. Pass a pre-configured [OudsAvatar] instance.
///
/// Example:
/// ```dart
/// OudsListItemTrailingAvatar(OudsAvatar(monogram: 'JD'))
/// OudsListItemTrailingAvatar(OudsAvatar(image: 'assets/images/profile.jpg'))
/// ```
class OudsListItemTrailingAvatar extends OudsListItemTrailing {
  final OudsAvatar avatar;

  const OudsListItemTrailingAvatar(this.avatar);
}

/// A custom trailing slot that accepts a widget builder function.
///
/// Allows content that doesn't fit any predefined trailing type.
/// Used internally by [OudsSmallListItem] to adapt its own trailing types.
class OudsListItemTrailingCustom extends OudsListItemTrailing {
  final Widget Function(BuildContext context, {bool enable}) builder;

  const OudsListItemTrailingCustom(this.builder);
}
