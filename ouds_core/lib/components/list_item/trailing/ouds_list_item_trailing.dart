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
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/ouds_list_item_avatar.dart';

sealed class OudsListItemTrailing {
  const OudsListItemTrailing();
}

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

class OudsListItemTrailingBadge extends OudsListItemTrailing {
  final Widget badge;

  const OudsListItemTrailingBadge(this.badge);
}

class OudsListItemTrailingTag extends OudsListItemTrailing {
  final Widget tag;

  const OudsListItemTrailingTag(this.tag);
}

class OudsListItemTrailingIcon extends OudsListItemTrailing {
  final OudsIconStatus icon;

  const OudsListItemTrailingIcon(this.icon);
}

class OudsListItemTrailingImage extends OudsListItemTrailing {
  final ImageProvider asset;

  const OudsListItemTrailingImage({required this.asset});
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

class OudsListItemTrailingAvatar extends OudsListItemTrailing {
  final OudsListItemAvatar avatar;

  const OudsListItemTrailingAvatar(this.avatar);
}
