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

class OudsNavigationBarItem {
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

  BottomNavigationBarItem build(BuildContext context) {
    return BottomNavigationBarItem(
      icon: OudsNavigationBarItem.buildIcon(context, icon),
      label: label,
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

    return OudsNavigationBar(
      items: List.generate(
        widget.items.length,
        (index) => widget.items[index],
      ),
    );
  }
}
