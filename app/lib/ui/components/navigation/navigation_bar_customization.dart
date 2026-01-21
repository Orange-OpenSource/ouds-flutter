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
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _NavigationBarCustomization extends InheritedWidget {
  const _NavigationBarCustomization({
    required super.child,
    required this.data,
  });

  final NavigationBarCustomizationState data;

  @override
  bool updateShouldNotify(_NavigationBarCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class NavigationBarCustomization extends StatefulWidget {
  const NavigationBarCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  NavigationBarCustomizationState createState() => NavigationBarCustomizationState();

  static NavigationBarCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_NavigationBarCustomization>())?.data;
  }
}

class NavigationBarCustomizationState extends CustomizationWidgetState<NavigationBarCustomization> {
  late final ItemBadgeState itemBadgeState;
  late final ItemSelectedState itemSelectedState;

  @override
  void initState() {
    super.initState();
    itemBadgeState = ItemBadgeState(setState);
    itemSelectedState = ItemSelectedState(setState);
  }

  // type State Management
  ItemBadge get selectedItemBadge => itemBadgeState.selected;
  set selectedItemBadge(ItemBadge value) {
    itemBadgeState.selected = value;
  }

  // Proxy getters and setters to expose the 'countTextState' value directly.
  int get itemSelected => itemSelectedState.value;
  set itemSelected(int value) => itemSelectedState.value = value;

  @override
  Widget build(BuildContext context) {
    return _NavigationBarCustomization(
      data: this,
      child: widget.child,
    );
  }
}

class ItemSelectedState {
  ItemSelectedState(this._setState);

  final void Function(void Function()) _setState;
  int _countTextValue = 3;

  int get value => _countTextValue;

  set value(int newValue) {
    _setState(() {
      _countTextValue = newValue;
    });
  }
}

///  Action Icon Badge Management
class ItemBadgeState {
  ItemBadgeState(this._setItemBadgeState);

  late final void Function(void Function()) _setItemBadgeState;

  List<ItemBadge> _itemBadgeList = [
    ItemBadge.none,
    ItemBadge.standard,
    ItemBadge.count,
  ];

  ItemBadge _selectedType = ItemBadge.none;

  List<ItemBadge> get list => _itemBadgeList;
  set list(List<ItemBadge> newList) {
    _setItemBadgeState(() {
      _itemBadgeList = newList;
    });
  }

  ItemBadge get selected => _selectedType;
  set selected(ItemBadge newValue) {
    _setItemBadgeState(() {
      _selectedType = newValue;
    });
  }
}
