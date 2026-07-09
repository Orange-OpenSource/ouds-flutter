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

/// Base sealed class for the leading slot of an [OudsListItem].
///
/// Each subclass is a **data class** — it holds configuration only.
/// Rendering is handled by `_buildLeading` inside [OudsListItem].
sealed class OudsListItemLeading {
  const OudsListItemLeading();
}

/// Leading icon slot.
///
/// Example:
/// ```dart
/// OudsListItemLeadingIcon(Neutral(icon: 'assets/icons/star.svg'))
/// OudsListItemLeadingIcon(Positive(), size: OudsListItemIconSize.large, tinted: false)
/// ```
class OudsListItemLeadingIcon extends OudsListItemLeading {
  final OudsIconStatus iconStatus;

  /// Size of the icon. Defaults to [OudsListItemIconSize.medium].
  final OudsListItemIconSize size;

  /// Whether the icon is tinted with the theme color.
  /// Set to `false` for multicolor icons.
  final bool tinted;

  const OudsListItemLeadingIcon(
    this.iconStatus, {
    this.size = OudsListItemIconSize.medium,
    this.tinted = true,
  });
}

/// Leading image slot.
///
/// Example:
/// ```dart
/// OudsListItemLeadingImage(
///   asset: AssetImage('assets/images/photo.jpg'),
///   size: OudsListItemImageSize.large,
///   format: OudsListItemImageFormat.panoramic,
/// )
/// ```
class OudsListItemLeadingImage extends OudsListItemLeading {
  final ImageProvider asset;

  /// Size of the image. Defaults to [OudsListItemImageSize.medium].
  final OudsListItemImageSize size;

  /// Aspect-ratio format. Defaults to [OudsListItemImageFormat.square].
  final OudsListItemImageFormat format;

  const OudsListItemLeadingImage({
    required this.asset,
    this.size = OudsListItemImageSize.medium,
    this.format = OudsListItemImageFormat.square,
  });
}

/// Leading flag slot.
///
/// Example:
/// ```dart
/// OudsListItemLeadingFlag(asset: AssetImage('assets/flags/fr.png'))
/// ```
class OudsListItemLeadingFlag extends OudsListItemLeading {
  final ImageProvider asset;
  const OudsListItemLeadingFlag({required this.asset});
}

/// Leading video placeholder slot.
///
/// Example:
/// ```dart
/// OudsListItemLeadingVideo(Uri.parse('https://example.com/video.mp4'))
/// ```
class OudsListItemLeadingVideo extends OudsListItemLeading {
  final Uri url;
  const OudsListItemLeadingVideo(this.url);
}

/// Leading avatar slot.
///
/// Example:
/// ```dart
/// OudsListItemLeadingAvatar(OudsAvatar(monogram: 'JD'))
/// ```
class OudsListItemLeadingAvatar extends OudsListItemLeading {
  final OudsAvatar avatar;
  const OudsListItemLeadingAvatar(this.avatar);
}

/// Leading text slot — renders a label and an optional extra-label.
///
/// Example:
/// ```dart
/// OudsListItemLeadingText('99€', extraLabel: 'TTC', style: OudsListItemTextStyle.labelStrong)
/// ```
class OudsListItemLeadingText extends OudsListItemLeading {
  final String label;
  final String? extraLabel;

  /// Style of the text. Defaults to [OudsListItemTextStyle.label].
  final OudsListItemTextStyle style;

  const OudsListItemLeadingText(
    this.label, {
    this.extraLabel,
    this.style = OudsListItemTextStyle.label,
  });
}

/// A custom leading slot with a widget builder function.
///
/// Used internally by [OudsSmallListItem] to adapt its own leading types.
class OudsListItemLeadingCustom extends OudsListItemLeading {
  final Widget Function(BuildContext context, {bool enable}) builder;
  const OudsListItemLeadingCustom(this.builder);
}
