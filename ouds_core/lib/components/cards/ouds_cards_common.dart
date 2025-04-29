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
import 'package:flutter_svg/flutter_svg.dart';

class OudsCardImage extends StatelessWidget {
  final dynamic image;
  final String contentDescription;
  final Alignment alignment;
  final BoxFit contentScale;
  final Color? backgroundColor;

  const OudsCardImage({
    super.key,
    required this.image,
    required this.contentDescription,
    this.alignment = Alignment.center,
    this.contentScale = BoxFit.cover,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: image.endsWith('.svg')
          ? SvgPicture.asset(
              image,
              fit: contentScale,
              alignment: alignment,
            )
          : Image.asset(
              image,
              fit: contentScale,
              alignment: alignment,
            ),
    );
  }
}
