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

/// Base sealed class for the leading slot of an [OudsListItem].
///
/// Each subclass is a **data class** — it holds configuration only.
/// Rendering is handled by `_buildLeading` inside [OudsListItem].
sealed class OudsListItemLeading {
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
  final OudsIconStatus iconStatus;

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
///   rounded: true,
/// )
/// ```
class OudsListItemLeadingImage extends OudsListItemLeading {
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

  const OudsListItemLeadingImage({
    required this.asset,
    this.size = OudsListItemImageSize.medium,
    this.format = OudsListItemImageFormat.square,
    this.rounded = false,
  });
}

/// Leading flag slot — renders an [OudsFlag] on the leading side of the row.
///
/// Pass a pre-configured [OudsFlag] instance with the desired country code and size.
/// The flag size is automatically constrained to match the list item token dimensions,
/// so prefer [OudsFlagSize.small] or [OudsFlagSize.medium] here.
///
/// Example:
/// ```dart
/// OudsListItemLeadingFlag(OudsFlag('fr'))
/// OudsListItemLeadingFlag(OudsFlag('us', semanticsLabel: 'United States flag'))
/// ```
class OudsListItemLeadingFlag extends OudsListItemLeading {
  /// The flag widget to display.
  final OudsFlag flag;

  const OudsListItemLeadingFlag(this.flag);
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
///
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
