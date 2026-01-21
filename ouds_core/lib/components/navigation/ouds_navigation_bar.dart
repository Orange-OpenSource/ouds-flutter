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
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/navigation/OudsNavigationBarItem.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_modifier.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/utilities/theme_utils.dart';

/// Height of OUDS navigation bar.
const double OudsNavigationBarHeight = 80.0;

class OudsNavigationBar extends StatefulWidget {
  final List<OudsNavigationBarItem> items;
  final bool translucent;
  final bool selected;
  final int initialIndex;
  final ValueChanged<int>? onPressed;

  const OudsNavigationBar({
    super.key,
    required this.items,
    this.translucent = false,
    this.selected = false,
    this.initialIndex = 0,
    this.onPressed,
  });

  @override
  State<OudsNavigationBar> createState() => _OudsNavigationBarState();
}

class _OudsNavigationBarState extends State<OudsNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, widget.items.length - 1);
  }

  @override
  void didUpdateWidget(covariant OudsNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex) {
      _selectedIndex = widget.initialIndex.clamp(0, widget.items.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;

    final barStateDeterminer = OudsNavigationBarControlStateDeterminer(
      enabled: widget.onPressed != null,
      isPressed: isPressed,
      isHovered: isHovered,
    );

    final barControlState = barStateDeterminer.determineControlState();
    final navigationBarModifier = OudsNavigationBarStatusModifier(context);
    final bar = OudsTheme.of(context).componentsTokens(context).bar;

    final safeIndex = _selectedIndex.clamp(0, widget.items.length - 1);

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (states) {
            final isSelected = states.contains(WidgetState.selected);
            return OudsTheme.of(context).typographyTokens.typeLabelDefaultMedium(context).copyWith(
                  color: navigationBarModifier.getTextItemColor(barControlState, isSelected),
                );
          },
        ),
      ),
      child: NavigationBar(
        height: OudsNavigationBarHeight,
        selectedIndex: safeIndex,
        indicatorColor: Colors.transparent,
        backgroundColor: widget.translucent
            ? ThemeUtils.isDarkTheme(context)
                ? bar.colorBgTranslucentDark
                : bar.colorBgTranslucentLight
            : bar.colorBgOpaque,
        destinations: List.generate(
          widget.items.length,
          (index) => widget.items[index].build(
            context,
            isSelected: index == safeIndex,
          ),
        ),
        onDestinationSelected: (index) {
          if (index == safeIndex) return;
          setState(() => _selectedIndex = index);
          widget.onPressed?.call(index);
        },
      ),
    );
  }
}
