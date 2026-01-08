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
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _TopAppBarCustomization extends InheritedWidget {
  const _TopAppBarCustomization({
    required super.child,
    required this.data,
  });

  final TopAppBarCustomizationState data;

  @override
  bool updateShouldNotify(_TopAppBarCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class TopAppBarCustomization extends StatefulWidget {
  const TopAppBarCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  TopAppBarCustomizationState createState() => TopAppBarCustomizationState();

  static TopAppBarCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_TopAppBarCustomization>())?.data;
  }
}

class TopAppBarCustomizationState extends CustomizationWidgetState<TopAppBarCustomization> {
  late final SizeState sizeState;
  late final NavigationIconTypeState iconTypeState;
  late final ActionIconBadgeState actionIconBadgeState;
  late final TitleTextState titleTextState;
  late final ActionAvatarState actionAvatarState;
  late final ActionAvatarMonogramTextState actionAvatarMonogramTextState;
  late final ActionCountState actionCountState;
  late final ShowAvatarState showAvatarState;

  @override
  void initState() {
    super.initState();
    sizeState = SizeState(setState);
    iconTypeState = NavigationIconTypeState(setState);
    actionIconBadgeState = ActionIconBadgeState(setState);
    titleTextState = TitleTextState(setState);
    actionAvatarState = ActionAvatarState(setState);
    actionAvatarMonogramTextState = ActionAvatarMonogramTextState(setState);
    actionCountState = ActionCountState(setState);
    showAvatarState = ShowAvatarState(setState);

  }

  // size State Management
  TopAppBarSizeEnum get selectedSize => sizeState.selected;

  set selectedSize(TopAppBarSizeEnum value) {
    sizeState.selected = value;
  }

  // icon type State Management
  NavigationIconTypeEnum get selectedIconType => iconTypeState.selected;

  set selectedIconType(NavigationIconTypeEnum value) {
    iconTypeState.selected = value;
  }

  // action icon badge State Management
  ActionIconBadgeEnum get selectedIconBadge => actionIconBadgeState.selected;

  set selectedIconBadge(ActionIconBadgeEnum value) {
    actionIconBadgeState.selected = value;
  }

  String get titleText => titleTextState.value;
  set titleText(String value) => titleTextState.value = value;

  // action avatar State Management
  ActionAvatarEnum get selectedActionAvatar => actionAvatarState.selected;

  set selectedActionAvatar(ActionAvatarEnum value) {
    actionAvatarState.selected = value;
  }

  String get actionAvatarMonogramText => actionAvatarMonogramTextState.value;
  set actionAvatarMonogramText(String value) => actionAvatarMonogramTextState.value = value;

  // action avatar State Management
  ActionCountEnum get selectedActionCount => actionCountState.selected;

  set selectedActionCount(ActionCountEnum value) {
    actionCountState.selected = value;
  }

  bool get showAvatar => showAvatarState.value;
  set showAvatar(bool value) => showAvatarState.value = value;

  @override
  Widget build(BuildContext context) {
    return _TopAppBarCustomization(
      data: this,
      child: widget.child,
    );
  }
}


///  Size State Management
class SizeState {
  SizeState(this._setState);

  final void Function(void Function()) _setState;

  List<TopAppBarSizeEnum> _size = [
    TopAppBarSizeEnum.small,
    TopAppBarSizeEnum.medium,
    TopAppBarSizeEnum.large,
  ];
  TopAppBarSizeEnum _selectedSize = TopAppBarSizeEnum.small;

  List<TopAppBarSizeEnum> get list => _size;
  set list(List<TopAppBarSizeEnum> newList) {
    _setState(() {
      _size = newList;
    });
  }

  TopAppBarSizeEnum get selected => _selectedSize;
  set selected(TopAppBarSizeEnum newValue) {
    _setState(() {
      _selectedSize = newValue;
    });
  }
}

/// Status State Management
class ActionIconBadgeState {
  ActionIconBadgeState(this._setActionIconBadgeState);

  late final void Function(void Function()) _setActionIconBadgeState;

