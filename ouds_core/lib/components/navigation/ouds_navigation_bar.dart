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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/**
 * Height of OUDS navigation bar.
 */

final OudsNavigationBarHeight = 80.0;

class OudsNavigationBarItem extends StatefulWidget {
  final String icon;
  final String? label;
  final bool selected;
  final ValueChanged<bool>? onChanged;

  const OudsNavigationBarItem({
    required this.icon,
    this.label,
    this.selected = false,
    this.onChanged,
  });

  static Widget buildIcon(
    BuildContext context,
    String assetName,
  ) {
    final theme = OudsTheme.of(context);
    final bar = OudsTheme.of(context).componentsTokens(context).bar;
    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      height: theme.componentsTokens(context).button.sizeIconOnly,
      width: theme.componentsTokens(context).button.sizeIconOnly,
      colorFilter: ColorFilter.mode(
        bar.colorContentSelectedEnabled,
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
    final theme = OudsTheme.of(context);
    final bar = OudsTheme.of(context).componentsTokens(context).bar;

    return Container(
      color: Colors.blue,
      width: 100,
      height: 64.0,
      child: Column(
        children: [
          OudsNavigationBarItem.buildIcon(context, widget.icon),
          Text(
            widget.label!,
            style: theme.typographyTokens.typeLabelDefaultSmall(context).copyWith(
                  color: bar.colorContentSelectedEnabled,
                ),
          ),
        ],
      ),
    );
  }
}

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
    final bar = OudsTheme.of(context).componentsTokens(context).bar;

    return Container(
      color: Colors.red,
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.items.length,
          (index) => widget.items[index],
        ),
      ),
    );
  }
}
