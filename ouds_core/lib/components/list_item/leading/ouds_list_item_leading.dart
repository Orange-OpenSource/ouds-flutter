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
import 'package:ouds_core/components/list_item/ouds_list_item_avatar.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

sealed class OudsListItemLeading {
  const OudsListItemLeading();

  /// Converts this leading type to a [Widget].
  /// When [enable] is `false`, content is rendered in its disabled appearance.
  Widget toWidget(BuildContext context, {bool enable = true});
}

class OudsListItemLeadingIcon extends OudsListItemLeading {
  final OudsIconStatus iconStatus;

  const OudsListItemLeadingIcon(this.iconStatus);

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    return OudsListItemIconModifier(context).buildIcon(iconStatus, enable: enable);
  }
}

class OudsListItemLeadingImage extends OudsListItemLeading {
  final ImageProvider asset;

  const OudsListItemLeadingImage({required this.asset});

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    final size = OudsTheme.of(context).componentsTokens(context).listItem.sizeAssetMedium;
    return Image(image: asset, width: size, height: size);
  }
}

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
    return SizedBox(
      width: 28,
      height: 28,
      child: Icon(Icons.play_circle_outline, color: color),
    );
  }
}

class OudsListItemLeadingAvatar extends OudsListItemLeading {
  final OudsListItemAvatar avatar;

  const OudsListItemLeadingAvatar(this.avatar);

  @override
  Widget toWidget(BuildContext context, {bool enable = true}) {
    return switch (avatar) {
      OudsListItemAvatarImage(:final image) => CircleAvatar(
        radius: 14,
        backgroundImage: image,
      ),
      OudsListItemAvatarInitials(:final initials) => CircleAvatar(
        radius: 14,
        child: Text(initials),
      ),
      OudsListItemAvatarIcon() => const CircleAvatar(
        radius: 14,
        child: Icon(Icons.person_outline, size: 16),
      ),
    };
  }
}