  List<ActionIconBadgeEnum> _actionIconBadgeList = [
    ActionIconBadgeEnum.none,
    ActionIconBadgeEnum.standard,
    ActionIconBadgeEnum.count,

  ];

  ActionIconBadgeEnum _selectedStatus = ActionIconBadgeEnum.none;

  List<ActionIconBadgeEnum> get list => _actionIconBadgeList;
  set list(List<ActionIconBadgeEnum> newList) {
    _setActionIconBadgeState(() {
      _actionIconBadgeList = newList;
    });
  }

  ActionIconBadgeEnum get selected => _selectedStatus;
  set selected(ActionIconBadgeEnum newValue) {
    _setActionIconBadgeState(() {
      _selectedStatus = newValue;
    });
  }

}

///  navigation icon type Management
class NavigationIconTypeState {
  NavigationIconTypeState(this._setIconType);

  final void Function(void Function()) _setIconType;

  List<NavigationIconTypeEnum> _iconType = [
    NavigationIconTypeEnum.none,
    NavigationIconTypeEnum.back,
    NavigationIconTypeEnum.close,
    NavigationIconTypeEnum.menu,
    NavigationIconTypeEnum.custom,

  ];
  NavigationIconTypeEnum _selectedType = NavigationIconTypeEnum.none;

  List<NavigationIconTypeEnum> get list => _iconType;
  set list(List<NavigationIconTypeEnum> newList) {
    _setIconType(() {
      _iconType = newList;
    });
  }

  NavigationIconTypeEnum get selected => _selectedType;
  set selected(NavigationIconTypeEnum newValue) {
    _setIconType(() {
      _selectedType = newValue;
    });
  }
}

/// TitleText State Management
class TitleTextState {
  TitleTextState(this._setState);

  final void Function(void Function()) _setState;
  String _titleTextValue = "Title";

  String get value => _titleTextValue;
  set value(String newValue) {
    _setState(() {
      _titleTextValue = newValue;
    });
  }
}

///  action avatar type Management
class ActionAvatarState {
  ActionAvatarState(this._setActionAvatarState);

  late final void Function(void Function()) _setActionAvatarState;

  List<ActionAvatarEnum> _actionAvatarList = [
    ActionAvatarEnum.image,
    ActionAvatarEnum.monogram,
  ];

  ActionAvatarEnum _selectedStatus = ActionAvatarEnum.image;

  List<ActionAvatarEnum> get list => _actionAvatarList;
  set list(List<ActionAvatarEnum> newList) {
    _setActionAvatarState(() {
      _actionAvatarList = newList;
    });
  }

  ActionAvatarEnum get selected => _selectedStatus;
  set selected(ActionAvatarEnum newValue) {
    _setActionAvatarState(() {
      _selectedStatus = newValue;
    });
  }
}

/// Action avatar monogram text State Management
class ActionAvatarMonogramTextState {
  ActionAvatarMonogramTextState(this._setState);

  final void Function(void Function()) _setState;
  String _monogramTextValue = "";

  String get value => _monogramTextValue;
  set value(String newValue) {
    _setState(() {
      _monogramTextValue = newValue;
    });
  }
}

///  action count type Management
class ActionCountState {
  ActionCountState(this._setActionCountState);

  late final void Function(void Function()) _setActionCountState;

  List<ActionCountEnum> _actionCountList = [
    ActionCountEnum.zero,
    ActionCountEnum.one,
    ActionCountEnum.two,
    ActionCountEnum.three,
  ];

  ActionCountEnum _selectedCount = ActionCountEnum.one;

  List<ActionCountEnum> get list => _actionCountList;
  set list(List<ActionCountEnum> newList) {
    _setActionCountState(() {
      _actionCountList = newList;
    });
  }

  ActionCountEnum get selected => _selectedCount;
  set selected(ActionCountEnum newValue) {
    _setActionCountState(() {
      _selectedCount = newValue;
    });
  }
}


/// Show avatar State Management
class ShowAvatarState {
  ShowAvatarState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasAvatar = false;

  bool get value => _hasAvatar;
  set value(bool newValue) {
    _setState(() {
      _hasAvatar = newValue;
    });
  }
}