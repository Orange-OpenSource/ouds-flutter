//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';

///
/// A leading icon in an [OusChip].
///
/// Creates an instance of [OudsChipLeadingIcon].
/// * [image] - Text to be displayed into the chip
/// * [contentDescription] - Callback called on chip click.
///
class OudsChipLeadingIcon extends StatelessWidget {
  const OudsChipLeadingIcon(this.image, this.contentDescription, {super.key});

  /// The image associated to this [OudsChipLeadingAvatar].
  final ImageProvider<Object> image;

  /// The content description associated to this [OudsChipLeadingAvatar].
  final String? contentDescription;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
      semanticLabel: contentDescription,
    );
  }
}

///
/// A leading icon in an [OudsChip].
///
/// Creates an instance of [OudsChipLeadingAvatar].
/// * [image] - Text to be displayed into the chip
/// * [contentDescription] - Callback called on chip click.
///
class OudsChipLeadingAvatar extends StatelessWidget {
  const OudsChipLeadingAvatar({
    super.key,
    required this.image,
    this.contentDescription,
  });

  /// The image associated to this [OudsChipLeadingAvatar].
  final ImageProvider<Object> image;

  /// The content description associated to this [OudsChipLeadingAvatar].
  final String? contentDescription;

  @override
  Widget build(BuildContext context) {
    Widget circleAvatar = CircleAvatar(
      backgroundImage: image,
      radius: 12,
      backgroundColor: Colors.transparent,
    );

    if (contentDescription != null) {
      circleAvatar = Semantics(
        label: contentDescription!,
        image: true,
        child: circleAvatar,
      );
    }

    return circleAvatar;
  }
}
