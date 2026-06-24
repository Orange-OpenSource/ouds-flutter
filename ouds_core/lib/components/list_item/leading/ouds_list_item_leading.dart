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
import 'package:ouds_core/components/list_item/internal/ouds_list_item_leading_modifier.dart';
import 'package:ouds_core/components/list_item/ouds_list_item_avatar.dart';

sealed class OudsListItemLeading {
  const OudsListItemLeading();

  /// Méthode pour convertir en widget
  Widget toWidget(BuildContext context);
}

class OudsListItemLeadingIcon extends OudsListItemLeading {
  final OudsIconStatus iconStatus;

  const OudsListItemLeadingIcon(this.iconStatus);

  @override
  Widget toWidget(BuildContext context) {
    final leadingModifier = OudsListItemLeadingModifier(context);

    return leadingModifier.buildLeadingIcon(context, iconStatus);
  }
}

class OudsListItemLeadingImage extends OudsListItemLeading {
  final ImageProvider asset;

  const OudsListItemLeadingImage({required this.asset});

  Widget toWidget(BuildContext context) {
    return Image(
      image: asset,
      width: 28,
      height: 28,
    ); // ajustez la taille selon besoin
  }
}

class OudsListItemLeadingFlag extends OudsListItemLeading {
  final ImageProvider asset;

  const OudsListItemLeadingFlag({required this.asset});

  @override
  Widget toWidget(BuildContext context) {
    // TODO: implement toWidget
    throw UnimplementedError();
  }
}

class OudsListItemLeadingVideo extends OudsListItemLeading {
  final Uri url;
  final bool autoplay;
  final bool muted;
  final bool tapToTogglePlay;
  final bool tapToToggleMute;

  const OudsListItemLeadingVideo(
    this.url, {
    this.autoplay = false,
    this.muted = true,
    this.tapToTogglePlay = false,
    this.tapToToggleMute = false,
  });

  @override
  Widget toWidget(BuildContext context) {
    // TODO: implement toWidget
    throw UnimplementedError();
  }
}

class OudsListItemLeadingAvatar extends OudsListItemLeading {
  final OudsListItemAvatar avatar;

  const OudsListItemLeadingAvatar(this.avatar);

  @override
  Widget toWidget(BuildContext context) {
    // TODO: implement toWidget
    throw UnimplementedError();
  }
}
