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
import 'package:ouds_core/components/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Constant defining the size of the avatar widget.
const double _avatarSize = 32.0;

/// A customizable avatar widget that displays either an image or a monogram.
///
/// This widget can be used to represent users or entities with either a profile image
/// or a monogram (initials) for the [OudsTopAppBar] component.
/// It supports click interactions and accessibility descriptions.
///
class OudsAvatar extends StatefulWidget {
  final String? image;
  final String? monogram;
  final Color? monogramColor;
  final Color? monogramBackgroundColor;
  final VoidCallback? onClick;
  final String? contentDescription;


  const OudsAvatar({
    super.key,
    this.image,
    this.monogram,
    this.monogramColor,
    this.monogramBackgroundColor,
    this.onClick,
    this.contentDescription
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
          onTap: (){
            widget.onClick?.call();
            },
          child: Center(
              child: _buildContent(),
          ),
      ),
    );
  }

  Widget _buildContent() {

    final backgroundColor = widget.monogramBackgroundColor ?? OudsTheme.of(context)
        .colorScheme(context).surfaceInverseHigh;
    return CircleAvatar(
          /// Sets the image for the avatar if 'image' is provided and 'monogram' is null.
          backgroundImage: widget.monogram == null && widget.image != null
                ? AssetImage(widget.image!)
                : null,
          /// Sets the background color if 'monogram' is provided and not empty.
        backgroundColor: (widget.monogram != null && widget.monogram!.isEmpty)
            ? backgroundColor
            : null,
          /// Displays the first letter of the monogram if provided and not empty.
          child: widget.monogram != null && widget.monogram!.isNotEmpty
              ? Container(
            width: _avatarSize,
                height: _avatarSize,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor
                ),
                child: Center(
                  child:  Text(
                    widget.monogram![0].toUpperCase(),
                    style: TextStyle(
                      color: widget.monogramColor ?? OudsTheme.of(context).colorScheme(context).contentInverse,
                      fontFamily: OudsTheme.of(context).fontFamily,
                    ),
                  ),
                ),
              )
              : null
    );
  }
}