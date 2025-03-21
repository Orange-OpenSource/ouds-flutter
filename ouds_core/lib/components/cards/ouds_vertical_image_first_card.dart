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
import 'package:ouds_core/components/cards/ouds_cards_common.dart';
import 'package:ouds_core/ouds_theme.dart';

/// OUDS Vertical image first card with optional custom content.
/// Allows displaying either an image or a custom widget inside the card.
class OudsVerticalImageFirstCard extends StatelessWidget {
  /// Creates an OUDS vertical image first card.
  const OudsVerticalImageFirstCard({
    super.key,
    required this.title,
    this.image,
    this.child,
    this.onClick,
  });

  static const double _imageHeight = 184;

  /// The optional image displayed in the card.
  final OudsCardImage? image;

  /// The optional custom widget displayed inside the card.
  final Widget? child;

  /// The card's title displayed below the image or custom content.
  final String title;

  /// The action executed on card tap.
  final Function()? onClick;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);

    return Card.outlined(
      elevation: 3,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: onClick,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: SizedBox(
                  width: double.infinity,
                  height: _imageHeight,
                  child: image,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: theme.fontTokens.sizeHeadingMediumMobile,
                    letterSpacing: theme.fontTokens.letterSpacingHeadingMediumMobile,
                    fontWeight: theme.fontTokens.weightLabelStrong,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
