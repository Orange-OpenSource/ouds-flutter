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
import 'package:ouds_flutter_demo/ui/components/badge/badge_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _BadgeCustomization extends InheritedWidget {
  const _BadgeCustomization({
    required super.child,
    required this.data,
  });

  final BadgeCustomizationState data;

  @override
  bool updateShouldNotify(_BadgeCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class BadgeCustomization extends StatefulWidget {
  const BadgeCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  BadgeCustomizationState createState() => BadgeCustomizationState();

  static BadgeCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_BadgeCustomization>())?.data;
  }
}

class BadgeCustomizationState extends CustomizationWidgetState<BadgeCustomization> {
  late final SizeState sizeState;
  late final StatusState statusState;
  late final TypeState typeState;
  late final NumberTextState numberTextState;

  @override
  void initState() {
    super.initState();
    sizeState = SizeState(setState);
    statusState = StatusState(setState);
    typeState = TypeState(setState);
    numberTextState = NumberTextState(setState);
  }

  // size State Management
  BadgeEnumSize get selectedState => sizeState.selected;
  set selectedState(BadgeEnumSize value) => sizeState.selected = value;

  // type State Management
  BadgeEnumType get selectedType => typeState.selected;
  set selectedType(BadgeEnumType value) => typeState.selected = value;

  // Proxy getters and setters to expose state values directly
  BadgeEnumStatus get selectedStatus => statusState.selectedStatus;
  set selectedStatus(BadgeEnumStatus value) => statusState.selectedStatus = value;

  // Proxy getters and setters to expose the 'numberTextState' value directly.
  String get numberText => numberTextState.value;
  set numberText(String value) => numberTextState.value = value;

  int get selectedIndex => statusState.index;
  set selectedIndex(int value) => statusState.index = value;

  @override
  Widget build(BuildContext context) {
    return _BadgeCustomization(
      data: this,
      child: widget.child,
    );
  }
}

///  Size State Management
class SizeState {
  SizeState(this._setState);

  final void Function(void Function()) _setState;

  List<BadgeEnumSize> _size = [
    BadgeEnumSize.xsmall,
    BadgeEnumSize.small,
    BadgeEnumSize.medium,
    BadgeEnumSize.large,
  ];
  BadgeEnumSize _selectedSize = BadgeEnumSize.xsmall;

  List<BadgeEnumSize> get list => _size;
  set list(List<BadgeEnumSize> newList) {
    _setState(() {
      _size = newList;
    });
  }

  BadgeEnumSize get selected => _selectedSize;
  set selected(BadgeEnumSize newValue) {
    _setState(() {
      _selectedSize = newValue;
    });
  }
}

/// Status State Management
class StatusState {
  StatusState(this._setState);

  final void Function(void Function()) _setState;

  List<BadgeEnumStatus> _status = [
    BadgeEnumStatus.negative,
    BadgeEnumStatus.accent,
    BadgeEnumStatus.positive,
    BadgeEnumStatus.info,
    BadgeEnumStatus.warning,
    BadgeEnumStatus.neutral,
    BadgeEnumStatus.disabled,
  ];

  BadgeEnumStatus _selectedStatus = BadgeEnumStatus.negative;
  int _selectedIndex = 0;

  List<BadgeEnumStatus> get list => _status;
  set list(List<BadgeEnumStatus> newList) {
    _setState(() {
      _status = newList;
    });
  }

  BadgeEnumStatus get selectedStatus => _selectedStatus;
  set selectedStatus(BadgeEnumStatus newValue) {
    _setState(() {
      _selectedStatus = newValue;
    });
  }

  int get index => _selectedIndex;
  set index(int newValue) {
    _setState(() {
      _selectedIndex = newValue;
    });
  }
}

///  type Management
class TypeState {
  TypeState(this._setType);

  final void Function(void Function()) _setType;

  List<BadgeEnumType> _type = [
    BadgeEnumType.standard,
    BadgeEnumType.icon,
    BadgeEnumType.count,
  ];
  BadgeEnumType _selectedType = BadgeEnumType.standard;

  List<BadgeEnumType> get list => _type;
  set list(List<BadgeEnumType> newList) {
    _setType(() {
      _type = newList;
    });
  }

  BadgeEnumType get selected => _selectedType;
  set selected(BadgeEnumType newValue) {
    _setType(() {
      _selectedType = newValue;
    });
  }
}

/// Number Text State Management
class NumberTextState {
  NumberTextState(this._setState);

  final void Function(void Function()) _setState;
  String _numberTextValue = "";

  String get value => _numberTextValue;
  set value(String newValue) {
    _setState(() {
      _numberTextValue = newValue;
    });
  }
}
