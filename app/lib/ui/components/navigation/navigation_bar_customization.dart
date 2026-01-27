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
  /// Manages the current badge type (none/dot/count) for the configured destination.
  late final ItemBadgeState itemBadgeState;

  /// Manages the currently selected destination index.
  late final ItemSelectedState itemSelectedState;

  @override
  void initState() {
    super.initState();
    itemBadgeState = ItemBadgeState(setState);
    itemSelectedState = ItemSelectedState(setState);
  }

  /// Selected badge type for the demo configuration.
  ItemBadge get selectedItemBadge => itemBadgeState.selected;
  set selectedItemBadge(ItemBadge value) {
    itemBadgeState.selected = value;
  }

  /// Proxy getters and setters to expose the [itemSelected] value directly.  int get itemSelected => itemSelectedState.value;
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

/// Simple state holder for the selected destination index.
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

/// Badge configuration state for navigation destinations.
class ItemBadgeState {
  ItemBadgeState(this._setItemBadgeState);

  late final void Function(void Function()) _setItemBadgeState;

  /// Available badge types exposed by the demo.
  List<ItemBadge> _itemBadgeList = [
    ItemBadge.none,
    ItemBadge.dot,
    ItemBadge.count,
  ];

  /// Currently selected badge type.
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
