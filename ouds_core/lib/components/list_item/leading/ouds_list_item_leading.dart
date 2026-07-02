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
import 'package:ouds_core/components/avatar/ouds_avatar.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_foreground_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_icon_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

sealed class OudsListItemLeading {
  const OudsListItemLeading();

  /// Converts this leading type to a [Widget].
  /// When [enable] is `false`, content is rendered in its disabled appearance.
  Widget toWidget(BuildContext context, {bool enable = true});
}

/// Leading icon slot.
///
/// Renders an [OudsIconStatus] icon with optional size and tinting control.
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

  /// Whether the icon should be tinted with the theme color.
  ///
  /// Set to `false` for multicolor icons. Untinted icons must ensure
  /// sufficient contrast with the background for accessibility reasons.
  final bool tinted;

  const OudsListItemLeadingIcon(
    this.iconStatus, {
    this.size = OudsListItemIconSize.medium,
    this.tinted = true,
  });

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    return OudsListItemIconModifier(
      context,
    ).buildIcon(iconStatus, enable: enable, size: size.assetSize, tinted: tinted);
  }
}

/// Leading image slot.
///
/// Renders an image with a configurable [size] and [format] (square or panoramic).
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

  /// Aspect-ratio format of the image. Defaults to [OudsListItemImageFormat.square].
  final OudsListItemImageFormat format;

  const OudsListItemLeadingImage({
    required this.asset,
    this.size = OudsListItemImageSize.medium,
    this.format = OudsListItemImageFormat.square,
  });

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    final height = size.assetSize.value(tokens);
    final width = height * format.ratio;
    return Image(image: asset, width: width, height: height, fit: BoxFit.cover);
  }
}

/// Leading flag slot.
///
/// Renders a flag image with rounded corners using the token-defined dimensions.
///
/// Example:
/// ```dart
/// OudsListItemLeadingFlag(asset: AssetImage('assets/flags/fr.png'))
/// ```
class OudsListItemLeadingFlag extends OudsListItemLeading {
  final ImageProvider asset;

  const OudsListItemLeadingFlag({required this.asset});

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Image(
        image: asset,
        width: tokens.sizeAssetMedium,
        height: tokens.sizeFlagHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}

/// Leading video slot.
///
/// Renders a video placeholder icon whose color is resolved from OUDS tokens —
/// [contentDefault] when enabled, [contentDisabled] when disabled.
///
/// Example:
/// ```dart
/// OudsListItemLeadingVideo(Uri.parse('https://example.com/video.mp4'))
/// ```
class OudsListItemLeadingVideo extends OudsListItemLeading {
  final Uri url;

  const OudsListItemLeadingVideo(this.url);

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    final color = OudsListItemForegroundModifier(context).contentColor(enable);
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    final size = tokens.sizeAssetMedium;
    return SizedBox(
      width: size,
      height: size,
      child: Icon(Icons.play_circle_outline, color: color),
    );
  }
}

/// Leading avatar slot.
///
/// Renders an [OudsAvatar] component. Pass a pre-configured [OudsAvatar] instance.
///
/// Example:
/// ```dart
/// OudsListItemLeadingAvatar(OudsAvatar(monogram: 'JD'))
/// OudsListItemLeadingAvatar(OudsAvatar(image: 'assets/images/profile.jpg'))
/// ```
class OudsListItemLeadingAvatar extends OudsListItemLeading {
  final OudsAvatar avatar;

  const OudsListItemLeadingAvatar(this.avatar);

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    return avatar;
  }
}

/// Leading text slot.
///
/// Renders a text value (and optional extra label) on the leading side of the
/// list item, typically used for secondary identifiers like prices or codes.
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

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    final typography = OudsTheme.of(context).typographyTokens;
    final foreground = OudsListItemForegroundModifier(context);
    final isLabel = style != OudsListItemTextStyle.labelMuted;
    final color = isLabel
        ? foreground.contentColor(enable)
        : foreground.mutedColor(enable);
    final textStyle = switch (style) {
      OudsListItemTextStyle.label || OudsListItemTextStyle.labelMuted =>
        typography.typeLabelDefaultLarge(context),
      OudsListItemTextStyle.labelStrong => typography.typeLabelStrongLarge(
        context,
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle.copyWith(color: color)),
        if (extraLabel != null)
          Text(
            extraLabel!,
            style: typography
                .typeLabelStrongLarge(context)
                .copyWith(color: foreground.contentColor(enable)),
          ),
      ],
    );
  }
}

/// A custom leading slot that accepts a widget builder function.
///
/// Allows content that doesn't fit any predefined leading type.
/// Used internally by [OudsSmallListItem] to adapt its own leading types.
class OudsListItemLeadingCustom extends OudsListItemLeading {
  final Widget Function(BuildContext context, {bool enable}) _builder;

  const OudsListItemLeadingCustom(this._builder);

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) =>
      _builder(context, enable: enable);
}
