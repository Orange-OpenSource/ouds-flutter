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

enum OudsListItemAvatarSize { medium, large, extraLarge }

sealed class OudsListItemAvatar {
  const OudsListItemAvatar();
}

class OudsListItemAvatarImage extends OudsListItemAvatar {
  final ImageProvider image;

  const OudsListItemAvatarImage(this.image);
}

class OudsListItemAvatarInitials extends OudsListItemAvatar {
  final String initials;

  const OudsListItemAvatarInitials(this.initials);
}

class OudsListItemAvatarIcon extends OudsListItemAvatar {
  const OudsListItemAvatarIcon();
}
