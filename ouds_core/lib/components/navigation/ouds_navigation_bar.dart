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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/**
 * Height of OUDS navigation bar.
 */

final OudsNavigationBarHeight = 80;

class OudsNavigationBar extends StatefulWidget {
  final List<OudsNavigationBarItem> items;

  const OudsNavigationBar({
    super.key,
    required this.items,
  });

  @override
  State<OudsNavigationBar> createState() => _OudsNavigationBarState();
}

class _OudsNavigationBarState extends State<OudsNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: []);
  }
}

class OudsNavigationBarItem extends StatefulWidget {
  final String icon;
  final String? label;
  final bool selected;
  final Colors? backgroundColor;
  final ValueChanged<bool>? onChanged;

  const OudsNavigationBarItem({
    super.key,
    required this.icon,
    this.label,
    this.selected = false,
    this.backgroundColor,
    this.onChanged,
  });

  static Widget buildIcon(
    BuildContext context,
    String assetName,
    bool isError,
  ) {
    final theme = OudsTheme.of(context);
    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      height: theme.componentsTokens(context).textInput.sizeLeadingIcon,
      width: theme.componentsTokens(context).textInput.sizeLeadingIcon,
      colorFilter: ColorFilter.mode(
        Colors.red,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsNavigationBarItem> createState() => _OudsNavigationBarItemState();
}

class _OudsNavigationBarItemState extends State<OudsNavigationBarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
