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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

const double _avatarSize = 32.0;

class OudsAvatar extends StatefulWidget {
  final String? image;
  final String? monogram;
  final Color? monogramColor;
  final Color? monogramBackgroundColor;
  final VoidCallback? onClick;

  const OudsAvatar({
    super.key,
    this.image,
    this.monogram,
    this.monogramColor,
    this.monogramBackgroundColor,
    this.onClick,
  });

  @override
  State<OudsAvatar> createState() => _OudsAvatarState();
}

class _OudsAvatarState extends State<OudsAvatar> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _avatarSize,
      height: _avatarSize,
      child: InkWell(
          onTap: widget.onClick,
          child: Center(
              child: _buildContent(),
          ),
      ),
    );
  }

  Widget _buildContent() {

    return CircleAvatar(
            backgroundImage: widget.monogram == null && widget.image != null ? AssetImage(widget.image!) : null,
          backgroundColor: (widget.monogram != null && widget.monogram!.isEmpty)
              ? OudsTheme.of(context).colorScheme(context).surfaceInverseHigh
              : null,

          child: widget.monogram != null && widget.monogram!.isNotEmpty
              ? Text(
            widget.monogram![0].toUpperCase(),
            style: TextStyle(
              color: OudsTheme.of(context).colorScheme(context).alwaysWhite,
              fontFamily: OudsTheme.of(context).fontFamily,
            ),
          )
              : null);
  }
}