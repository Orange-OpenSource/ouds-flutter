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
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_modifier.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/utilities/theme_utils.dart';

///
/// Height of OUDS navigation bar.
///

final OudsNavigationBarHeight = 80.0;

class OudsNavigationBarItem {
  final String icon;
  final String? label;
  final bool selected;
  final ValueChanged<bool>? onPressed;

  const OudsNavigationBarItem({
    required this.icon,
    this.label,
    this.selected = false,
    this.onPressed,
  });

  static Widget buildIcon(
    BuildContext context,
    String assetName,
    OudsNavigationBarControlState controlItemState,
    bool isSelected,
  ) {
    final theme = OudsTheme.of(context);
    final bar = OudsTheme.of(context).componentsTokens(context).bar;
    final navigationBarModifier = OudsNavigationBarStatusModifier(context);

    return SvgPicture.asset(
      excludeFromSemantics: true,
      assetName,
      fit: BoxFit.contain,
      height: theme.componentsTokens(context).button.sizeIconOnly,
      width: theme.componentsTokens(context).button.sizeIconOnly,
      colorFilter: ColorFilter.mode(
        navigationBarModifier.getTextItemColor(controlItemState, isSelected),
        BlendMode.srcIn,
      ),
    );
  }

  BottomNavigationBarItem build(BuildContext context) {
    bool _isHovered = false;
    bool _isFocused = false;
    bool _isPressed = false;

    final barStateDeterminer = OudsNavigationBarControlStateDeterminer(
      enabled: onPressed != null,
      isPressed: _isPressed,
      isHovered: _isHovered,
      isFocused: _isFocused,
    );
    final barControlState = barStateDeterminer.determineControlState();

    return BottomNavigationBarItem(
      icon: OudsNavigationBarItem.buildIcon(
        context,
        icon,
        barControlState,
        selected,
      ),
      label: label,
    );
  }
}

class OudsNavigationBar extends StatefulWidget {
  final List<OudsNavigationBarItem> items;
  final bool translucent;
  final ValueChanged<bool>? onPressed;

  const OudsNavigationBar({
    super.key,
    required this.items,
    this.translucent = false,
    this.onPressed,
  });

  @override
  State<OudsNavigationBar> createState() => _OudsNavigationBarState();
}

class _OudsNavigationBarState extends State<OudsNavigationBar> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;
  bool _isSelected = false;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;

    final barStateDeterminer = OudsNavigationBarControlStateDeterminer(
      enabled: _isSelected,
      isPressed: _isPressed || isPressed,
      isHovered: isHovered || _isHovered,
      isFocused: _isFocused,
    );

    final barControlState = barStateDeterminer.determineControlState();

    final bar = OudsTheme.of(context).componentsTokens(context).bar;
    final navigationBarModifier = OudsNavigationBarStatusModifier(context);

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: widget.items.map((item) => item.build(context)).toList(),
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      backgroundColor: widget.translucent
          ? ThemeUtils.isDarkTheme(context) == false
              ? bar.colorBgTranslucentLight
              : bar.colorBgTranslucentDark
          : bar.colorBgOpaque,
      selectedItemColor: navigationBarModifier.getTextItemColor(barControlState, true),
      unselectedItemColor: navigationBarModifier.getTextItemColor(barControlState, false),
    );
  }
}
